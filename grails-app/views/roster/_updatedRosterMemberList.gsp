<div id="statusMessage">
	<g:if test="${statusMessage}">
		<div class="message">${statusMessage}</div>
	</g:if>
</div>
<div id="errorMessage">
	<g:if test="${errorMessage}">
		<div class="errors">${errorMessage}</div>
	</g:if>
</div>
<g:if test="${rosterInstance.rosterMembers.size() > 0}">
	<g:render template="rosterMembersList" model="${['rosterMembersList': sortedRosterMembersList, 'rosterId':rosterId, 'rosterMembersSize': rosterInstance.rosterMembers.size()]}" />
</g:if>
<g:else>
	<g:message code="none" default="None" />
</g:else>