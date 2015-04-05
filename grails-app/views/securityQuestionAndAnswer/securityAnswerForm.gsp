

	<g:form action="forgotPasswordForm">
	
	<div style="margin-top:20px;">
	
	  <table>
	  
         <tbody>
         
         	<tr>
         	
         		<td colspan="2">
         			<g:message code="security.question.selected" />
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
    					<span class="button"><g:submitToRemote controller="securityQuestionAndAnswer" action="securityAnswerSubmit" update="forgotPasswordFormDiv" class="save" value="Submit" /></span>
    				</span>
             	</td>
             </tr>
         
         </tbody>
     </table>
     
    </div>
    <g:hiddenField name="username" value="${username}"/>
    <g:hiddenField name="securityQuestion" value="${securityQuestion}"/>
   </g:form>	