package app.kermitvite

class RosterMember {
	
	String id
	String email
	String name
	String phone
	String address
	String details
	String gender
	Boolean substitute

	static belongsTo = Roster
	
    static constraints = {
		name(blank:false, nullable:false)
		email(email:true, blank:false, nullable:false)
		phone()
		address()
		gender(inList:["Female", "Male"])
		substitute()
		details()
    }
	
	static mapping = {
		id generator: 'uuid'
	}
	
	String toString() {
		"${name} - ${email}"
	}
}
