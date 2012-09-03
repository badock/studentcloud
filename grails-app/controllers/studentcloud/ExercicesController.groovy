package studentcloud

class ExercicesController {

    def index() { 
		def exercices = Exercice.findAll()
		
		render(view:"index", model:[exercices:exercices])
	}
	
	def resolve() {
		def exercice = Exercice.get(params.id)
		
		render(view:"resolve", model:[exercice:exercice])
	}
	
	def save() {
		def exercice = Exercice.get(params.id)
		exercice.code = params.code
		exercice.save(flush:true)
		
		render(view:"resolve", model:[exercice:exercice])
	}
}
