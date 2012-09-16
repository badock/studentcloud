<%@ page import="studentcloud.Exercice" %>





<div class="fieldcontain ${hasErrors(bean: exerciceInstance, field: 'question', 'error')} ">
	<label for="question">
		<b><g:message code="exercice.question.label" default="Question" /></b>
		
	</label>
	<g:textField name="question" value="${exerciceInstance?.question}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: exerciceInstance, field: 'code', 'error')} ">
	<label for="code">
		<b><g:message code="exercice.code.label" default="Code" /></b>
		
	</label>
	
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'simple-hint.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'codemirror.css')}" type="text/css">
    
    <script type="text/javascript" src="${resource(dir: 'js', file: 'codemirror.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'simple-hint.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript-hint.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    
    <style type="text/css">.CodeMirror {border: 1px solid #eee;} .CodeMirror-scroll { height: 100% }</style>
		<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'markdownDescription', 'error')} ">		<textarea id="code" name="code">${exerciceInstance?.code}</textarea><script>
      CodeMirror.commands.autocomplete = function(cm) {
        CodeMirror.simpleHint(cm, CodeMirror.javascriptHint);
      }
      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true,
        extraKeys: {"Ctrl-Space": "autocomplete"}
      });
    </script></div>
</div>


<div class="fieldcontain ${hasErrors(bean: exerciceInstance, field: 'tests', 'error')} ">
	<label for="tests">
		<b><g:message code="exercice.tests.label" default="Tests" /></b>		
	</label>

	

<div class="accordion" id="accordion2">

	<g:each in="${exerciceInstance?.tests?}" var="t">

			<div class="accordion-group">
				<div class="accordion-heading">
					<a class="accordion-toggle" data-toggle="collapse"
						data-parent="#accordion2" href="#collapse${t.id}"> Click to view
						the code of Unit Test #${t.id}
					</a>
				</div>
				<div id="collapse${t.id}" class="accordion-body collapse">
					<div class="accordion-inner">

						<div
							class="fieldcontain ${hasErrors(bean: productInstance, field: 'markdownDescription', 'error')} ">
							<textarea id="codeUnit${t.id}" name="codeUnit${t.id}">${t.code}</textarea>
							<script>
								CodeMirror.commands.autocomplete = function(cm) {
									CodeMirror.simpleHint(cm,
											CodeMirror.javascriptHint);
								}
								var editor = CodeMirror.fromTextArea(document
										.getElementById("codeUnit${t.id}"), {
									lineNumbers : true,
									readOnly : true,
									extraKeys : {
										"Ctrl-Space" : "autocomplete"
									}
								});
							</script>
						</div>
						<g:link class="btn btn-primary" controller="unitTest" action="show" id="${t.id}">Edit this unit test</g:link>
					</div>
				</div>
			</div>
			
	</g:each>
  
</div>


	<g:link class="btn btn-primary" controller="unitTest" action="create" params="['exercice.id': exerciceInstance?.id]">Add a Unit Test</g:link>

</div>

