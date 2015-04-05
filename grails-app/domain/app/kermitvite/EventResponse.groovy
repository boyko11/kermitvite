package app.kermitvite

class EventResponse {
	String id
	Event event
	RosterMember rosterMember
	String response
	String comments

	static belongsTo = Event
	
    static constraints = {
		//response(inList:["Yes", "No", "Has not responded yet", "No - Sub Requested", "Has not responded yet - Sub Requested"])
		comments(nullable:true, maxSize:300)
    }
	static mapping = {
		id generator: 'uuid'
	}
	
	String toString() {
		"${rosterMember.name} - ${rosterMember.email} - ${response}"
	}

}
