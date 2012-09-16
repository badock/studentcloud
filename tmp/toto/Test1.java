
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

			class PGCD {
  
  public int calcul(int a, int b) {
    if(b>a) {
      return calcul(b,a);
    }
    else if(a%b==0) {
      return b;
    }
    else {
      return calcul(a-b,b);
    }
  }
}
			
			

	public void test0() {
								PGCD pgcd = new PGCD();
check(pgcd.calcul(10,20)==10,"le pgcd de 10 et 20 est bien 10!", "le pgcd de 10 et 20 doit être 10!");

    }


	public void test1() {
								PGCD pgcd = new PGCD();
check(pgcd.calcul(23,3)==1,"le pgcd de 23 et 3 est bien 1, car 23 est un nombre premier!",
	  "le pgcd de 23 avec tout nombre doit être 1: 23 est un nombre premier!");

    }


	public static void run(PrintStream testOut, PrintStream sysout) {
		Test1.testOut = testOut;
				Test1.sysout = sysout;

		Test1 test = new Test1();
				
	test.test0();
		
	test.test1();
		
		Test1.testOut.close();
				Test1.sysout.close();
	}
		 
}
