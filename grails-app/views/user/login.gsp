<%@ page import="app.kermitvite.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="welcome.label" default="Welcome to KermitVite"/></title>
        <script type="text/javascript">
	        Event.observe(window, 'load', function() {
	        	  $('username').focus();
	        	});
        </script>
    </head>
    <body>
        <div class="body">
        	<div style="text-align: center;">
	        	<div class="centered">
		            <h1><g:message code="welcome.label" default="Welcome to KermitVite"/></h1>
		            <g:if test="${params.errorMessage}">
		            	<div class="errors">${params.errorMessage}</div>
		            </g:if>
		            <g:hasErrors bean="${userInstance}">
		            <div class="errors">
		                <g:renderErrors bean="${userInstance}" as="list" />
		            </div>
		            </g:hasErrors>
		            <g:form action="loginValidate">
		            	<div style="margin-top: 20px;">
			                <div class="dialog">
			                    <table>
			                        <tbody>
			                        
			                            <tr class="prop">
			                                <td valign="top" class="name">
			                                    <label for="username"><g:message code="user.username.label" default="Username" /></label>
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
			                                	<g:passwordField name="password" maxlength="15" value="${userInstance?.password}"/>
			                                </td>
			                            </tr>
			                            
			                            <tr>
			                            	<td></td>
			                            	<td>
			                            		<g:submitButton name="login" value="${message(code: 'default.button.login.label', default: 'Log in')}" />
			                            		<span style="margin-left:95px">
			                            			<g:link action="signup">
			                            				${message(code: 'default.button.signup.label', default: 'New? - Sign up.')}
			                            			</g:link>
			                            		</span>
			                            	</td>
			                            </tr>
			                            			                            
			                            <tr>
			                            	<td></td>
			                            	<td>
		                            			<g:link  id="forgotPasswordLink" url="#" onclick="\$('forgotPasswordFormDiv').show()">
		                            				<span style="font-size:x-small;">${message(code: 'default.button.forgot.password.label', default: 'Forgot Password?')}</span>
		                            			</g:link>
			                            	</td>
			                            </tr>
			                        
			                        </tbody>
			                    </table>
			                </div>
		                </div>
		                <input type="hidden" name="controllerName" value="${controllerName}" />
		                <input type="hidden" name="actionName" value="${actionName}" />
		                
		            </g:form>
		            
         	        <div id=forgotPasswordFormDiv style="margin-top:20px;display:none;">
         	        
         	        	<g:render template="forgotPasswordForm" />
	                    
		            </div>	     
		            
	            </div>
	            
			</div>
        </div>
    </body>
</html>
