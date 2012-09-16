
		package toto;
		
		import java.io.PrintStream;
		
		public class Test2 {

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
  	nombre +=1;
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
		Test2.testOut = testOut;
				Test2.sysout = sysout;

		Test2 test = new Test2();
				
	test.test0();
		
		Test2.testOut.close();
				Test2.sysout.close();
	}
		 
}
