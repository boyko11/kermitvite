<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="default.dashboard" default="Dashboard" /></title>
        <style>
        	.ui-li .ui-btn-inner a.ui-link-inherit{padding: 2em 30px;}
		</style>
    </head>
    <body>
    
    	<div data-role="page" id="userDashboardPage">
	
			<div data-role="header">
				<h2><g:message code="dashboard" default="Dashboard"/></h2>
			</div><!-- /header -->
			
			<div data-role="content">
    			<div style="color: blue;font-size: 12px;">${message}</div>
	
				<ul data-role="listview" data-inset="true">
		   			<li><g:link controller="event" action="listOrganizing" params="[max:10, sort:'time', order:'desc']"><span style="font-size:16px"><g:message code="default.manage.events.organizer" default="Manage Events as Organizer" /></span></g:link></li>
		   			<li><g:link controller="event" action="listParticipating" params="[max:10, sort:'time', order:'desc', filter: 'future']"><span style="font-size:16px"><g:message code="default.manage.events.participant" default="Manage Events as Participant" /></span></g:link></li>
		   			<li><g:link controller="roster" action="list" params="[sort:'name', order:'asc']"><span style="font-size:16px"><g:message code="default.manage.rosters" default="Manage Rosters" /></span></g:link></li>
		   			<li><g:link controller="user" action="manageAccount"><span style="font-size:16px"><g:message code="default.manage.account" default="Manage Account" /></span></g:link></li>
				</ul>	
			</div> <!-- content -->
		</div> <!-- page -->	     

	</body>

</html>