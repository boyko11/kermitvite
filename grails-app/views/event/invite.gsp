<%@ page contentType="text/html"%>

<p>Hello ${rosterMemberName},</p>
<p>You have been invited by ${eventHost} to attend</p>
<p style="font-weight:bold">${eventName} at ${eventLocation} on ${eventTime}</p>
<p>Please, indicate if you will be attending or not.</p>

<table style="margin-top:15px;">
	<tr>
		<td>
			<a style="text-decoration: none;padding: 5px 10px;display: inline;background: #777;cursor: pointer;font-weight:bold;border-radius:5px;text-shadow: 1px 1px #666;background-color: #58aa00;padding: 7px 12px;" 
				href="${grailsApplication.config.grails.serverURL}/eventResponse/submitResponse?id=${eventResponseId}&response=Yes">
				<span style="color:#fff;">Yes</span>
			</a>
		</td>
		
		<td style="padding-left:40px">
			<a style="text-decoration: none;padding: 5px 10px;display: inline;background: #777;cursor: pointer;font-weight:bold;border-radius:5px;text-shadow: 1px 1px #666;background-color: #e50000;padding: 7px 12px;"
				 href="${grailsApplication.config.grails.serverURL}/eventResponse/submitResponse?id=${eventResponseId}&response=No">
				<span style="color:#fff;">No</span>
			</a>
		</td>
	</tr>
</table>
<div style="height:15px;"></div>
<div style="font-weight:bold;">Thank You!</div>

<g:if test="${eventMessage}">
	<div style="margin-top:15px;">
		Message from the organizer:
	</div>
	<div style="margin-top:15px;">
		${eventMessage}
	</div>
</g:if>