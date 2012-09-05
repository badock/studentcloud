package studentcloud

class UnitTest {

	String code
	
	static belongsTo = [exercice:Exercice]
	
    static constraints = {
    }
	
	static mapping = {
		code type: 'text'
	 }
}
