<div class="list">
	<div id="deleteMemberError"></div>
    <table>
        <thead>
            <tr>
            
                <g:sortableColumn property="name" title="${message(code: 'rosterMember.name.label', default: 'Name')}" action="show" params="[id: rosterId]" />
                
                <g:sortableColumn property="email" title="${message(code: 'rosterMember.email.label', default: 'Email')}" action="show" params="[id: rosterId]" />
            
                <g:sortableColumn property="phone" title="${message(code: 'rosterMember.phone.label', default: 'Phone')}" action="show" params="[id: rosterId]" />
            
                <g:sortableColumn property="address" title="${message(code: 'rosterMember.address.label', default: 'Address')}" action="show" params="[id: rosterId]" />
                
                <g:sortableColumn property="gender" title="${message(code: 'rosterMember.gender.label', default: 'Gender')}" action="show" params="[id: rosterId]" />
                
                <g:sortableColumn property="substitute" title="${message(code: 'rosterMember.sub.label', default: 'Sub')}" action="show" params="[id: rosterId]" />
            
                <g:sortableColumn property="details" title="${message(code: 'rosterMember.details.label', default: 'Details')}" action="show" params="[id: rosterId]" />
                
                <th colspan="2"><g:message code="roster.member.manage" default="Manage Member" /></th>
            
            </tr>
        </thead>
        <tbody>
        <g:each in="${rosterMembersList}" status="i" var="rosterMember">
	            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="row${rosterMember.id}">
	                
		                <td>${fieldValue(bean: rosterMember, field: "name")}</td>
		                
		                <td>${fieldValue(bean: rosterMember, field: "email")}</td>
		            
		                <td>${fieldValue(bean: rosterMember, field: "phone")}</td>
		            
		                <td>${fieldValue(bean: rosterMember, field: "address")}</td>
		                
		                <td>${fieldValue(bean: rosterMember, field: "gender")}</td>
		                
		                <td>
		                	<g:if test="${rosterMember.substitute}"><g:message code="yes" default="Yes"/></g:if>
		                	<g:else><g:message code="no" default="No"/></g:else>
		                </td>
		            
		                <td>${fieldValue(bean: rosterMember, field: "details")}</td>
		                
		                <td style="width:40px">  
		                	<span class="buttonsInCell">         
				                <g:form controller="rosterMember" action="edit">
				                    <g:hiddenField name="id" value="${rosterMember?.id}" />
				                    <g:hiddenField name="rosterId" value="${rosterId}" />
				                    <span class="button"><g:actionSubmit class="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
       				           </g:form>
				            </span> 
			            </td>
        		        <td style="border-left:none;width:40px">  
		                	<span class="buttonsInCell">
					            <g:formRemote name="deleteMember" url="[controller:'rosterMember', action:'delete']" update="[success:'row' + rosterMember.id,failure:'deleteMemberError']">
	     					            <g:hiddenField name="id" value="${rosterMember?.id}" />
					                    <g:hiddenField name="rosterId" value="${rosterId}" />
					            	<span class="button"><input type="submit" class="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'rostermember.delete.confirm.message', default: 'Delete roster member?')}');" /></span>
					            </g:formRemote>
				            </span>
			            </td>
	            
	            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="paginateButtons">
    <g:paginate total="${rosterMembersSize}" id="${rosterId}" action="show" />
</div>