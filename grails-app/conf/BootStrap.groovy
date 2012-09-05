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
			}
		}
    }
    def destroy = {
    }
}
