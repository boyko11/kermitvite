

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

        <div class="body" style="margin-top:15px;">
            <div class="dialog">
            
        		<div style="width: 100%">
	                <table>
	                
	                    <tbody>
	                    
	                       	<tr>
		                       	
	                            <td valign="top" class="value" id="rsvpTD">
	                            	<g:message code="event.rosters.added" default="Since new rosters have been added to the event, would you like to " />
	                            	<g:remoteLink action="sendEmailToNewRosters" controller="email" update="[success:'rsvpTD',failure:'rsvpTD']" params="[eventId : eventInstance.id, rosters: rostersAdded]">
	                            		<g:message code="event.rsvp.send" default="Send RSVP email to the newly added roster members?" />
	                            	</g:remoteLink>
	                   			</td>
	                   			
	                  		</tr>
	                    
	                    </tbody>
	                </table>
		        </div>
	        </div>
        </div>
    </body>
</html>
