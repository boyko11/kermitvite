<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="event.responses" default="Event Responses" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard.label" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="list" controller="event" action="listParticipating" params="[max:10, filter: 'future']"><g:message code="event.list" default="Events List" /></g:link></span>
        </div>
        <div class="body">
        	<h1><g:message code="event.responses" default="Event Responses: " />Confirmed: ${girlsYesCount} girls, ${boysYesCount} boys</h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
			<div class="list">
				<div style="width: 100%">
				    <table>
				        <thead>
				            <tr>
				            
				                <g:sortableColumn property="name" title="${message(code: 'rosterMember.name.label', default: 'Name')}" params="[eventId: eventId]" />
				                
				                <g:sortableColumn property="response" title="${message(code: 'eventresponse.response', default: 'Response')}" params="[eventId: eventId]" />
				            
				            </tr>
				        </thead>
				        <tbody>
				        <g:each in="${eventResponses}" status="i" var="eventResponse">
				            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" >
				                
				                <td>${eventResponse.rosterMember.name}</td>
				                
				                <td>${eventResponse.response}</td>
				            
				            </tr>
				        </g:each>
				        </tbody>
				    </table>
				</div>
			</div>
        </div>
    </body>
</html>
