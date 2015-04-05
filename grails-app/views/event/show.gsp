
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            
            	<div style="width: 100%">
            	
	                <table>
	                
	                    <tbody>
	                    
	                        <tr class="prop">
	                        
	                            <td valign="top" class="name"><g:message code="event.name.label" default="Name" /></td>
	                            
	                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "name")}</td>
	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                        
	                            <td valign="top" class="name"><g:message code="event.location.label" default="Location" /></td>
	                            
	                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "location")}</td>
	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                        
	                            <td valign="top" class="name"><g:message code="event.time.label" default="Time" /></td>
	                            
	                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd HH:mm z" date="${eventInstance?.time}" /></td>
	                            
	                        </tr>
	
	                       	<tr>
	                       	
	                            <td valign="top" class="name"><g:message code="event.rsv.label" default="RSVP" /></td>
	                            
	                            <td valign="top" class="value" id="rsvpTD">
	                	            <g:if test="${eventInstance.rsvp == 'Later'}">	                    			
		                            	<g:remoteLink action="sendEmail" controller="email" update="[success:'rsvpTD',failure:'rsvpTD']" params="[eventId : eventInstance.id]">
		                            		<g:message code="event.rsvp.send" default="Send RSVP email to participants." />
		                            	</g:remoteLink>
	                            	</g:if>
	                            	<g:elseif test="${eventInstance.rsvp == 'daysahead'}">
	                            		<g:message code="event.rsvp.scheduled" default="Scheduled to be sent automatically ${eventInstance.rsvpRequestDaysahead} days prior to the event" />
	                       			    <span style="margin-left:15px">
		                       			    <g:remoteLink action="sendEmail" controller="email" update="[success:'rsvpTD',failure:'rsvpTD']" params="[eventId : eventInstance.id]">
			                            		<g:message code="event.rsvp.send.now" default="Send RSVP now." />
			                            	</g:remoteLink> 
		                            	</span>
	                            	</g:elseif>
	                            	<g:else>
	                            		<g:message code="event.rsvp.sent" default="RSVP successfully sent." />
	                            	</g:else>
	                   			</td>
	                   			
	                  		</tr>
	                  		
	                  		<tr id="triggerUpdateRow">
	                  			<td valign="top" class="name"><g:message code="update" default="Update" /></td>
	                  			<td>
	                  				<a href="#" onClick="TextAreaDivDisplayer.display('triggerUpdateRow', 'sendUpdateDiv', 'textUpdate', 'updateSuccessMessage')">
	                  					<g:message code="event.send.update" default="Send Update to Participants" />
	                  				</a>
	                  			</td>
	                  		</tr>
	                  		
	               		    <tr id="sendUpdateRow">
	                  			<td valign="top" class="name" colspan="2">
		                  			<span id="updateSuccessMessage"></span>
		                  			<div style="display:none" id="sendUpdateDiv">
			                  			<g:form action="sendUpdate">
			                  				<g:textArea name="textUpdate">
			                  				</g:textArea>
			                  				<g:hiddenField name="eventId" value="${eventInstance.id}"></g:hiddenField>
			                  				<div></div>
			                  				<span class="buttons" style="width:12%">
			                  					<span class="button"><g:submitToRemote update="sendUpdateRow" class="save" value="Send Update" action="sendUpdate" /></span>
			                  				</span>
			                  				<span style="margin-left:15px">
			                  					<a href="#" onClick="$('sendUpdateDiv').hide();$('triggerUpdateRow').show()"><g:message code="cancel.update" default="Cancel Update"/></a>
			                  				</span>
			                  			</g:form>
		                  			</div>
	                  			</td>
	                  		</tr>
	                  		
	                  		<g:if test="${eventInstance.coorganizers.size() > 0 }">
	        			        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="event.coorganizers.label" default="Coorganizers" /></td>
		                            <td valign="top" class="value">
		                            	<g:each in="${eventInstance.coorganizers}" status="i" var="eventOrgPermission">
		                            		${eventOrgPermission.coorganizer.username}
		                            		<g:if test="${i != eventInstance.coorganizers.size() - 1}">
		                            		,
		                            		</g:if>
		                            	</g:each>
		                            </td>
		                        </tr>
	                        </g:if>
	                        
	                        <tr class="prop">
	                        	<td valign="top" class="name" colspan=2">
	                        		<span style="color: #48802C"><g:message code="event.eventResponses.label" default="Event Responses:" /> 
	                        			<span id="girlsBoysConfirmedCount">Confirmed: ${girlsYesCount} girls, ${boysYesCount} boys</span>
	                        		</span>
	                        	</td>
	                        </tr>
	                        	                        
	                        <tr class="prop">
	                        
	                            <td valign="top" class="name" colspan=2">
	                                <div id="rosterMembersUpdated">
										<g:if test="${eventResponses.size() > 0}">
	                              			<g:render template="eventResponsesList" model="${['eventResponsesList': eventResponses, 'eventId': eventInstance.id]}" />
		                                </g:if>
		                                <g:else>
		                                	<g:message code="none" default="None" />
		                                </g:else>
	                                </div>
	                            </td>
	                            
	                        </tr>
	                    
	                    </tbody>
	                </table>
	        	</div>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${eventInstance?.id}" />
                    <g:hiddenField name="showlist" value="true" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'event.button.edit.label', default: 'Edit Event')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'event.button.delete.label', default: 'Delete Event')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
