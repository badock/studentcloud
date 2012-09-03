<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<g:each var="exercice" in="${exercices}">
			<h1>${exercice.question}</h1>
			<g:link controller="exercices" action="resolve" id="${exercice.id }">resolve</g:link>
		</g:each>
	</body>
</html>
