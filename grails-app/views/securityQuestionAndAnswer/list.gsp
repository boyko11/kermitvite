
<%@ page import="app.kermitvite.SecurityQuestionAndAnswer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'securityQuestionAndAnswer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="answer" title="${message(code: 'securityQuestionAndAnswer.answer.label', default: 'Answer')}" />
                        
                            <g:sortableColumn property="question" title="${message(code: 'securityQuestionAndAnswer.question.label', default: 'Question')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${securityQuestionAndAnswerInstanceList}" status="i" var="securityQuestionAndAnswerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${securityQuestionAndAnswerInstance.id}">${fieldValue(bean: securityQuestionAndAnswerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: securityQuestionAndAnswerInstance, field: "answer")}</td>
                        
                            <td>${fieldValue(bean: securityQuestionAndAnswerInstance, field: "question")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${securityQuestionAndAnswerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
