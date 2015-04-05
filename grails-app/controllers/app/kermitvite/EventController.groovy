package app.kermitvite
import groovy.sql.Sql
import java.text.SimpleDateFormat

class EventController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST", sendUpdate: "POST"]
	
	def eventResponseFactoryService
	def emailService
	def sortingEventsService
	def dataSource
	def queryService
	def eventControllerService
	def eventResponseCountService
	
	def index = {
		redirect(action: "listOrganizing", params: params)
	}

	def listOrganizing = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def user = User.get(session.user.id)
		
		if(!params.sort) {
			params.sort = 'time'
		}
		if(!params.order) {
			params.order = 'desc'
		}
		def userEvents = Event.executeQuery(
			"select distinct e from Event e left join e.coorganizers eventOrganizingPermission " +
			"where eventOrganizingPermission.coorganizer = :user " +
			"or e.user= :user " +
			"order by e.${params.sort} ${params.order}",[user: user], params)
		
		render(view: "list", model: [eventInstanceList: userEvents, eventInstanceTotal: user.events.size()])
	}
	
	def listParticipating = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def user = User.get(session.user.id)
		def events = []
		def eventsResponses = []
		def db = new Sql(dataSource)

		db.eachRow(queryService.generateFindAllEventsAndEventResponseByUsernameQuery(params, user.username), { resultRow ->
			Event event = new Event()
			event.id = resultRow.eventId
			event.name = resultRow.name
			event.location = resultRow.location
			event.time = resultRow.time
			event.responseLockDays = resultRow.response_lock_days
			event.details = resultRow.details
						
			events.add event
			
			EventResponse eventResponse = new EventResponse()
			eventResponse.response = resultRow.response
			eventResponse.id = resultRow.eventResponseId
			
			eventsResponses.add eventResponse
		})
		db.close()
		[eventInstanceList: events, eventResponsesList: eventsResponses, eventInstanceTotal: events.size()]
	}

	def create = {
		def eventInstance = new Event()
		eventInstance.properties = params
		def userRosters = User.get(session.user.id).rosters
		return [eventInstance: eventInstance, userRosters: userRosters]
	}

	def save = {
		def eventInstance = new Event(params)
		eventResponseFactoryService.addInvitees(eventInstance, params)
		def userInstance = User.get(session.user.id)
		userInstance.addToEvents(eventInstance)
		if (eventInstance.save(flush: true) && userInstance.save(flush: true)) {
			
			if(params.rsvp == 'Now' || (params.rsvp == 'daysahead' && ((params.time.getTime() - new Date().getTime())/(24 * 60 * 60 * 1000) <= params.rsvpRequestDaysahead.toLong()))) {
				log.info "email sent"
				emailService.sendInviteEmail(eventInstance, params, session.user.username)
				if(params.rsvp == 'daysahead') {
					eventInstance.rsvp = "daysahead_sent"
					eventInstance.save()
				}
			}
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.name])}"
			redirect(action: "show", id: eventInstance.id)
		}
		else {
			render(view: "create", model: [eventInstance: eventInstance, userRosters: userInstance.rosters, userInstance: userInstance])
		}
	}

	def show = {
		def eventInstance = Event.get(params.id)
		if (!eventInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			redirect(action: "listOrganizing")
		}
		else {
			def responses = eventInstance.eventResponses
			[eventInstance: eventInstance, eventResponses: sortingEventsService.sort(responses, params, "response", "desc"), 
				girlsYesCount: eventResponseCountService.count("Yes", "Female", responses), boysYesCount: eventResponseCountService.count("Yes", "Male", responses)]
		}
	}

	def edit = {
		def eventInstance = Event.get(params.id)
		if (!eventInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			redirect(action: "listOrganizing")
		}
		else {
			
			def rostersNotInvited = []
			def eventRosters = eventInstance.eventRosters
			
			User.get(session.user.id).rosters.each { userRoster -> 
			
				if( eventRosters.contains(userRoster) == false ) {
					
					rostersNotInvited.add userRoster
				}		
			}
			
			
			return [eventInstance: eventInstance, userRostersNotInvited: rostersNotInvited]
		}
	}

	def update = {

		def eventInstance = Event.get(params.id)
		int numRostersOriginal = eventInstance.eventRosters.size()
		if (eventInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (eventInstance.version > version) {
					
					eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'event.label', default: 'Event')] as Object[], "Another user has updated this Event while you were editing")
					render(view: "edit", model: [eventInstance: eventInstance])
					return
				}
			}
			eventInstance.properties = params
			
			if (params.coorganizer) {
				
				eventControllerService.addCoorganizer(eventInstance, params.coorganizer, session.user.username)
			}
			
			if (params.coorganizerRemoveId) {
				
				eventControllerService.removeCoorganizer(eventInstance, params.coorganizerRemoveId)
			}
			
			
			eventResponseFactoryService.addInvitees(eventInstance, params)
			//emailService.sendInviteEmail(eventInstance, params, session.user.username)
			
			if (!eventInstance.hasErrors() && eventInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.name])}"
				if( numRostersOriginal !=  eventInstance.eventRosters.size()) {
					def rostersAdded = []
					params.each() { key, value ->
						if(key.startsWith("roster-")) {
							rostersAdded.add(key.tokenize("-")[1])
						}
					}
					render(view: "sendInviteToRostersAdded", model: [eventInstance: eventInstance, rostersAdded: rostersAdded])
				} else {
					redirect(action: "show", id: eventInstance.id)
				}
			}
			else {
				render(view: "edit", model: [eventInstance: eventInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			redirect(action: "listOrganizing")
		}
	}

	def delete = {
		def eventInstance = Event.get(params.id)
		if (eventInstance) {
			try {
				def eventName = eventInstance.name
				eventInstance.delete(flush: true)
				if(params.showlist){
					redirect(action: "listOrganizing")
				}
				render ""
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			redirect(action: "listOrganizing")
		}
	}
	
	def showGetSub = {
		
		def subs = queryService.getAvailableRosterSubs(params.eventResponseId, params.rosterMemberGender)
		return [subs: subs, eventId: params.eventId, rosterMemberName: params.rosterMemberName, originalResponseId: params.eventResponseId]
		
	}
	
	def submitGetSub = {
		EventResponse eventResponse = new EventResponse()
		eventResponse.response = "Has not responded yet"
		eventResponse.rosterMember = RosterMember.get(params.subId)
		Event event = Event.get(params.eventId)
		event.addToEventResponses(eventResponse)
		
		if(event.save(flush: true)) {
			def eventResponseId = eventResponse.id
			if(event.rsvp == 'Now' || event.rsvp.contains('_sent')) {
				
				emailService.sendIndividualEmail(event, eventResponse.rosterMember, eventResponseId, session.user.username)
				flash.message = g.message(code : 'rsvp.send.sub', default : 'RSVP successfully sent to sub.')
			} else {
				flash.message = g.message(code : 'sub.add.schedule', default : 'Substitute added to the event notification schedule.')
			}
			EventResponse originalEventResponse = EventResponse.get(params.originalResponseId)
			originalEventResponse.response = originalEventResponse.response + " - Sub Requested - " + eventResponse.rosterMember.name
			originalEventResponse.save(flush: true)
			
		} else {
			flash.message = g.message(code : 'rsvp.send.sub.fail', default : 'Error sending RSVP to sub')
		}
		redirect(action: "show", id: params.eventId)
	}
	
	def sendUpdate = {
		
		def eventInstance = Event.get(params.eventId)
		emailService.sendUpdate(eventInstance, params.textUpdate)
		render(view: "updateEmailSent")
	}
	
}
