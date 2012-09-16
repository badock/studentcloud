<%@ page import="studentcloud.UnitTest" %>


<div class="fieldcontain">
	<label for="code">
		<b><g:message code="unitTest.code.label" default="Exercice Code" /></b>		
	</label>
	
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'simple-hint.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'codemirror.css')}" type="text/css">
    
    <script type="text/javascript" src="${resource(dir: 'js', file: 'codemirror.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'simple-hint.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript-hint.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'javascript.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    
    <style type="text/css">.CodeMirror {border: 1px solid #eee;} .CodeMirror-scroll { height: 100% }</style>
		<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'markdownDescription', 'error')} ">
		<textarea id="codeExercice" name="codeExercice">${unitTestInstance?.exercice?.code}</textarea>
		<script>
	      CodeMirror.commands.autocomplete = function(cm) {
	        CodeMirror.simpleHint(cm, CodeMirror.javascriptHint);
	      }
	      var editor = CodeMirror.fromTextArea(document.getElementById("codeExercice"), {
	        lineNumbers: true,
	        readOnly: true,
	        extraKeys: {"Ctrl-Space": "autocomplete"}
	      });
	    </script>
    </div>
</div>

<div class="fieldcontain ${hasErrors(bean: unitTestInstance, field: 'code', 'error')} ">
	<label for="code">
		<b><g:message code="unitTest.code.label" default="Code" /></b>		
	</label>
	
		<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'markdownDescription', 'error')} ">		<textarea id="code" name="code">${unitTestInstance?.code}</textarea><script>
      CodeMirror.commands.autocomplete = function(cm) {
        CodeMirror.simpleHint(cm, CodeMirror.javascriptHint);
      }
      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true,
        extraKeys: {"Ctrl-Space": "autocomplete"}
      });
    </script></div>
</div>

<div class="fieldcontain ${hasErrors(bean: unitTestInstance, field: 'exercice', 'error')} required">
<%--	<label for="exercice">--%>
<%--		<g:message code="unitTest.exercice.label" default="Exercice" />--%>
<%--		<span class="required-indicator">*</span>--%>
<%--	</label>--%>
	<g:hiddenField id="exercice" name="exercice.id" from="${studentcloud.Exercice.list()}" optionKey="id" required="" value="${unitTestInstance?.exercice?.id}" class="many-to-one"/>
</div>

