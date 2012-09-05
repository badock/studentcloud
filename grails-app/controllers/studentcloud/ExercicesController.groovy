package studentcloud

class ExercicesController {

	def compilationService

	def index() {
		def exercices = Exercice.findAll()

		render(view:"index", model:[exercices:exercices])
	}

	def resolve() {
		def exercice = Exercice.get(params.id)
		def snippet = Snippet.findByExercice(exercice)

		if(snippet == null) {
			snippet = exercice.createSnippetWithTenant(null)
		}

		render(view:"resolve", model:[exercice:exercice, snippet:snippet])
	}

	def save() {
		def snippet = Snippet.get(params.id)

		if(snippet != null) {
			snippet.code = params.code
			snippet.save(flush:true)

			render(view:"resolve", model:[snippet:snippet, exercice:snippet.exercice])
		}
		else {
			render "error : the snippet doesn't exist"
		}
	}

	def run() {
		def snippet = Snippet.get(params.id)
		
		if(snippet != null) {
//			println(snippet.getTestCode())
			compilationService.compile(snippet)
			render(view:"resolve", model:[snippet:snippet, exercice:snippet.exercice])
		}
		else {
			render "error : the snippet doesn't exist"
		}
	}
}
