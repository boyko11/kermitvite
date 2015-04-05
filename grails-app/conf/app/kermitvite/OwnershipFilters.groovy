package app.kermitvite

class OwnershipFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
				
				def eventActions = ['show','update', 'edit', 'delete', 'showGetSub', 'submitGetSub', 'sendUpdate']
				def rosterActions = ['show', 'update', 'edit', 'delete', 'saveMember', 'addMember']
				def rosterMemberActions = ['edit', 'update', 'delete']
				
				if(controllerName == 'event' && eventActions.contains(actionName)) {
					
					def eventId = params.id ? params.id : params.eventId
					
					def currentEvent = Event.get(eventId);

					if(session.user.id != currentEvent.user.id && !EventOrganizingPermission.findByCoorganizerAndEvent(session.user, currentEvent)){
					    redirect(uri:"/unauthorized.html")
						return false
					}
					return true
				}
				
				if(controllerName == 'roster' && rosterActions.contains(actionName)) {
					
					def rosterId = params.id ? params.id : params.rosterid

					if(User.get(session.user.id).rosters.contains(Roster.get(rosterId)) == false){
						redirect(uri:"/unauthorized.html")
						return false
					}
					return true
				}
				
				if(controllerName == 'rosterMember' && rosterMemberActions.contains(actionName)) {
					
					if(User.get(session.user.id).rosters.contains(Roster.get(params.rosterId)) == false){
						redirect(uri:"/unauthorized.html")
						return false
					}
					return true
				}
				
				return true
            }
        }
    }
    
}
