package studentcloud

class Snippet {

	String code
	String trace

	boolean isRunning = false

	static belongsTo = [exercice:Exercice]

	static constraints = {
	}

	static mapping = {
		code type: 'text'
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

		public static PrintStream out;

		public void check(boolean b, String okMessage, String koMessage) {
			if(b) {
				out.println("[SUCCESS]"+okMessage);
			}
			else {
				out.println("[FAILURE]"+koMessage);
			}
		}

			"""+code+"""
	
	"""+junitString+"""

	public static void run(PrintStream out) {
		Test"""+id+""".out = out;

		Test"""+id+""" test = new Test"""+id+"""();
		"""+junitStringCall+"""
	}
		 
}
"""
	}
}
