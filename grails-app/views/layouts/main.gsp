<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <g:if test="${session.isMobile}">
			<link rel="stylesheet" href="${resource(dir:'css',file:'jquery.mobile-1.3.0.min.css')}" /> 	
			<g:javascript library="jquery-1.9.1.min" />
        	<g:javascript library="jquery.mobile-1.3.0.min" /> 
        </g:if>
        <g:javascript library="prototype" />
        <g:javascript library="application" />
        <g:javascript library="google-analytics" />
        <g:layoutHead />
    </head>
    <body>
	        <div id="spinner" class="spinner" style="display:none;">
	            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
	        </div>
	        <div class="layoutBody">
	        	<g:if test="${session.user}">
	        		<span style="position:absolute;top:25px;right:100px;"><g:link controller="user" action="logout">Logout</g:link></span>
        		</g:if>
        		<g:else>
        			<span style="position:absolute;top:25px;right:100px;"><g:link controller="user" action="login">Login</g:link></span>
        		</g:else>
	        	<g:layoutBody />
	        </div>
	        
    </body>
</html>