
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="account.manage" default="Manage Account" /></title>
    </head>
    <body>
		<div data-role="page" id="manageAccountPage">
	
			<div data-role="header">
				<h2><g:message code="account.manage" default="Manage Account"/></h2>
			</div><!-- /header -->
			
			
			<div data-role="content">
    			<div style="color: blue;font-size: 12px;">${message}</div>
	
		   		<g:link controller="user" action="resetPassword" data-role="button">
		   			<span style="color:black"><g:message code="default.password.reset" default="Reset Password" /></span>
		   		</g:link>
				<div>
					<a href="./userDashboard" data-role="button">
						<span style="color:black"><g:message code="dashboard.label" default="Back to Dashboard" /></span>
					</a>
				</div>
			</div> <!-- content -->
		</div> <!-- page -->
        
    </body>
</html>
