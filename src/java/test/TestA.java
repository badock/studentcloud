package test;

import org.junit.*;

public class TestA {

	class A {
		public String s;
		
		public void test() {
			s =  "Helloworld!";
		}
	}
	
	@org.junit.Test
	public void testOne() {
        // Code that tests one thing
		A a = new A();
		a.test();
		assert(a.s.equals("Helloworld!"));
    }
 
}
