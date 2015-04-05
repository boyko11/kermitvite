<%@ page import="app.kermitvite.EventResponse" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Event Responses</title>
    </head>
    <body>
       	<div data-role="page" id="submitResponsePage">
	
			<div data-role="header">
				<h2><g:message code="eventResponses" default="Event Responses"/></h2>
			</div><!-- /header -->
			
			<div data-role="content">
	            <g:if test="${flash.message}">
	            	<div style="text-align: center;font-size: 14px;font-weight: bold;">${flash.message}</div>
	            </g:if>
	
				<ul data-role="listview" data-inset="true">
			        <g:each in="${eventResponses}" status="i" var="eventResponse">			                
		                <li style="font-size: 14px;font-weight: bold;"><span>${eventResponse.rosterMember.name}</span><span style="float:right">${eventResponse.response}</span></li>
			        </g:each>
				</ul>	
			</div> <!-- content -->
		</div> <!-- page -->
    
    </body>
</html>