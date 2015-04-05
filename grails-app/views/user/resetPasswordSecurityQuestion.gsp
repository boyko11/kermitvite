
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

			<g:form action="resetPasswordSecurityQuestionSubmit">
			
			<div style="margin-top:20px;">
			
			  <table>
			  
		         <tbody>
		         
		         	<tr>
		         	
		         		<td colspan="2">
		         			<g:message code="reset.password.security.question" />
		         		</td>
		         	
		         	</tr>
		         	
		    	    <tr>
		         	
		         		<td colspan="2">
		         			<span style="margin-left: 10px;font-weight: bold;">${securityQuestion}</span>
		         		</td>
		         	
		         	</tr>
		         	
		     	    <tr>
		         	
		         		<td colspan="2">
		         			<g:message code="security.question.type" />
		         		</td>
		         	
		         	</tr>
		         
		             <tr class="prop">
		                 <td valign="top" class="value" colspan="2">
		                 	 <div style="color: red;">${errorMessage}</div>
		                     <span style="margin-left: 10px;"><g:textField name="answer" size="47"/></span>
		                 </td>
		             </tr>
		
		             <tr>
		             	<td></td>
		             	<td>
		          			<span class="buttons" style="width:12%">
		    					<span class="button">
		    						<g:submitButton name="Submit" class="save" value="Submit" />
		    					</span>
		    				</span>
		             	</td>
		             </tr>
		         
		         </tbody>
		     </table>
		     
		    </div>
		    
		    <g:hiddenField name="username" value="${username}"/>
		    <g:hiddenField name="securityQuestion" value="${securityQuestion}"/>
		   </g:form>	
        </div>
    </body>
</html>
