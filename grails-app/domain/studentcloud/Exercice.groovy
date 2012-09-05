package studentcloud

class Exercice {

	String question
	String code
	
	static hasMany = [tests:UnitTest]
	
	def createSnippetWithTenant(tenant) {
		new Snippet(code:code, trace:"", console:"", exercice:this).save(flush:true)
	}
	
    static constraints = {
    }
	
	static mapping = {
		code type: 'text'
	 }
}
