package app.kermitvite

import java.text.SimpleDateFormat

class EmailService {

	def mailService
	static transactional = true

	def sendInviteEmail(event, params, eventHost) {
		
		params.each() { key, value ->
			if(key.startsWith("roster-")) {
				def rosterMemberEmailNameMap = [:]
				def rosterMemberEmailEventResponseIdMap = [:]
				Roster.get(key.tokenize("-")[1]).rosterMembers.each { rosterMember ->
					if(rosterMember.substitute == false) {
						rosterMemberEmailNameMap."${rosterMember.email}" = rosterMember.name
						rosterMemberEmailEventResponseIdMap."${rosterMember.email}" = EventResponse.findByEventAndRosterMember(event, rosterMember).id
					}
				}
				def eventName = event.name
				def eventTime = new SimpleDateFormat("EEEEEEEEE HH:mm MMMMMMMMM d, yyyy").format(event.time)
				def eventLocation = event.location
				def eventMessage = event.message
				def replyToEmail = event.user.username
				
				
				Thread.start {
					rosterMemberEmailNameMap.each { rosterMemberEmail, rosterMemberName ->
					    log.info "Sending an email to ${rosterMemberName} at ${rosterMemberEmail}"
						mailService.sendMail {
							replyTo replyToEmail
							to rosterMemberEmail
							subject "${eventName} - ${eventTime} - ${eventLocation}"
							body(view: "event/invite", model: [eventName: eventName, eventTime: eventTime, eventLocation: eventLocation, eventMessage: eventMessage,
								 rosterMemberName: rosterMemberName, eventResponseId: rosterMemberEmailEventResponseIdMap."${rosterMemberEmail}", eventHost: eventHost])
						}
						sleep 2000
					}
				}
				
			}
		 };
	 
	}
	
	def sendInviteEmailToNewRosters(event, rosters, eventHost) {
		rosters.each { rosterId ->
				def rosterMemberEmailNameMap = [:]
				def rosterMemberEmailEventResponseIdMap = [:]
				
				Roster.get(rosterId).rosterMembers.each { rosterMember ->
					if(rosterMember.substitute == false) {
						rosterMemberEmailNameMap."${rosterMember.email}" = rosterMember.name
						rosterMemberEmailEventResponseIdMap."${rosterMember.email}" = EventResponse.findByEventAndRosterMember(event, rosterMember).id
					}
				}
				def eventName = event.name
				def eventTime = new SimpleDateFormat("EEEEEEEEE HH:mm MMMMMMMMM d, yyyy").format(event.time)
				def eventLocation = event.location
				def eventMessage = event.message
				def replyToEmail = event.user.username
				
				
				Thread.start {
					rosterMemberEmailNameMap.each { rosterMemberEmail, rosterMemberName ->
							mailService.sendMail {
								replyTo replyToEmail
								to rosterMemberEmail
								subject "${eventName} - ${eventTime} - ${eventLocation}"
								body(view: "event/invite", model: [eventName: eventName, eventTime: eventTime, eventLocation: eventLocation, eventMessage: eventMessage,
									 rosterMemberName: rosterMemberName, eventResponseId: rosterMemberEmailEventResponseIdMap."${rosterMemberEmail}", eventHost: eventHost])
						}
					}
				}
				
		 };
	 
	}
	
	def sendIndividualEmail(event, rosterMember, eventResponseId, eventHost) {
		
		def eventName = event.name
		def eventTime = new SimpleDateFormat("EEEEEEEEE HH:mm MMMMMMMMM d, yyyy").format(event.time)
		def eventLocation = event.location
		def eventMessage = event.message
		def rosterMemberEmail = rosterMember.email
		def rosterMemberName = rosterMember.name
		def replyToEmail = event.user.username
		
		Thread.start {
			mailService.sendMail {
				replyTo replyToEmail
				to rosterMemberEmail
				subject "${eventName} - ${eventTime} - ${eventLocation}"
				body(view: "event/invite", model: [eventName: eventName, eventTime: eventTime, eventLocation: eventLocation, eventMessage: eventMessage,
					 rosterMemberName: rosterMemberName, eventResponseId: eventResponseId, eventHost: eventHost])
			}
		}
	}
	
	def sendUpdate(event, update) {
		
		def eventName = event.name
		def eventTime = new SimpleDateFormat("EEEEEEEEE HH:mm MMMMMMMMM d, yyyy").format(event.time)
		def eventLocation = event.location
		def eventHost = event.user.username
		def replyToEmail = event.user.username
		
		def rosterMemberEmailNameMap = [:]
		
		event.eventResponses.findAll{ it.response == 'Yes' || it.rosterMember.substitute == false }?.each {
			
			rosterMemberEmailNameMap."${it.rosterMember.email}" = it.rosterMember.name
		}
			
		Thread.start {
			rosterMemberEmailNameMap.each { rosterMemberEmail, rosterMemberName ->
					mailService.sendMail {
						replyTo replyToEmail
						to rosterMemberEmail
						subject "Event Update: ${eventName} - ${eventTime} - ${eventLocation}"
						body(view: "event/updateEmail", model: [eventName: eventName, eventTime: eventTime, eventLocation: eventLocation, update: update,
							 rosterMemberName: rosterMemberName, eventHost: eventHost])
				}
			}
		}
	}
		
	
}
