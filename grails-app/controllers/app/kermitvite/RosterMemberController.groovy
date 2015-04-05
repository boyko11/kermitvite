package app.kermitvite

class RosterMemberController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def save = {
        def rosterMemberInstance = new RosterMember(params)
        if (rosterMemberInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'rosterMember.label', default: 'RosterMember'), rosterMemberInstance.id])}"
            redirect(action: "show", id: rosterMemberInstance.id)
        }
        else {
            render(view: "create", model: [rosterMemberInstance: rosterMemberInstance])
        }
    }

    def show = {
        def rosterMemberInstance = RosterMember.get(params.id)
        if (!rosterMemberInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'rosterMember.label', default: 'RosterMember'), params.id])}"
            redirect(action: "list")
        }
        else {
            [rosterMemberInstance: rosterMemberInstance]
        }
    }

    def edit = {
        def rosterMemberInstance = RosterMember.get(params.id)
        if (!rosterMemberInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'rosterMember.label', default: 'RosterMember'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [rosterMemberInstance: rosterMemberInstance, rosterId: params.rosterId]
        }
    }

    def update = {
        def rosterMemberInstance = RosterMember.get(params.id)
        if (rosterMemberInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (rosterMemberInstance.version > version) {
                    
                    rosterMemberInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'rosterMember.label', default: 'RosterMember')] as Object[], "Another user has updated this RosterMember while you were editing")
                    render(view: "edit", model: [rosterMemberInstance: rosterMemberInstance])
                    return
                }
            }
            rosterMemberInstance.properties = params
            if (!rosterMemberInstance.hasErrors() && rosterMemberInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'rosterMember.label', default: 'RosterMember'), rosterMemberInstance.name])}"
                redirect(controller: "roster", action: "show", id: params.rosterId)
            }
            else {
                render(view: "edit", model: [rosterMemberInstance: rosterMemberInstance, rosterId: params.rosterId])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'rosterMember.label', default: 'RosterMember'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def rosterMemberInstance = RosterMember.get(params.id)
		def rosterInstance = Roster.get(params.rosterId)
		try {
			rosterInstance.removeFromRosterMembers(rosterMemberInstance)
			rosterMemberInstance.delete(flush: true)
			render ""
		}
		catch (Exception e) {
			e.printStackTrace()
			throw e
		}
    }
}
