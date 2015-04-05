<g:message code="forgot.password.assist" />

<div style="color: red;">${errorMessage}</div>

<g:form action="forgotPasswordForm">

	<div style="margin-top: 20px;">

	<table>
		<tbody>

			<tr class="prop">
				<td valign="top" class="name"><label for="username"><g:message
					code="user.username.label" default="Username" /></label></td>
				<td valign="top" class="value"><g:textField name="username" />
				</td>
			</tr>

			<tr>
				<td></td>
				<td><span class="buttons" style="width: 12%"> <span
					class="button"><g:submitToRemote
					controller="securityQuestionAndAnswer" action="getSecurityQuestion"
					update="forgotPasswordFormDiv" class="save" value="Submit" /></span> </span></td>
			</tr>

		</tbody>
	</table>

	</div>

</g:form>