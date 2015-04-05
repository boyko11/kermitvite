<%@ page import="app.kermitvite.EventResponse" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Event Responses</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
			<div style="margin-top:10px;margin-bottom:10px;">Confirmed: ${girlsYesCount} girls, ${boysYesCount} boys</div>
			<div class="list">
				<div style="width: 100%">
				    <table>
				        <thead>
				            <tr>
				            
				                <g:sortableColumn property="name" title="${message(code: 'rosterMember.name.label', default: 'Name')}" />
				                
				                <g:sortableColumn property="response" title="${message(code: 'eventresponse.response', default: 'Response')}" />
				            
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