
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="account.manage" default="Manage Account" /></title>
    </head>
    <body>

		<div data-role="page" id="resetPasswordPage">
	
			<div data-role="header">
				<h2>
					<g:message code="account.manage" default="Manage Account" />
				</h2>
			</div>
			<!-- /header -->
	
	
			<div data-role="content">
				
				<g:form action="resetPasswordSecurityQuestionSubmit" style="margin-top: 20px;">
					<div style="font-size: 15px;">
						<g:message code="reset.password.security.question" />
					</div>
					<div style="font-weight: bold;font-size: 15px;margin-top:15px;">
						${securityQuestion}
					</div>
					<div style="color: red;font-size: 15px;">${errorMessage}</div>
					<div style="margin-top:15px;">
						<input type="text" name="answer" id="answer" value="" />
					</div>
					<div style="margin-top:15px">
						<g:submitButton name="Submit" value="Submit" data-role="button"/>
					</div>

				    <g:hiddenField name="username" value="${username}"/>
			    	<g:hiddenField name="securityQuestion" value="${securityQuestion}"/>
				</g:form>
				<div>
					<a href="./userDashboard" data-role="button">
						<span style="color:black"><g:message code="dashboard.label" default="Back to Dashboard" /></span>
					</a>
				</div>
			</div>
			<!-- content -->
		</div>
		<!-- page -->
    </body>
</html>
