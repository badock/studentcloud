
package toto;

import java.io.PrintStream;

public class Test1 {

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

			class A {
  private int nombre = 0;
  
  public void incremente() {
  	// à implémenter!
    nombre += 1;
    sysout.println("message visible dans la console!");
  }
  
  public int getNombre() {
  	return nombre;
  }
}
	
	

	public void test0() {
		A a = new A();
a.incremente();
check(a.getNombre()==1,"new A().inc() est egal à 1","new A().inc() n'est pas egal à 1");

    }


	public static void run(PrintStream testOut, PrintStream sysout) {
		Test1.testOut = testOut;
		Test1.sysout = sysout;

		Test1 test = new Test1();
		
	test.test0();

		Test1.testOut.close();
		Test1.sysout.close();
	}
		 
}
