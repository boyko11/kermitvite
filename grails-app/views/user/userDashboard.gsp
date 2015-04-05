<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="default.dashboard" default="Dashboard" /></title>
    </head>
    <body>
    <div style="color: blue;font-size: 12px;">${message}</div>
	<h1><g:message code="dashboard" default="Dashboard"/></h1>
	<div style="margin-top:30px">		
	    <ul class="bullet">
	   		<li style="margin-top:10px"><g:link controller="event" action="listOrganizing" params="[max:10, sort:'time', order:'desc']"><span style="font-size:13px"><g:message code="default.manage.events.organizer" default="Manage Events as Organizer" /></span></g:link></li>
	   		<li style="margin-top:10px"><g:link controller="event" action="listParticipating" params="[max:10, sort:'time', order:'desc', filter: 'future']"><span style="font-size:13px"><g:message code="default.manage.events.participant" default="Manage Events as Participant" /></span></g:link></li>
	   		<li style="margin-top:10px"><g:link controller="roster" action="list" params="[sort:'name', order:'asc']"><span style="font-size:13px"><g:message code="default.manage.rosters" default="Manage Rosters" /></span></g:link></li>
	   		<li style="margin-top:10px"><g:link controller="user" action="manageAccount"><span style="font-size:13px"><g:message code="default.manage.account" default="Manage Account" /></span></g:link></li>
		</ul>
	</div>
		     

</body>

</html>