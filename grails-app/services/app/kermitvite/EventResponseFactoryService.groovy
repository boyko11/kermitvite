package app.kermitvite

class EventResponseFactoryService {

    static transactional = true

	def emailService
	
    def addInvitees(event, params) {
		params.each() { key, value -> 
				if(key.startsWith("roster-")) {
					
					def eventRoster = Roster.get(key.tokenize("-")[1])
					event.addToEventRosters eventRoster
					
					def rosterMembers = eventRoster.rosterMembers
					rosterMembers.each { rosterMember ->
						if(rosterMember.substitute == false) {
							EventResponse eventResponse = new EventResponse();
							eventResponse.response = "Has not responded yet"
							eventResponse.rosterMember = rosterMember
							event.addToEventResponses(eventResponse)
						}
					}
					
				}
			 }
    }
	
	def addNewRosterMember(event, rosterMember, username) {
		if(rosterMember.substitute == false) {
			EventResponse eventResponse = new EventResponse();
			eventResponse.response = "Has not responded yet"
			eventResponse.rosterMember = rosterMember
			event.addToEventResponses(eventResponse)

			if(event.rsvp == 'Now' || event.rsvp.contains('_sent')) {
				emailService.sendIndividualEmail(event, rosterMember, EventResponse.findByEventAndRosterMember(event, rosterMember).id, username)
			}
		}
	}
}
