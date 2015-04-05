package app.kermitvite

class Roster {

	String id
	String name
	User user
	
	def subs(gender) {
		def subs = []
		rosterMembers.each { rosterMember ->
			if(rosterMember.substitute == true && rosterMember.gender == gender) {
				println "added ${rosterMember.name} as a sub"
				subs.add rosterMember
			}
		}
		subs
	}
	
	static belongsTo = User
	static hasMany = [rosterMembers : RosterMember]
	
    static constraints = {
		name(blank:false)
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
