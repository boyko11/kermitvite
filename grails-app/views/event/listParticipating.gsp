
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
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <div style="margin-bottom:10px;text-align:center">
            	<g:link controller="event" action="listParticipating" params="[max:10, sort:'time', order:'desc', filter: 'all']"><g:message code="show.all" default="Show All" /></g:link>
            	<span style="margin-left:20px">
            		<g:link controller="event" action="listParticipating" params="[max:10, sort:'time', order:'desc', filter: 'passed']"><g:message code="show.all" default="Show Passed" /></g:link>
            	</span>
            	<span style="margin-left:20px">
            		<g:link controller="event" action="listParticipating" params="[max:10, sort:'time', order:'desc', filter: 'future']"><g:message code="show.all" default="Show Future" /></g:link>
            	</span>
            </div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div id="ajaxError">
            </div>
            <div class="list">
            	<div style="width: 100%">
	                <table>
	                    <thead>
	                        <tr>
	                        
	                            <g:sortableColumn property="name" title="${message(code: 'event.name.label', default: 'Name')}"  defaultOrder="desc"/>
	                        
	                            <g:sortableColumn property="location" title="${message(code: 'event.location.label', default: 'Location')}" defaultOrder="desc" />
	                        
	                            <g:sortableColumn property="time" title="${message(code: 'event.time.label', default: 'Time')}" defaultOrder="desc" />
	                            
	                            <th><g:message code="event.details" default="Details" /></th>
	                            
	                            <g:sortableColumn property="response" title="${message(code: 'event.rostermember.currentresponse', default: 'Current Response')}" defaultOrder="desc" />
	                            
	                        </tr>
	                    </thead>
	                    <tbody id="eventsTableBody">
	                    <g:each in="${eventInstanceList}" status="i" var="eventInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="row${eventInstance.id}">
	                                                    
	                            <td><g:link controller="eventResponse" action="list" params="[eventId: eventInstance.id]">${fieldValue(bean: eventInstance, field: "name")}</g:link></td>
	                            
	                            <td><g:link controller="eventResponse" action="list" params="[eventId: eventInstance.id]"><span class="tableCell">${fieldValue(bean: eventInstance, field: "location")}</span></g:link></td>
	                        
	                            <td><g:link controller="eventResponse" action="list" params="[eventId: eventInstance.id]"><span class="tableCell"><g:formatDate date="${eventInstance.time}" /></span></g:link></td>
	                            
	                            <td><g:link controller="eventResponse" action="list" params="[eventId: eventInstance.id]"><span class="tableCell">${fieldValue(bean: eventInstance, field: "details")}</span></g:link></td>
	                            
	                            <td>
	                            	<div id="currentResponse${eventInstance.id}" style="width:90%">
	                            		<g:link controller="eventResponse" action="list" params="[eventId: eventInstance.id]">
		                            		<span class="tableCell" style="float:left">${eventResponsesList[i].response}</span>
		                            	</g:link>
		                            	<span class="tableCell" style="float:right">
		                            		<g:if test="${eventInstance.time > new Date() && eventInstance.isLocked() == false}">
		                            			<g:changeCurrentResponse response="${eventResponsesList[i].response}" target="currentResponse${eventInstance.id}" params="[id: eventResponsesList[i].id]"/>
		                            		</g:if>
		                            	</span>
	                            	</div>
	                            </td>
	                            
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	        	</div>
            </div>
        </div>
    </body>
</html>
