<%@ page import="app.kermitvite.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard.label" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="event.create.new.label" default="Create New Event"/></g:link></span>
        </div>
        <div class="body">
            <div style="margin-top: 20px"><g:message code="event.manage.tip" default="* Select the event you would like to manage from the event list"/></div>
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
            	<div id="deleteEventError"></div>
            	<div style="width: 100%">
	                <table>
	                    <thead>
	                        <tr>
	                        
	                            <g:sortableColumn property="name" title="${message(code: 'event.name.label', default: 'Name')}" />
	                        
	                            <g:sortableColumn property="location" title="${message(code: 'event.location.label', default: 'Location')}" />
	                        
	                            <g:sortableColumn property="time" title="${message(code: 'event.time.label', default: 'Time')}" />
	                            
	                            <th><g:message code="event.details" default="Details" /></th>
	                            
	                            <th colspan="2"><g:message code="event.manage" default="Manage Event" /></th>
	                        
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${eventInstanceList}" status="i" var="eventInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="row${eventInstance.id}">
	                        
	                            <td><g:link action="show" id="${eventInstance.id}"><span class="tableCell">${fieldValue(bean: eventInstance, field: "name")}</span></g:link></td>
	                        
	                            <td><g:link action="show" id="${eventInstance.id}"><span class="tableCell">${fieldValue(bean: eventInstance, field: "location")}</span></g:link></td>
	                        
	                            <td><g:link action="show" id="${eventInstance.id}"><span class="tableCell"><g:formatDate date="${eventInstance.time}" /></span></g:link></td>
	                            
	                            <td><g:link action="show" id="${eventInstance.id}"><span class="tableCell">${fieldValue(bean: eventInstance, field: "details")}</span></g:link></td>
	                            
	                 		    <td style="width:40px">  
				                	<span class="buttonsInCell">         
						                <g:form controller="event" action="edit">
						                    <g:hiddenField name="id" value="${eventInstance.id}" />
						                    <span class="button"><g:actionSubmit class="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
		       				           </g:form>
						            </span> 
					            </td>
		        		        <td style="border-left:none;width:40px">  
				                	<span class="buttonsInCell">
							            <g:formRemote name="deleteEvent" url="[controller:'event', action:'delete']" update="[success:'row' + eventInstance.id,failure:'deleteEventError']">
			     					            <g:hiddenField name="id" value="${eventInstance.id}" />
							            	<span class="button"><input type="submit" class="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'event.delete.confirm.message', default: 'Delete event?')}');" /></span>
							            </g:formRemote>
						            </span> 
					            </td>
	                        
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
                </div>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${eventInstanceTotal}" />
            </div>
        </div>
    </body>
</html>