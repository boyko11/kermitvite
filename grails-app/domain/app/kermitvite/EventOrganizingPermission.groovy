package app.kermitvite

class EventOrganizingPermission {

	User coorganizer
	Event event
	
	static EventOrganizingPermission assign(User user, Event eventToOrganize) {
		
		def eventOrganizingPermission = EventOrganizingPermission.findByCoorganizerAndEvent(user, eventToOrganize)
		
		if (!eventOrganizingPermission) {
			eventOrganizingPermission = new EventOrganizingPermission()
			user?.addToEventOrganizingPermissions(eventOrganizingPermission)
			eventToOrganize?.addToCoorganizers(eventOrganizingPermission)
			eventOrganizingPermission.save()
		}
		
		return eventOrganizingPermission
	}

	static void unassign (User user, Event eventToOrganize) {
		
		def eventOrganizingPermission = EventOrganizingPermission.findByCoorganizerAndEvent(user, eventToOrganize)
		if (eventOrganizingPermission) {
			user?.removeFromEventOrganizingPermissions(eventOrganizingPermission)
			eventToOrganize.removeFromCoorganizers(eventOrganizingPermission)
			eventOrganizingPermission.delete()
		}
	}
	
}
