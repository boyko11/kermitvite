package app.kermitvite

class EventControllerService {

    static transactional = true

	def addCoorganizer = { eventInstance, coorganizerEmail, myEmail ->
		
		if (myEmail == coorganizerEmail) {
			
			eventInstance.errors.rejectValue('coorganizer', 'user.email.same', 'You cannot add youself as a coorganizer.')
			return
		}
		
		def coorganizer = User.findByUsername(coorganizerEmail)
		
		if (!coorganizer) {
			
			eventInstance.errors.rejectValue('coorganizer', 'user.email.not.found', 'Coorganizer email not found. The coorganizer needs to have a kermitvite account.')
			return
		}
		
		EventOrganizingPermission.assign coorganizer, eventInstance
	}
	
	def removeCoorganizer = { eventInstance, coorganizerId ->
		
		def coorganizer = User.findById(coorganizerId)
		
		EventOrganizingPermission.unassign coorganizer, eventInstance
	}
}
