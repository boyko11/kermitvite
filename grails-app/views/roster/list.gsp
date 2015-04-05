
<%@ page import="app.kermitvite.Roster" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'roster.label', default: 'Roster')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard.label" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="roster.create.new.label" default="Create New Roster" /></g:link></span>
        </div>
        <div class="body">
        	<div style="margin-top: 20px"><g:message code="roster.manage.tip" default="* Select the roster you would like to manage from the roster list"/></div>
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
            	<div style="width: 100%">
	                <table>
	                    <thead>
	                        <tr>
	                        
	                            <g:sortableColumn property="name" title="${message(code: 'roster.name.label', default: 'Roster')}" />
	                        
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${rosterInstanceList}" status="i" var="rosterInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        
	                            <td><g:link action="show" id="${rosterInstance.id}" params="[sort:'name', order:'asc']"><span class="tableCell">${fieldValue(bean: rosterInstance, field: "name")}</span></g:link></td>
	                        
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	        	</div>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${rosterInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
