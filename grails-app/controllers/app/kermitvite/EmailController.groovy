package app.kermitvite


import app.kermitvite.Event
import app.kermitvite.EventResponse
import java.text.SimpleDateFormat

class EmailController {
	
	def mailService
	def emailService

	def sendEmail = {
		def event = Event.get(params.eventId)
		def eventHost = event.user.username
		def eventId = params.eventId
		def eventName = event.name
		def eventTime = new SimpleDateFormat("EEEEEEEEE HH:mm MMMMMMMMM d, yyyy").format(event.time)
		def eventLocation = event.location
		def eventMessage = event.message
		
		def eventResponsesHasNotRespondedYet = EventResponse.findAllByEventAndResponse(event, "Has not responded yet")
		
		def mailSubject = "${eventName} - ${eventTime} - ${eventLocation}"
		mailSubject = params.resend == "true" ? "Second notice, please respond - ${mailSubject}" : mailSubject
		
		def eventResponseIdRosterMemberEmailMap = [:]
		def eventResponseIdRosterMemberNameMap = [:]
		eventResponsesHasNotRespondedYet.each { eventResponse ->
			eventResponseIdRosterMemberEmailMap."${eventResponse.id}" = eventResponse.rosterMember.email
			eventResponseIdRosterMemberNameMap."${eventResponse.id}" = eventResponse.rosterMember.name
		}
		
		Thread.start {
			eventResponsesHasNotRespondedYet.each { eventResponse ->
				mailService.sendMail {
					to eventResponseIdRosterMemberEmailMap."${eventResponse.id}"
					subject mailSubject
					body(view: "event/invite", model: [eventName: eventName, eventTime: eventTime, eventLocation: eventLocation, eventMessage: eventMessage,
						 rosterMemberName: eventResponseIdRosterMemberNameMap."${eventResponse.id}", eventResponseId: eventResponse.id, eventHost: eventHost])
				}
			}
		}
		if(params.resend == "true") {
			event.resendNoResponseRsvp = false
		} else {
			event.rsvp = event.rsvp + "_sent"
		}
		event.save()
		render "RSVP successfully sent."
	}
	
	def sendEmailToNewRosters = {
		
		emailService.sendInviteEmailToNewRosters( Event.get(params.eventId), params.list("rosters"), session.user.username )
		
		render "RSVP successfully sent."
	}
}
