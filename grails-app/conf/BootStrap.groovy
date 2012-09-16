import studentcloud.Exercice;
import studentcloud.UnitTest

class BootStrap {

	def init = { servletContext ->
		environments {
			development {
				def exercice1 = new Exercice(question:"L'appel à incrémente doit augmenter nombre de 1", code:"""class A {
  private int nombre = 0;
  
  public void incremente() {
  	// à implémenter!
  }
  
  public int getNombre() {
  	return nombre;
  }
}""").save(flush:true)
				def test1 = new UnitTest(code:"""A a = new A();
a.incremente();
check(a.getNombre()==1,"new A().inc() est egal à 1","new A().inc() n'est pas egal à 1");
""", exercice:exercice1).save(flush:true);

				def exercice2 = new Exercice(question:"La méthode \"calcul\" doit calculer le PGCD de a et de b!", code:"""class PGCD {
  
  public int calcul(int a, int b) {
    // compléter le code de cette méthode!
  	return 0;
  }
}""").save(flush:true)
				def test2 = new UnitTest(code:"""PGCD pgcd = new PGCD();
check(pgcd.calcul(10,20)==10,"le pgcd de 10 et 20 est bien 10!", "le pgcd de 10 et 20 doit être 10!");
""", exercice:exercice2).save(flush:true);
				def test3 = new UnitTest(code:"""PGCD pgcd = new PGCD();
check(pgcd.calcul(23,3)==1,"le pgcd de 23 et 3 est bien 1, car 23 est un nombre premier!",
	  "le pgcd de 23 avec tout nombre doit être 1: 23 est un nombre premier!");
""", exercice:exercice2).save(flush:true);

			}
		}
	}
	def destroy = {
	}
}
