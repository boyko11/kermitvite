

<%@ page import="app.kermitvite.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="list" action="listOrganizing" params="[max:10, sort:'time', order:'desc']"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${eventInstance?.id}" />
                <g:hiddenField name="version" value="${eventInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="event.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${eventInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="location"><g:message code="event.location.label" default="Location" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'location', 'errors')}">
                                    <g:textField name="location" value="${eventInstance?.location}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="time"><g:message code="event.time.label" default="Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'time', 'errors')}">
                                    <g:datePicker name="time" precision="minute" value="${eventInstance?.time}"  />
                                </td>
                            </tr>
                           
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="details"><g:message code="event.details.label" default="Details" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'details', 'errors')}">
                                    <g:textField name="details" value="${eventInstance?.details}" />
                                </td>
                            </tr>
                            
                            <g:if test="${userRostersNotInvited.size() == 0}">
                                <tr class="prop">
	                                <td valign="top" class="name">
                                    	<label for="roster"><g:message code="event.roster.label" default="Rosters to be invited:" /></label>
	                                </td>
	                                <td valign="top" class="value">
	                                    <g:message code="rosters.all.invited" />
	                                </td>
	                            </tr>
                            </g:if>
                            <g:else>
	                            <g:each in="${userRostersNotInvited}" var="userRoster" status="iter">
	                                <tr class="prop">
		                                <td valign="top" class="name">
		                                	<g:if test="${iter == 0}">
		                                    	<label for="roster"><g:message code="event.roster.label" default="Rosters to be invited:" /></label>
		                                    </g:if>
		                                </td>
		                                <td valign="top" class="value">
		                                    <g:checkBox name="roster-${userRoster.id}" /><span style="margin-left:35px">${userRoster.name}</span>
		                                </td>
		                            </tr>
								</g:each>
							</g:else>
                             
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="coorganizer"><g:message code="event.coorganizer.label" default="Add an organizer: " /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'coorganizer', 'errors')}">
                                    <g:textField name="coorganizer" value="" />
                                </td>
                            </tr>
                                                                                                            
                            <g:if test="${session.user.id == eventInstance.user.id && eventInstance.coorganizers.size() > 0 }">
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                  <label for="coorganizer"><g:message code="event.coorganizer.label" default="Remove an organizer: " /></label>
	                                </td>
	                                <td valign="top" class="value">
	                                	<g:select optionKey="${{it.coorganizer.id}}" optionValue="${{it.coorganizer.username}}" name="coorganizerRemoveId" from="${eventInstance.coorganizers}" noSelection="['':'-Select coorganizer to be removed-']" />

	                                </td>
	                            </tr>
                            </g:if>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'event.button.update.label', default: 'Update Event')}" /></span>
                    <span class="button"><g:link controller="event" action="listOrganizing" class="save" params="[max:10, sort:'time', order:'desc']"><g:message code="event.edit.cancel" default="Cancel"/></g:link></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
