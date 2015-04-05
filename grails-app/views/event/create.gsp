

<%@ page import="app.kermitvite.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard.label" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="list" action="listOrganizing" params="[max:10, sort:'time', order:'desc']" ><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventInstance}" as="list" />
            </div>
            </g:hasErrors>
                        <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
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
                                    <label for="time"><g:message code="event.time.label" default="Date and Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'time', 'errors')}">
                                    <g:datePicker name="time" value="${eventInstance?.time}" />
                                </td>
                            </tr>
                            <g:if test="${userRosters.size() == 0}">
                                <tr class="prop">
	                                <td valign="top" class="name">
                                    	<label for="roster"><g:message code="event.roster.label" default="Rosters to be invited:" /></label>
	                                </td>
	                                <td valign="top" class="value">
	                                    <g:message code="rosters.none.created" />
	                                </td>
	                            </tr>
                            </g:if>
                            <g:else>
	                            <g:each in="${userRosters}" var="userRoster" status="iter">
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
									<label for="rsvp"><g:message code="ask.for.rsvp" default="Ask for RSVP:"/></label>
								</td> 
								<td valign="top" class="value" rowspan="1">
									<p><g:radio name="rsvp" value="Now" onClick="\$('rsvpRequestDaysahead').value = '';\$('rsvpRequestDaysahead').disable();"/><span style="margin-left:25px"><g:message code="now" default="Now"/></span></p>
									<p class="${hasErrors(bean: eventInstance, field: 'rsvpRequestDaysahead', 'errors')}"><g:radio name="rsvp" value="daysahead" checked="true" onClick="\$('rsvpRequestDaysahead').enable();\$('rsvpRequestDaysahead').value = '7';"/><span style="margin-left:25px"><g:textField name="rsvpRequestDaysahead" value="${eventInstance?.rsvpRequestDaysahead}" maxlength="3" size="1" value="7"/> <g:message code="rsvp.days.prior" default="days prior to event's date"/></span></p>
									<p><g:radio name="rsvp" value="Later" onClick="\$('rsvpRequestDaysahead').value = '';\$('rsvpRequestDaysahead').disable();"/><span style="margin-left:25px"><g:message code="later" default="I will ask for RSVP later"/></span></p>
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name">
								</td> 
								<td valign="top" class="value">
									<p><label for="rsvp"><g:message code="resend.rsvp" default="Resend RSVP to those who have not responded:"/></label></p>
									<p class="${hasErrors(bean: eventInstance, field: 'resendNoResponseRsvpDays', 'errors')}" style="margin-top:10px;">
										<g:checkBox name="resendNoResponseRsvp" value="true" onClick="CheckboxChanger.onClickCheckBoxForTextField(this, 'resendNoResponseRsvpDays', '5')"/>
										<span style="margin-left:25px"><g:textField name="resendNoResponseRsvpDays" value="${eventInstance?.resendNoResponseRsvpDays}" maxlength="3" size="1" value="5"/>
											<g:message code="rsvp.days.prior" default="days prior to event's date"/>
										</span>
									</p>
								</td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name">
								</td> 
								<td valign="top" class="value">
									<p><label for="rsvp"><g:message code="event.response.change" default="Lock ability to change or submit response: " /></label></p>
									<p class="${hasErrors(bean: eventInstance, field: 'responseLockDays', 'errors')}" style="margin-top:10px;">
										<g:checkBox name="responseLock" value="true" onClick="CheckboxChanger.onClickCheckBoxForTextField(this, 'responseLockDays', '2')"/>
										<span style="margin-left:25px"><g:textField name="responseLockDays" value="${eventInstance?.responseLockDays}" maxlength="3" size="1" value="2"/> 
											<g:message code="rsvp.days.prior" default="days prior to event's date"/>
										</span>
									</p>
								</td>
							</tr>							
							
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="message"><g:message code="event.additionalmessage.label" default="Message to invitees:" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textArea name="message" value="${eventInstance?.message}"/> <span class="required"><g:message code="optional" default="*optional" /></span>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'event.button.create.label', default: 'Create Event')}" onclick="return CheckboxChecker.checkIfRostersSelected()" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
