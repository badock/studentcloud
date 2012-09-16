<%@ page import="studentcloud.UnitTest" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'unitTest.label', default: 'UnitTest')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<script type="text/javascript">	
			function convert() {
				
				var converter = new Showdown.converter();
			  
			    var txt = $("#markdown-editor").val();
			    var html = converter.makeHtml(txt);
			    $("#result").html(html)
			}
			
			$(function() {
			  var converter = new Showdown.converter();
			  $("#markdown-editor").keyup(function(){
			    convert();
			  });
			  
			  convert();
			});
		</script>
	</head>
	<body>
		
		<div class="span3">
			<div class="well sidebar-nav">
				<ul class="nav nav-list">
					<li class="nav-header">unitTest</li>
					<li>
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
			<div id="show-unitTest" class="content scaffold-show" role="main">
				<div class="page-header">	
					<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
					<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
					</g:if>
				</div>
				
				<g:hasErrors bean="${unitTestInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${unitTestInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<g:form method="post" action="update" >
					<g:hiddenField name="id" value="${unitTestInstance?.id}" />
					<g:hiddenField name="version" value="${unitTestInstance?.version}" />
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>
										
					<g:form>
						<div class="form-actions">
							<g:submitButton action="update" style="display:none" name="update" class="btn btn-primary" id="button_submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
							<g:link class="btn btn-primary" onclick="document.getElementById('button_submit').click()" url="#" id="${unitTestInstance?.id}"><i class="icon-ok icon-white"></i><g:message code="default.button.update.label" default=" Update" /></g:link>
							<g:link class="btn btn-danger" action="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" id="${unitTestInstance?.id}"><i class="icon-trash icon-white"></i><g:message code="default.button.delete.label" default=" Delete" /></g:link>						
						</div>
					</g:form>
				
				</g:form>
			</div>
		</div>
	</body>
</html>
