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
<%--    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript.js')}"></script>--%>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'clike.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    
    <style type="text/css">
    	.CodeMirror {border: 1px solid #ddd; background-color: #ddd;} 
    	.CodeMirror-scroll { height: 100% }
    	.well {padding-top:0px;}
    </style>
  </head>
  <body>
    <h1>${exercice.question }</h1>
	<b>snippet: #${snippet.id }</b>

	<br>
	<br>
	

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span8">
			
				<div class="well">
					<h3>Editor:</h3>
	
					<g:form name="form_save" controller="exercices" action="save">
						<g:hiddenField name="id" value="${snippet.id }" />
						<textarea id="code" name="code">${snippet.code }</textarea>
	<%--					<g:submitButton name="Save" />--%>
					</g:form>
	
					<g:form name="form_run" controller="exercices" action="run">
						<g:hiddenField name="id" value="${snippet.id }" />
	<%--					<g:submitButton class="btn btn-large btn-block btn-primary" name="Run this code" />--%>
					</g:form>
				
	              	<button type="button" class="btn btn-primary" onclick="document.form_save.submit()"><i class="icon-edit icon-white"></i> Save</button>
	              	<button type="button" class="btn btn-primary" onclick="document.form_run.submit()"><i class="icon-play icon-white"></i> Run this code</button>
<%--				<g:submitButton id="refresh_console_btn" name="Refresh Console" />--%>
				
				</div>
				
				<div class="well">
					<h3>Console:</h3>
					<div id="console"></div>
				</div>
				
			</div>
			<div class="span4">
				<div class="well">
					<h3>Test results:</h3>
					<div id="test_report"></div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
    <script>
      CodeMirror.commands.autocomplete = function(cm) {
        CodeMirror.simpleHint(cm, CodeMirror.javascriptHint);
      }
<%--      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {--%>
<%--        lineNumbers: true,--%>
<%--        extraKeys: {"Ctrl-Space": "autocomplete"}--%>
<%--      });--%>
      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
          lineNumbers: true,
          matchBrackets: true,
          extraKeys: {"Ctrl-Space": "autocomplete"},
          mode: "text/x-java"
        });
    </script>
    
    <script>

		function update_test_results() {
			var results = $("#test_report")[0].innerHTML.split("<br>");

			var htmlCode = "";
			for(var i=0; i<results.length -1 ; i++) {

				var kind = "";
				var symbol = "";
				var message = "";
				
				if(results[i].indexOf("[SUCCESS]")==0) {
					kind = "success";
					symbol = "✔"
					message = results[i].split("[SUCCESS]")[1];
				}
				
				if(results[i].indexOf("[FAILURE]")==0) {
					kind = "error";
					symbol = "✖"
					message = results[i].split("[FAILURE]")[1];
				}
				
				htmlCode += "<div class=\"alert alert-"+kind+"\">"+symbol+" "+message+"</div>";
			}

			$("#test_report").html(htmlCode);
		}
    
    	function refresh_console() {
	  		jQuery.ajax({
   	    	  url: "http://localhost:8080/studentcloud/snippet/1",
   	    	  context: document.body
   	    	}).done(function( msg ) {
   	   	    	
   	    		//alert( "Data Saved: " + msg );
   	    		//alert(msg.trace)
				$("#test_report").html(msg.trace);
				$("#console").html(msg.console);
   	    		if(msg.isRunning) {
	   	   	   	    setTimeout(function(){
	   	    			refresh_console();
	   	    		},200);
   	    		}
   	    		update_test_results();
   	    	});
        }
        
    	$("#refresh_console_btn").click(function(){
    		refresh_console();
        })
   		
   		refresh_console();   		
    </script>
  </body>
</html>