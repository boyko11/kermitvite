

<%@ page import="app.kermitvite.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="account.manage" default="Manage Account" /></title>
    </head>
    <body>
		<div data-role="page" id="resetPasswordFormPage">
	
			<div data-role="header">
				<h2>
					<g:message code="account.manage" default="Manage Account" />
				</h2>
			</div>
			<!-- /header -->
	
	
			<div data-role="content">
				
				<g:form action="resetPasswordSubmit" style="margin-top: 20px;">
                	 <g:hiddenField name="id" value="${userInstance?.id}" />
                	 <g:hiddenField name="version" value="${userInstance?.version}" />				
		             <g:hasErrors bean="${userInstance}">
			             <div class="errors">
			                 <g:renderErrors bean="${userInstance}" as="list" />
			             </div>
		            </g:hasErrors>
		            <div style="color: red;margin-bottom: 15px;font-size: 12px;">${errorMessage}</div>
		            
                    <label for="password"><g:message code="user.password.label" default="Password" /></label>
                    
                    <g:passwordField name="password" maxlength="15" />

                    <label for="confirmPassword"><g:message code="user.confirm.password.label" default="Confirm Password" /></label>

                    <g:passwordField name="confirmPassword" maxlength="15" />

					<div style="margin-top:15px">
						<g:submitButton name="Submit" value="Submit" data-role="button"/>
					</div>

				</g:form>
				<div>
					<a href="./userDashboard" data-role="button">
						<span style="color:black"><g:message code="dashboard.label" default="Back to Dashboard" /></span>
					</a>
				</div>
			</div>
			<!-- content -->
		</div>
    
    
<%--         <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard.label" default="Dashboard"/></g:link></span>
        </div>
        <div class="body">
        
        	<h1 style="margin-top:20px;"><g:message code="account.manage" default="Manage Account" /></h1>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <div style="color: red;margin-bottom: 15px;font-size: 12px;">${errorMessage}</div>
            
            <g:form method="post">
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" maxlength="15" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="confirmPassword"><g:message code="user.confirm.password.label" default="Confirm Password" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:passwordField name="confirmPassword" maxlength="15" />
                                </td>
                            </tr> 
                                                       
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="resetPasswordSubmit" value="${message(code: 'default.button.submit.label', default: 'Submit')}" /></span>
                </div>
            </g:form>
        </div> --%>
    </body>
</html>
