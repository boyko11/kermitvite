<script type="text/javascript">
   	function changeCurrenResponseAfter(eventResponseId) {
   		setInterval(function(){
   			new Ajax.Updater({ success: 'girlsBoysConfirmedCount' }, '${request.contextPath}/eventResponse/getConfirmedCountMessage', {parameters: { eventResponseId: eventResponseId }});
   			},1000);
   	}
</script>

<div class="list">
${request.contextPath} 

	<div style="width: 100%">
	    <table>
	        <thead>
	            <tr>
	            
	                <g:sortableColumn property="name" title="${message(code: 'rosterMember.name.label', default: 'Name')}" />
	                
	                <g:sortableColumn property="email" title="${message(code: 'rosterMember.email.label', default: 'Email')}" />
	            
	                <g:sortableColumn property="response" title="${message(code: 'eventresponse.response', default: 'Response')}" />
	                
	            </tr>
	        </thead>
	        <tbody>
		        <g:each in="${eventResponsesList}" status="i" var="eventResponse">
		        
		            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" >
		                
		                <td>${eventResponse.rosterMember.name}</td>
		                
		                <td>${eventResponse.rosterMember.email}</td>
		            
	                    <td>
	                    	<div id="currentResponse${eventResponse.id}" style="width:90%">
								<span class="tableCell" style="float:left">${eventResponse.response}</span>
		                     	<span style="float:right">
				                	<g:if test="${eventResponse.response == 'No' || eventResponse.response == 'Has not responded yet'}">
					                    <g:link controller="event action="showGetSub" params="[eventResponseId: eventResponse.id, eventId: eventId, rosterMemberName: eventResponse.rosterMember.name, 
					                    		rosterMemberGender: eventResponse.rosterMember.gender]">
					               			<g:message code="get.sub" default="Get a sub" />
					               		</g:link> |
				               		</g:if>
				               		<g:changeCurrentResponse response="${eventResponse.response}" target="currentResponse${eventResponse.id}" params="[id: eventResponse.id]"/>
			               		</span>
	                    	</div>
	                    </td>
		            
		            </tr>
		        </g:each>
	        </tbody>
	    </table>
	</div>
</div>