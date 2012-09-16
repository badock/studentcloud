package studentcloud

class Snippet {

	String code
	String trace
	String console

	boolean isRunning = false

	static belongsTo = [exercice:Exercice]

	static constraints = {
	}

	static mapping = {
		code type: 'text'
		trace type: 'text'
		console type: 'text'
	}
}
