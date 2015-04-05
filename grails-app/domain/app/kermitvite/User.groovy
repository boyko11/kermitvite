package app.kermitvite

class User {
	
	String id
	String username
	String password
	SecurityQuestionAndAnswer securityQuestionAndAnswer
	
	def userEvents( params ){
		Event.findAllByUser this, params
	}
	
	static hasMany = [rosters : Roster, events : Event, eventOrganizingPermissions : EventOrganizingPermission]

    static constraints = {
		username(nullable:false, email:true, unique: true)
		password(size:5..35, blank:false)
		securityQuestionAndAnswer(nullable:true)
    }
	static mapping = {
		id generator: 'uuid'
	}
}
