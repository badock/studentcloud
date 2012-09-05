<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="layout" content="main">
    <title>CodeMirror: Autocomplete Demo</title>
    
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'simple-hint.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'codemirror.css')}" type="text/css">
    
    <script type="text/javascript" src="${resource(dir: 'js', file: 'codemirror.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'simple-hint.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript-hint.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    
    <style type="text/css">.CodeMirror {border: 1px solid #eee;} .CodeMirror-scroll { height: 100% }</style>
  </head>
  <body>
    <h1>${exercice.question }</h1>
	<b>snippet: #${snippet.id }</b>
    <g:form controller="exercices" action="save">
    	<g:hiddenField name="id" value="${snippet.id }"/>
    	<textarea id="code" name="code">${snippet.code }</textarea>
    	<g:submitButton name="Save"/>
    </g:form>
	
	<g:submitButton id="refresh_console_btn" name="Refresh Console"/>
	
	<g:form controller="exercices" action="run">
    	<g:hiddenField name="id" value="${snippet.id }"/>
    	<g:submitButton name="Run this code"/>
    </g:form>
	
	<div id="console"></div>
	
    <script>
      CodeMirror.commands.autocomplete = function(cm) {
        CodeMirror.simpleHint(cm, CodeMirror.javascriptHint);
      }
      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true,
        extraKeys: {"Ctrl-Space": "autocomplete"}
      });
    </script>
    
    <script>

    	function refresh_console() {
	  		jQuery.ajax({
   	    	  url: "../snippet/1",
   	    	  context: document.body
   	    	}).done(function( msg ) {
   	   	    	
   	    		//alert( "Data Saved: " + msg );
   	    		//alert(msg.trace)
				$("#console").html(msg.trace);
   	    		if(msg.isRunning) {
	   	   	   	    setTimeout(function(){
	   	    			refresh_console();
	   	    		},500);
   	    		}
   	    		
   	    	});
        }
        
    	$("#refresh_console_btn").click(function(){
    		refresh_console();
        })
   		
   		refresh_console();   		
    </script>
  </body>
</html>