class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/snippet/$id"(controller: "snippet", parseRequest: true) {
		    action = [GET: "showjson"]
		}
		
		"/"(view:"/index")
		"500"(view:'/error')
	}
}
