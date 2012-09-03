<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	    
	    <link rel="stylesheet" href="${resource(dir: 'css', 'codemirror.css')}" type="text/css">
	    <link rel="stylesheet" href="${resource(dir: 'css', 'doc.css')}" type="text/css">
	    <link rel="stylesheet" href="${resource(dir: 'css', 'simple-hint.css')}" type="text/css">
	    
	    <script type="text/javascript" src="${resource(dir: 'js', file: 'codemirror.js')}"></script>
<%--	    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript-hint.js')}"></script>--%>
<%--	    <script type="text/javascript" src="${resource(dir: 'js', file: 'simple-hint.js')}"></script>--%>
	    <script type="text/javascript" src="${resource(dir: 'js', file: 'clike.js')}"></script>
	    
	    <style type="text/css">.CodeMirror {border: 1px solid #eee;} .CodeMirror-scroll { height: 100% }</style>
	    
	</head>
	<body>
		<g:form controller="exercices" action="save">
			<h1>${exercice.question}</h1>
					
			<textarea id="code" name="code" type="text">${exercice.code}</textarea>
			
			<g:hiddenField name="id" value="${exercice.id }"/>
			<br/>
			<g:submitButton name="Save this solution"/>
		</g:form>
		
		
		<form><textarea id="code1" name="code1">
function getCompletions(token, context) {
  var found = [], start = token.string;
  function maybeAdd(str) {
    if (str.indexOf(start) == 0) found.push(str);
  }
  function gatherCompletions(obj) {
    if (typeof obj == "string") forEach(stringProps, maybeAdd);
    else if (obj instanceof Array) forEach(arrayProps, maybeAdd);
    else if (obj instanceof Function) forEach(funcProps, maybeAdd);
    for (var name in obj) maybeAdd(name);
  }

  if (context) {
    // If this is a property, see if it belongs to some object we can
    // find in the current environment.
    var obj = context.pop(), base;
    if (obj.className == "js-variable")
      base = window[obj.string];
    else if (obj.className == "js-string")
      base = "";
    else if (obj.className == "js-atom")
      base = 1;
    while (base != null && context.length)
      base = base[context.pop().string];
    if (base != null) gatherCompletions(base);
  }
  else {
    // If not, just look in the window object and any local scope
    // (reading into JS mode internals to get at the local variables)
    for (var v = token.state.localVars; v; v = v.next) maybeAdd(v.name);
    gatherCompletions(window);
    forEach(keywords, maybeAdd);
  }
  return found;
}
</textarea></form>
		
		 <script>
      CodeMirror.commands.autocomplete = function(cm) {
        CodeMirror.simpleHint(cm, CodeMirror.javascriptHint);
      }
      var editor = CodeMirror.fromTextArea(document.getElementById("code1"), {
        lineNumbers: true,
        extraKeys: {"Ctrl-Space": "autocomplete"}
      });
    </script>
	</body>
</html>
