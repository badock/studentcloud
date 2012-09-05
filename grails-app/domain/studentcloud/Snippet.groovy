package studentcloud

class Snippet {

	String code
	String trace
	String console

	boolean isRunning = false

	static belongsTo = [exercice:Exercice]

	static constraints = {
	}

	static mapping = {
		code type: 'text'
		trace type: 'text'
		console type: 'text'
	}

	String getTestCode() {

		String junitString = ""
		int cpt = 0
		if(exercice != null) {
			exercice.tests.every {
				junitString += """

	public void test"""+cpt+"""() {
		"""+it.code+"""
    }
"""
			}
		}

		String junitStringCall = ""
		int cpt2 = 0
		if(exercice != null) {
			exercice.tests.every {
				junitStringCall += """
	test.test"""+cpt2+"""();
"""

			}
		}

		return """
package toto;

import java.io.PrintStream;

public class Test"""+id+""" {

		public static PrintStream testOut;
		public static PrintStream sysout;

		public void check(boolean b, String okMessage, String koMessage) {
			if(b) {
				testOut.println("[SUCCESS]"+okMessage);
			}
			else {
				testOut.println("[FAILURE]"+koMessage);
			}
		}

			"""+code+"""
	
	"""+junitString+"""

	public static void run(PrintStream testOut, PrintStream sysout) {
		Test"""+id+""".testOut = testOut;
		Test"""+id+""".sysout = sysout;

		Test"""+id+""" test = new Test"""+id+"""();
		"""+junitStringCall+"""
		Test"""+id+""".testOut.close();
		Test"""+id+""".sysout.close();
	}
		 
}
"""
	}
}
