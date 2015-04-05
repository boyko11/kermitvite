
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="account.manage" default="Manage Account" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard.label" default="Dashboard"/></g:link></span>
        </div>
        <div class="body">
        
			<h1 style="margin-top:20px;"><g:message code="account.manage" default="Manage Account" /></h1>
			
			<div style="margin-top:30px">		
			    <ul class="bullet">
			   		<li style="margin-top:10px"><g:link controller="user" action="resetPassword"><span style="font-size:13px"><g:message code="default.password.reset" default="Reset Password" /></span></g:link></li>
				</ul>
			</div>
        </div>
    </body>
</html>
