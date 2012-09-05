package studentcloud

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Arrays;
import java.util.Locale;

import javax.tools.Diagnostic;
import javax.tools.DiagnosticListener;
import javax.tools.JavaCompiler;
import javax.tools.JavaFileObject;
import javax.tools.SimpleJavaFileObject;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;
import javax.tools.StandardLocation;
import java.net.URLClassLoader;

import java.io.PipedInputStream;
import java.io.PipedOutputStream;

import groovy.transform.*;

class CompilationService {

	private static String classOutputFolder = "/classes/demo";

	public static class MyDiagnosticListener implements DiagnosticListener<JavaFileObject>
	{
		public void report(Diagnostic<? extends JavaFileObject> diagnostic)
		{

			System.out.println("Line Number->" + diagnostic.getLineNumber()+"("+diagnostic.getKind()+")");
			System.out.println("code->" + diagnostic.getCode());
			System.out.println("Message->"
					+ diagnostic.getMessage(Locale.ENGLISH));
			System.out.println("Source->" + diagnostic.getSource());
			System.out.println(" ");
		}
	}


	/** java File Object represents an in-memory java source file <br>
	 * so there is no need to put the source file on hard disk  **/
	public static class InMemoryJavaFileObject extends SimpleJavaFileObject
	{
		private String contents = null;

		public InMemoryJavaFileObject(String className, String contents) throws Exception
		{
			super(URI.create(className), JavaFileObject.Kind.SOURCE);
			this.contents = contents;
		}

		public CharSequence getCharContent(boolean ignoreEncodingErrors)
		throws IOException
		{
			return contents;
		}
	}
	
	class QuickLock {
		
		@WithWriteLock
		public void waitForLock(){
			
		}
	}
	
	def addLineToSnippetConsole(snippet, traceline, consoleline) {
		if(snippet != null) {			
			snippet.trace = traceline		
			snippet.console = consoleline
			snippet.save(flush:true)
		}
	}

	def compile(snippet) {

		File folder = new File("tmp/toto")

		if(!folder.exists()){
			folder.mkdirs();
		}

		File sourceFile   = new File("tmp/toto/Test"+snippet.id+".java");
		FileWriter writer = new FileWriter(sourceFile);

		// redirect "manually" System.out to the sysout output stream
		writer.write(snippet.getTestCode().replaceAll("System.out", "sysout"));
		writer.close();

		// for compilation diagnostic message processing on compilation WARNING/ERROR
		MyDiagnosticListener c = new MyDiagnosticListener();

		JavaCompiler compiler    = ToolProvider.getSystemJavaCompiler();
		StandardJavaFileManager fileManager =
				compiler.getStandardFileManager(c, null, null);


		// Compile the file


		//specify classes output folder
		Iterable options =  Arrays.asList();

		compiler.getTask(null,
				fileManager,
				null,
				options,
				null,
				fileManager.getJavaFileObjectsFromFiles(Arrays.asList(sourceFile)))
				.call();
		fileManager.close();

		JavaCompiler.CompilationTask task = compiler.getTask(null, fileManager,
				c, options, null,
				fileManager.getJavaFileObjectsFromFiles(Arrays.asList(sourceFile)));


		//fileManager.close();

		Boolean result = task.call();
		if (result == true)
		{
			System.out.println("Succeeded");

			def params = {};
			def paramsObj = [];

			//			Class thisClass = Class.forName("toto.Test"+snippet.id);

			File classFile = new File("tmp/")
			URL[] classUrls = Arrays.asList( classFile.toURL())
			URLClassLoader loader = new URLClassLoader(classUrls)
			Class thisClass = loader.loadClass("toto.Test"+snippet.id);
			Object iClass = thisClass.newInstance();

			Method thisMethod = thisClass.getDeclaredMethod("run", PrintStream.class, PrintStream.class);

			URLClassLoader classLoader = (URLClassLoader)ClassLoader.getSystemClassLoader();
			classLoader.addURL(new File("lib/junit-4.10.jar").toURL());

			def executionFinished = false

			PipedInputStream inp = new PipedInputStream();
			PipedOutputStream outp = new PipedOutputStream(inp);
			BufferedReader buffin = new BufferedReader(new InputStreamReader(inp));
			
			PipedInputStream sysinp = new PipedInputStream();
			PipedOutputStream sysoutp = new PipedOutputStream(sysinp);
			BufferedReader buffSysIn = new BufferedReader(new InputStreamReader(sysinp));

			

			snippet.trace = ""
			snippet.console = ""
			snippet.isRunning = true
			snippet.save(flush:true)

			int finished = 0
			
			def sysLock = new QuickLock()
			def testLock = new QuickLock()
			
			String testOutComplete = ""
			String consoleOutComplete = ""
			String testOutChanges = ""
			String consoleOutChanges = ""
			
			
			
			def thtest = Thread.start {
				String line = null;
				
				while((line = buffin.readLine()) != null) {
					testOutChanges += line+"<br/>"
					testOutComplete += line+"<br/>"
					
					sleep(30)
				}
				
				finished++	
				buffin.close()
				//println("STOP TEST")
			}
			
			def thsys = Thread.start {
				String line = null;
				
				while((line = buffSysIn.readLine()) != null) {
					consoleOutChanges += line+"<br/>"
					consoleOutComplete += line+"<br/>"
					
					sleep(30)
				}				
				
				finished++				
				buffSysIn.close()
				
				//println("STOP SYS")
			}
			
			def thSnippetUpdator = Thread.start {
				
				while(finished<2 || testOutChanges != "" || consoleOutChanges != "" && !executionFinished) {
					sleep(50)
					if(testOutChanges != "" || consoleOutChanges != "") {
												
						Snippet.withTransaction {
							addLineToSnippetConsole(snippet, testOutComplete, consoleOutComplete)
						}
						
						testOutChanges = ""
						consoleOutChanges = ""
						
						sleep(100)
					}
				}
				
				//println("STOP ENVOI")
				
				Snippet.withTransaction {
					snippet.isRunning = false
					snippet.save(flush:true)
				}
			}
			
			
			def thExecution = Thread.start {				
				thisMethod.invoke(null, new PrintStream(outp), new PrintStream(sysoutp));
				executionFinished = true
			}
			
			System.out.println("Execution OK!")
		}
		else {
			System.out.println("Failed");
		}
	}
}