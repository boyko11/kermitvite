
<%@ page import="app.kermitvite.Roster" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'roster.label', default: 'Roster')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard" default="Dashboard"/></g:link></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            	<div style="width: 100%">
	                <table>
	                    <tbody>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="value">
	                            	<span style="font-weight: bold">${fieldValue(bean: rosterInstance, field: "name")}</span>
	                                <span id="addMemberLink" class="button" style="margin-left: 40px">
		                    			<g:remoteLink class="addmember" action="addMember" 
		                    				update="[success:'addMemberAjax',failure:'addMemberAjaxError']" before="AddNewMember.clearMessages()" onSuccess="\$('addMemberLink').hide();"
		                    					params="[rosterid : rosterInstance.id]">
		                    				<g:message code="default.button.add.new.member.label" default="Add New Member" />
		                    			</g:remoteLink>
	                    			</span>
	                            	<span id="addMemberAjax"></span>
	                            	<span id="addMemberAjaxError"></span>
	                            </td>
	                        </tr>
	                        
	                        <tr class="prop">
	                        	<td valign="top" class="name" colspan=2">
	                        		<span style="color: #48802C"><g:message code="roster.members" default="Roster Members:" /></span>
	                        	</td>
	                        </tr>
	                        <tr class="prop">
	                        
	                            <td valign="top" class="name" colspan=2">
	                                <div id="rosterMembersUpdated">
		                                <g:if test="${rosterMembers.size() > 0}">
	                              			<g:render template="rosterMembersList" model="${['rosterMembersList': rosterMembers, 'rosterId': rosterInstance?.id]}" />
		                                </g:if>
		                                <g:else>
		                                	<g:message code="none" default="None" />
		                                </g:else>
	                                </div>
	                            </td>
	                            
	                        </tr>
	                        
	                    </tbody>
	                </table>
            	</div>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${rosterInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'roster.button.edit.label', default: 'Edit Roster')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'roster.button.delete.label', default: 'Delete Roster')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
