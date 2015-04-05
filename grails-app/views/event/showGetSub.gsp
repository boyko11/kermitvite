
<%@ page import="app.kermitvite.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="list" action="listOrganizing" params="[max:10, sort:'time', order:'desc']"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
        	<h1><g:message code="substitution" default="Substitution" /></h1>
			<g:form>
  	       	<div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="replace.regular" default="Replace regular: " /></td>
                            
                            <td valign="top" class="value">${rosterMemberName}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="with" default="With: " /></td>
                            
                            <td valign="top" class="value">
                            	<g:if test="${subs.size() > 0}">
                            		<g:select name="subId" from="${subs}" value="${name}" optionKey="id" />
                            	</g:if>
                            	<g:else>
                            		<div class="errors">
                            			<g:message code="subs.no.available" />
                            			<g:link controller="roster" action="list" params="[sort:'name', order:'asc']"><span style="font-size:13px"><g:message code="default.manage.rosters" default="Manage Rosters" /></span></g:link>
                            		</div>
                            	</g:else>
                            </td>
                            
                        </tr>
                        
                    </tbody>
                </table>
            </div>
            <g:hiddenField name="eventId" value="${eventId}" />
            <g:hiddenField name="originalResponseId" value="${originalResponseId}"/>
            <div class="buttons">
           	   <span class="button"><g:actionSubmit controller="event" action="submitGetSub" value="${message(code: 'submit', default: 'Request RSVP from the sub')}"/></span>
            </div>
            </g:form>
        </div>
    </body>
</html>
