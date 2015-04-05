package app.kermitvite

import java.util.List;

class Event {
	String id
	String name
	String location
	Date time
	User user
	String message
	String rsvp
	Integer rsvpRequestDaysahead
	Boolean resendNoResponseRsvp
	Integer resendNoResponseRsvpDays
	Boolean responseLock
	Integer responseLockDays
	String details
	
	def isLocked(){
		return (responseLock ? (time.getTime() - new Date().getTime())/(24 * 60 * 60 * 1000) <= responseLockDays.toLong() : false)
	}
	
	static belongsTo = User
	static hasMany =[eventResponses:EventResponse, coorganizers:EventOrganizingPermission, eventRosters: Roster]
	static transients = ['coorganizer']
	
    static constraints = {
		name(nullable:false, blank:false)
		location(nullable:false, blank:false)
		time()
		message()
		rsvp()
		rsvpRequestDaysahead(nullable:true, validator: {
			val, obj ->
				if('daysahead' == obj.properties['rsvp'] && !val) {
					return ['event.daysprior.blank']
				}
		},range:1..999)
		resendNoResponseRsvpDays(nullable:true, validator: {
			val, obj ->
				if(true == obj.properties['resendNoResponseRsvp'] && !val) {
					return ['event.daysprior.blank']
				}
		},range:1..999)
		
		responseLockDays(nullable:true, validator: {
			val, obj ->
				if(true == obj.properties['responseLock'] && !val) {
					return ['event.daysprior.blank']
				}
		},range:1..999)
		
		details(nullable:true)

    }
	static mapping = {
		id generator: 'uuid'
	}
	
	String getCoorganizer() {
		
	}
}
