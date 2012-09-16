
<%@ page import="studentcloud.Exercice" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'exercice.label', default: 'Exercice')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		
		<div class="span3">
			<div class="well sidebar-nav">
				<ul class="nav nav-list">
					<li class="nav-header">exercice</li>
					<li class="active">
						<g:link class="list" action="list">
							<i class="icon-list"></i>
							<g:message code="default.list.label" args="[entityName]" />
						</g:link>
					</li>
					<li>
						<g:link class="create" action="create">
							<i class="icon-plus"></i>
							<g:message code="default.new.label" args="[entityName]" />
						</g:link>
					</li>
				</ul>
			</div>
		</div>
		
		<div class="span9">
			<div id="show-exercice" class="content scaffold-show" role="main">
				<div class="page-header">	
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
					<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
					</g:if>
				</div>
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="question" title="${message(code: 'exercice.question.label', default: 'Question')}" />
						
							<g:sortableColumn property="code" title="${message(code: 'exercice.code.label', default: 'Code')}" />
						
							
						</tr>
					</thead>
					<tbody>
					<g:each in="${exerciceInstanceList}" status="i" var="exerciceInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="text-overflow:ellipsis;">
						
							<td>${fieldValue(bean: exerciceInstance, field: "question")}</td>
							
							<td>
							<div class="accordion" id="accordion2">
							  <div class="accordion-group">
							    <div class="accordion-heading">
							      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse${i}">
							        Click to view the code
							      </a>
							    </div>
							    <div id="collapse${i}" class="accordion-body collapse">
							      <div class="accordion-inner">
							      	
							      	<link rel="stylesheet" href="/studentcloud/css/simple-hint.css" type="text/css">
								    <link rel="stylesheet" href="/studentcloud/css/codemirror.css" type="text/css">
								    
								    <script type="text/javascript" src="/studentcloud/js/codemirror.js"></script>
								    <script type="text/javascript" src="/studentcloud/js/simple-hint.js"></script>
								    <script type="text/javascript" src="/studentcloud/js/javascript-hint.js"></script>
								    <script type="text/javascript" src="/studentcloud/js/javascript.js"></script>
								    <script type="text/javascript" src="/studentcloud/js/jquery.js"></script>
								    
								    <style type="text/css">.CodeMirror {border: 1px solid #eee;} .CodeMirror-scroll { height: 100% }</style>
							      	
							      	<textarea id="codeUnit${i}" name="codeUnit${i}">${fieldValue(bean: exerciceInstance, field: "code")}</textarea>
									<script>
										CodeMirror.commands.autocomplete = function(cm) {
											CodeMirror.simpleHint(cm,
													CodeMirror.javascriptHint);
										}
										var editor = CodeMirror.fromTextArea(document
												.getElementById("codeUnit${i}"), {
											lineNumbers : true,
											readOnly : true,
											extraKeys : {
												"Ctrl-Space" : "autocomplete"
											}
										});
									</script>
							      	
							      </div>
							    </div>
							  </div>
							  </div>
							  </td>
							
							<td><g:link action="edit" id="${exerciceInstance.id}">edit</g:link></td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${exerciceInstanceTotal}" />
				</div>
			</div>
		</div>
	</body>
</html>
