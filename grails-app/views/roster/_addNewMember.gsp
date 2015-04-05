<g:formRemote name="saveMember" url="[action:'saveMember']" update="[success:'rosterMembersUpdated',failure:'addMemberAjaxError']" onSuccess="AddNewMember.hideForm()">
    <div class="dialog">
        <table>
            <tbody>
            
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="email"><g:message code="rosterMember.email.label" default="Email" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'email', 'errors')}">
                        <g:textField name="email" value="${rosterMemberInstance?.email}" /> <span class="required"><g:message code="required" default="*required" /></span>
                    </td>
                </tr>
            
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name"><g:message code="rosterMember.name.label" default="Name" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'name', 'errors')}">
                        <g:textField name="name" value="${rosterMemberInstance?.name}" /> <span class="required"><g:message code="required" default="*required" /></span>
                    </td>
                </tr>
            
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="phone"><g:message code="rosterMember.phone.label" default="Phone" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'phone', 'errors')}">
                        <g:textField name="phone" value="${rosterMemberInstance?.phone}" />
                    </td>
                </tr>
            
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="address"><g:message code="rosterMember.address.label" default="Address" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'address', 'errors')}">
                        <g:textField name="address" value="${rosterMemberInstance?.address}" />
                    </td>
                </tr>
                
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="gender"><g:message code="rosterMember.gender.label" default="Gender" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'gender', 'errors')}">
                        <g:select name="gender" from="${['Female', 'Male']}" value="${rosterMemberInstance?.gender}" noSelection="['':'--']"/>
                    </td>
                </tr>
                
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="substitute"><g:message code="rosterMember.sub.label" default="Substitute" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'substitute', 'errors')}">
                        <g:message code="on" default="No"/><span style="margin-left:5px"><g:radio name="substitute" value="No" checked="true" /></span>
                        <span style="margin-left:25px"><g:message code="Yes" default="Yes" /><span style="margin-left:5px"><g:radio name="substitute" value="Yes" /></span></span>
                    </td>
                </tr>
            
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="details"><g:message code="rosterMember.details.label" default="Details" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'details', 'errors')}">
                        <g:textField name="details" value="${rosterMemberInstance?.details}" size="50" />
                    </td>
                </tr>
            
            </tbody>
        </table>
    </div>
    <div class="buttons">
        <span class="button"><input type="submit" class="save" name="addToRoster" value="${message(code: 'default.button.add.to.roster.label', default: 'Add to Roster')}" /></span>
        <a href="#" onclick="AddNewMember.hideForm()"><g:message code="roster.edit.cancel" default="Cancel"/></a>
    </div>
    <g:hiddenField name="rosterid" value="${rosterid}" />
</g:formRemote>