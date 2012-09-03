import studentcloud.Exercice;

class BootStrap {

    def init = { servletContext ->
		environments {
			development {
				new Exercice(question:"Print \"Helloword!\" with Java", code:"").save(flush:true)
				new Exercice(question:"Print \"Helloword!\" with Java1", code:"").save(flush:true)
				new Exercice(question:"Print \"Helloword!\" with Java2", code:"").save(flush:true)
				new Exercice(question:"Print \"Helloword!\" with Java3", code:"").save(flush:true)
				new Exercice(question:"Print \"Helloword!\" with Java4", code:"").save(flush:true)
			}
		}
    }
    def destroy = {
    }
}
