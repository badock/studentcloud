
<%@ page import="studentcloud.UnitTest" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'unitTest.label', default: 'UnitTest')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		
		<div class="span3">
			<div class="well sidebar-nav">
				<ul class="nav nav-list">
					<li class="nav-header">unitTest</li>
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
			<div id="show-unitTest" class="content scaffold-show" role="main">
				<div class="page-header">	
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
					<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
					</g:if>
				</div>
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="code" title="${message(code: 'unitTest.code.label', default: 'Code')}" />
						
							<th><g:message code="unitTest.exercice.label" default="Exercice" /></th>
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${unitTestInstanceList}" status="i" var="unitTestInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="text-overflow:ellipsis;">
						
							<td>${fieldValue(bean: unitTestInstance, field: "code")}</td>
						
							<td>${fieldValue(bean: unitTestInstance, field: "exercice")}</td>
						
							<td><g:link action="edit" id="${unitTestInstance.id}">edit</g:link></td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${unitTestInstanceTotal}" />
				</div>
			</div>
		</div>
	</body>
</html>
