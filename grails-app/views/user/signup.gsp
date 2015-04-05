<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="welcome.label" default="Welcome to KermitVite"/></title>
    </head>
    <body>
        <div class="body">
            <h1><span style="text-align: center;"><g:message code="welcome.label" default="Welcome to KermitVite"/></span></h1>
            <div style="margin: 20px 0px 10px 0px;font-weight: bold;">
            	<label for="username"><g:message code="signup.participant.note" /></label>
			</div>
            <g:if test="${flash.message}">
            <div class="errors">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
			<g:form action="createUser">
			    <div class="dialog">
			        <table>
			            <tbody>

			                <tr class="prop">
			                    <td valign="top" class="name">
			                        <label for="username"><g:message code="user.username.label" default="Username (* this should be your email)" /></label>
			                    </td>
			                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
			                        <g:textField name="username" value="${userInstance?.username}" />
			                    </td>
			                </tr>
			            
			                <tr class="prop">
			                    <td valign="top" class="name">
			                        <label for="password"><g:message code="user.password.label" default="Password" /></label>
			                    </td>
			                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
			                    	<g:passwordField name="password" maxlength="15" value="${userInstance?.password}"/></
			                    </td>
			                </tr>
			                
			                <tr>
			                	<td></td>
			                	<td><g:submitButton name="Create Account" value="${message(code: 'default.button.create.account.label', default: 'Create Account')}" />
			                	</td>
			                </tr>
			            
			            </tbody>
			        </table>
			    </div>
			    
			    <input type="hidden" name="controllerName" value="${controllerName}" />
			    <input type="hidden" name="actionName" value="${actionName}" />
			    
			</g:form>
        </div>
    </body>
</html>