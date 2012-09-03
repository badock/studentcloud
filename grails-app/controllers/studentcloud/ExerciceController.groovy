package studentcloud

class ExerciceController {

	def exercices() {
		render(view:"exercices")	
	}
	
	static scaffold = true
}
