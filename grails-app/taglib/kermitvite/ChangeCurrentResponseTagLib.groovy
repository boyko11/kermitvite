package kermitvite

import app.kermitvite.EventResponse
import app.kermitvite.EventResponseCountService

class ChangeCurrentResponseTagLib {
	
	def eventResponseCountService
	
	def changeCurrentResponse = { attrs ->
		
		def changeTo
		
		if(attrs.response == 'Yes') {
			changeTo = "No"
		} else if(attrs.response == 'No') {
			changeTo = "Yes"
		} 
		
		attrs.params.response = changeTo
		attrs.params.target = attrs.target
		if(changeTo) {
			out << g.remoteLink(controller: "eventResponse", action: "submitResponseAjax",after: "changeCurrenResponseAfter('${attrs?.params?.id}');", update: [success: attrs.target, failure: 'ajaxError'], params: attrs.params){"Change to '${changeTo}'"}
		} else {
			attrs.params.response = "Yes"
			out << g.remoteLink(controller: "eventResponse", action: "submitResponseAjax",after: "changeCurrenResponseAfter('${attrs?.params?.id}');", update: [success: attrs.target, failure: 'ajaxError'], params: attrs.params){"Change to 'Yes'"}
			attrs.params.response = "No"
			out << "  |  " + g.remoteLink(controller: "eventResponse", action: "submitResponseAjax",after: "changeCurrenResponseAfter('${attrs?.params?.id}');", update: [success: attrs.target, failure: 'ajaxError'], params: attrs.params){"Change to 'No'"}
		}
		
	}

}
