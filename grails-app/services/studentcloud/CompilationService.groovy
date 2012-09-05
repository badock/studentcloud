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

	def addLineToSnippetConsole(snippet, line) {
		if(snippet != null) {			
			snippet.trace += line +"<br/>"
			snippet.save(flush:true)
			sleep 10
		}
	}

	def compile(snippet) {

		File folder = new File("tmp/toto")

		if(!folder.exists()){
			folder.mkdirs();
		}

		File sourceFile   = new File("tmp/toto/Test"+snippet.id+".java");
		FileWriter writer = new FileWriter(sourceFile);

		writer.write(snippet.getTestCode());
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

			Method thisMethod = thisClass.getDeclaredMethod("run", PrintStream.class);

			URLClassLoader classLoader = (URLClassLoader)ClassLoader.getSystemClassLoader();
			classLoader.addURL(new File("lib/junit-4.10.jar").toURL());

			def executionFinished = false

			PipedInputStream inp = new PipedInputStream();
			PipedOutputStream outp = new PipedOutputStream(inp);


			BufferedReader buffin = new BufferedReader(new InputStreamReader(inp));

			snippet.trace = ""
			snippet.isRunning = true
			snippet.save(flush:true)

			def th = Thread.start {
				String line = null;
				while((line = buffin.readLine()) != null) {
					Snippet.withTransaction {
						addLineToSnippetConsole(snippet, line)						
					}
				}

				
				Snippet.withTransaction {
					snippet.isRunning = false
					snippet.save(flush:true)
				}
				buffin.close()
			}

			thisMethod.invoke(null, new PrintStream(outp));

			executionFinished = true
			snippet.save(flush:true)
			
			System.out.println("Execution OK!")
		}
		else {
			System.out.println("Failed");
		}
	}
}