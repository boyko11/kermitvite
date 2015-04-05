package app.kermitvite

class EventResponseController {

    static allowedMethods = [submiResponse: "POST", submiResponseAjax: "POST"]
	def sortingEventsService
	def eventResponseCountService
	
	def afterInterceptor = { model, modelAndView ->
		if (session['isMobile']) {
			modelAndView.viewName = modelAndView.viewName + '.m'
		}
	}

	def list = {
		
		Event event = Event.get(params.eventId)
		def responses = event.eventResponses
		render(view: "list", model: [eventResponses: sortingEventsService.sort(responses, params, "response", "desc"), eventId: params.eventId,
			girlsYesCount: eventResponseCountService.count("Yes", "Female", responses), boysYesCount: eventResponseCountService.count("Yes", "Male", responses)])
	}
	
	def submitResponse = {
		def eventResponseInstance = EventResponse.get(params.id)
		
		if(eventResponseInstance.event.responseLock) {
			if(eventResponseInstance.event.isLocked()){
				render(view: "submitResponseReject", model: [errorMessage: g.message(code : 'eventresponse.lock', args : ["${eventResponseInstance.event.user.username}"])])
				return
			}
		}
		
		if(eventResponseInstance.response.contains("Sub Requested")) {
			render(view: "submitResponseReject", model: [errorMessage: g.message(code : 'eventresponse.sub.requested', args : ["${eventResponseInstance.event.user.username}"])])
			return
		}
		
		if (eventResponseInstance) {
			eventResponseInstance.properties = params
			if (!eventResponseInstance.hasErrors() && eventResponseInstance.save(flush: true)) {
				flash.message = "${message(code: 'eventresponse.thanks', args: [params.response])}"
				def responses = eventResponseInstance.event.eventResponses
				render(view: "submitResponse", model: [eventResponses: sortingEventsService.sort(responses, params, "response", "desc"), 
					girlsYesCount: eventResponseCountService.count("Yes", "Female", responses), boysYesCount: eventResponseCountService.count("Yes", "Male", responses)])
			}
			else {
				render "${message(code: 'app.error', default: 'There was an error with our app. Please, try submitting your response later. Sorry for the inconvenience!')}"
			}
		}
	}
	
	def submitResponseAjax = {
		def eventResponseInstance = EventResponse.get(params.id)
		if (eventResponseInstance) {
			eventResponseInstance.properties = params
			if (!eventResponseInstance.hasErrors() && eventResponseInstance.save(flush: true)) {
				render(template: "currentResponse", model:[eventResponse: eventResponseInstance.response, target: params.target, id: params.id]);
			}
			else {
				render "Error saving response"
			}
		}
	}
	
	def getConfirmedCountMessage = {
		def eventResponseInstance = EventResponse.get(params.eventResponseId)
		if (eventResponseInstance) {
			
			def girlsYesCount = eventResponseCountService.count("Yes", "Female", eventResponseInstance.event.eventResponses)
			def boysYesCount = eventResponseCountService.count("Yes", "Male", eventResponseInstance.event.eventResponses)
			render "Confirmed: ${girlsYesCount} girls, ${boysYesCount} boys"
		} else {
			render ""
		}
    }
	
}