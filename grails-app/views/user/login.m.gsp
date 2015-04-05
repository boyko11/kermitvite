<%@ page import="app.kermitvite.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="welcome.label" default="Welcome to KermitVite"/></title>
        <script type="text/javascript">
        $(function() {
        	$('#username').focus();
        });
        </script>
    </head>
    <body>
    
	   <div data-role="page" id="indexPage">
	
			<div data-role="header">
				<h2>Welcome to KermitVite</h2>
			</div><!-- /header -->
			
			<div data-role="content">
	            <g:if test="${params.errorMessage}">
	            	<div class="errors">${params.errorMessage}</div>
	            </g:if>
	            <g:hasErrors bean="${userInstance}">
		            <div class="errors">
		                <g:renderErrors bean="${userInstance}" as="list" />
		            </div>
	            </g:hasErrors>
       		    <g:form action="loginValidate">			
			        		<div data-role="fieldcontain">
								<label for="username"><g:message code="user.username.label" default="Username" /></label>
							    <g:textField name="username" id="username" value="${userInstance?.username}" style="width:25%;" />
							</div>
							
							<div data-role="fieldcontain">
								<label for="password"><g:message code="user.password.label" default="Password" /></label>
							    <g:passwordField name="password" maxlength="15" value="${userInstance?.password}"/>
							</div>
							<div data-role="fieldcontain">
								<label for="login"></label>
								<g:submitButton name="login" value="${message(code: 'default.button.login.label', default: 'Log in')}" />
							</div>
		        </g:form>	
			</div><!-- /content -->
			
		</div><!-- /page -->
    </body>
</html>
