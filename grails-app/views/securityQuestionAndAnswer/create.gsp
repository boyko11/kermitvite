

<%@ page import="app.kermitvite.SecurityQuestionAndAnswer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <span style="font-size: 12px">* <g:message code="sec.qa.none" /></span>
            <g:hasErrors bean="${securityQuestionAndAnswerInstance}">
            <div class="errors">
                <g:renderErrors bean="${securityQuestionAndAnswerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" onsubmit="return SecurityQuestionAndAnswer.confirmQA();">
                <div class="dialog">
                	<div style="width: 100%; margin-top: 20px;">
	                    <table>
	                        <tbody>
	                        
	                           <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="question"><g:message code="securityQuestionAndAnswer.question.label" default="Question" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: securityQuestionAndAnswerInstance, field: 'question', 'errors')}">
	                                    <g:textField name="question" value="${securityQuestionAndAnswerInstance?.question}" />
	                                </td>
	                            </tr>
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="answer"><g:message code="securityQuestionAndAnswer.answer.label" default="Answer" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: securityQuestionAndAnswerInstance, field: 'answer', 'errors')}">
	                                    <g:textField name="answer" value="${securityQuestionAndAnswerInstance?.answer}" />
	                                </td>
	                            </tr>
	                        
	                        </tbody>
	                    </table>
                    </div>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
