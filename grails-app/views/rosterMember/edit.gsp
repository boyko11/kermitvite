

<%@ page import="app.kermitvite.RosterMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'rosterMember.label', default: 'RosterMember')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="home" controller="user" action="userDashboard"><g:message code="dashboard" default="Dashboard"/></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${rosterMemberInstance}">
            <div class="errors">
                <g:renderErrors bean="${rosterMemberInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${rosterMemberInstance?.id}" />
                <g:hiddenField name="version" value="${rosterMemberInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="rosterMember.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${rosterMemberInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="rosterMember.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${rosterMemberInstance?.name}" />
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
			                        <g:message code="on" default="No"/>
		                        	<span style="margin-left:5px">
		                        		<g:if test="${!rosterMemberInstance.substitute}">
		                        			<g:radio name="substitute" value="No" checked="true"/>
		                        		</g:if>
		                        		<g:else>
		                        			<g:radio name="substitute" value="No"/>
		                        		</g:else>
		                        	</span>
			                        <span style="margin-left:25px">
			                        	<g:message code="Yes" default="Yes" />
		                        		<span style="margin-left:5px">
			                        		<g:if test="${rosterMemberInstance.substitute}">
			                        			<g:radio name="substitute" value="Yes" checked="true"/>
			                        		</g:if>
			                        		<g:else>
			                        			<g:radio name="substitute" value="Yes"/>
			                        		</g:else>		                        		
		                        		</span>
		                        	</span>
			                    </td>
			                </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="details"><g:message code="rosterMember.details.label" default="details" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: rosterMemberInstance, field: 'details', 'errors')}">
                                    <g:textField name="details" value="${rosterMemberInstance?.details}" size="50"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:link controller="roster" action="show" id="${rosterId}" class="save"><g:message code="roster.edit.cancel" default="Cancel"/></g:link></span>
                </div>
                <g:hiddenField name="rosterId" value="${rosterId}"></g:hiddenField>
            </g:form>
        </div>
    </body>
</html>
