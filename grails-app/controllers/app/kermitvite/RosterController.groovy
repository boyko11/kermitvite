package app.kermitvite

class RosterController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def messageSource
	def sortingService
	def eventResponseFactoryService
	
	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 25, 100)
		def userRosters = User.get(session.user.id).rosters
		[rosterInstanceList: userRosters, rosterInstanceTotal: userRosters.count()]
	}

	def create = {
		def rosterInstance = new Roster()
		rosterInstance.properties = params
		return [rosterInstance: rosterInstance]
	}

	def save = {
		def userInstance = User.get(session.user.id)
		params.user = userInstance
		def rosterInstance = new Roster(params)
		if (rosterInstance.save(flush: true) && userInstance) {
			userInstance.addToRosters(rosterInstance)
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'roster.label', default: 'Roster'), rosterInstance.name])}"
			redirect(action: "show", id: rosterInstance.id)
		}
		else {
			render(view: "create", model: [rosterInstance: rosterInstance])
		}
	}

	def show = {
		def rosterInstance = Roster.get(params.id)
		if (!rosterInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'roster.label', default: 'Roster'), params.id])}"
			redirect(action: "list")
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : 25, 100)
			[rosterInstance: rosterInstance, rosterMembers: sortingService.sort(rosterInstance.rosterMembers, params, "name", "asc"), rosterMembersSize: rosterInstance.rosterMembers.size()]
		}
	}

	def edit = {
		def rosterInstance = Roster.get(params.id)
		if (!rosterInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'roster.label', default: 'Roster'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [rosterInstance: rosterInstance]
		}
	}

	def update = {
		def rosterInstance = Roster.get(params.id)
		if (rosterInstance) {
			rosterInstance.properties = params
			if (!rosterInstance.hasErrors() && rosterInstance.save(flush: true)) {
				flash.message = "${message(code: 'roster.updated.message', default: 'Roster updated.')}"
				redirect(action: "show", id: rosterInstance.id)
			}
			else {
				render(view: "edit", model: [rosterInstance: rosterInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'roster.label', default: 'Roster'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def rosterInstance = Roster.get(params.id)
		def rosterName = rosterInstance.name
		if (rosterInstance) {
			try {
				User.get(session.user.id).removeFromRosters(rosterInstance)
				rosterInstance.delete()
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'roster.label', default: 'Roster'), rosterName])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'roster.label', default: 'Roster'), rosterName])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'roster.label', default: 'Roster'), rosterName])}"
			redirect(action: "list")
		}
	}
	
	def addMember = {
		def rosterMemberInstance = new RosterMember()
		rosterMemberInstance.properties = params
		render (template: "addNewMember", model:[rosterMemberInstance : rosterMemberInstance, rosterid : params.rosterid])
	}
	
	def saveMember = {
		
		def newRosterMember = new RosterMember(params)
		
		if (newRosterMember.save(flush: true)) {
			
			def roster = Roster.get(params.rosterid)
			if(roster.addToRosterMembers(newRosterMember).save()) {
			
			def futureUserEvents = Event.executeQuery(
				"select e from Event e " +
				"left join e.eventRosters roster " +
				"where roster= :roster " +
				"and e.time > :currentTime",[roster: roster, currentTime: new Date()]).each {
					eventResponseFactoryService.addNewRosterMember(it, newRosterMember, session.user.username)
				}
				
				saveMemberSuccess(roster)
			} else {
			
				saveMemberFail(params.rosterid)
			}
		}
		else {
			
			saveMemberFail(params.rosterid, newRosterMember.errors.allErrors)
		}
		
	}
	
	def saveMemberSuccess (Roster roster ) {
		def statusMessage = "${message(code: 'add.member.to.roster.success', default: 'Successfully added new member')}"
		render (template: "updatedRosterMemberList", model:[rosterInstance : roster, sortedRosterMembersList: sortingService.sort(roster.rosterMembers, params, "name", "asc"),
			statusMessage : statusMessage, rosterId: roster.id])
	}
	
	private saveMemberFail (String rosterid, List errors) {
		def errorMessage = ""
		errors.each { errorMessage += "${messageSource.getMessage(it, null)}<br/>"}
		render (template: "updatedRosterMemberList", model:[rosterInstance : Roster.get(rosterid), 
			sortedRosterMembersList: sortingService.sort(Roster.get(rosterid).rosterMembers, params, "name", "asc"), errorMessage : errorMessage, rosterId: rosterid])
	}
	
}
