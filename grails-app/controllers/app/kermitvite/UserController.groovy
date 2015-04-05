package app.kermitvite

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", resetPasswordSecurityQuestionSubmit: "POST"]
	
	def afterInterceptor = { model, modelAndView ->
		if (session['isMobile']) {
			modelAndView.viewName = modelAndView.viewName + '.m'
		}
	}

    def login = {
		def userInstance = new User()
		userInstance.properties = params
		return [userInstance: userInstance, controllerName: params.controllerName, actionName: params.actionName]
    }
	
	def logout = {
		if(session.user) {
			session.invalidate()
			redirect(action : "login")
		}
	}
	
	def signup = {
		def userInstance = new User()
		userInstance.properties = params
		return [userInstance: userInstance, controllerName: params.controllerName, actionName: params.actionName]
	}
	
	def loginValidate = {
		def userInstance = User.findByUsername(params.username)

		if(userInstance && userInstance.password == params.password.encodeAsPassword()) {
			session.user = userInstance
			
			if(params.controllerName) {
				redirect(controller: params.controllerName, action: params.actionName)
			}
			
			if( userInstance.securityQuestionAndAnswer == null) {
				redirect(controller: "securityQuestionAndAnswer", action: "create")
			}
			
			redirect(action : "userDashboard")
		} else {
			def errorMessage =  !userInstance ? "Username not found." : "Incorrect password."
			redirect (action : login , params: ["errorMessage": errorMessage])
		}
	}
	
	def userDashboard = {
		
	}

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

    def createUser = {
        def userInstance = new User(params)
		userInstance.password = params.password.encodeAsPassword()
        if (userInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
			session.user = userInstance
			redirect (controller: "securityQuestionAndAnswer", action: "create")
        }
        else {
            render(view: "signup", model: [userInstance: userInstance])
        }
    }

    def show = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userInstance: userInstance]
        }
    }

    def edit = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {
                    
                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def manageAccount = {
		
	}
	
	def resetPassword = {
		
		def userSecurityQuestion = session.user.securityQuestionAndAnswer?.question;
		
		if(userSecurityQuestion) {
			
			render(view: "resetPasswordSecurityQuestion", model: [securityQuestion: userSecurityQuestion])
		} else {
			
			render("Sorry, it does not seem there is a security question set for your account. Please contact support at kermitvite@gmail.com.")
		}
	}
	
	def resetPasswordSecurityQuestionSubmit = {
		
		if(!params.answer) {
			
			render(view: "resetPasswordSecurityQuestion", model: [errorMessage: "Invalid answer.", securityQuestion: params.securityQuestion])
			return
		}
		
		def username = params.username
		def encodedUserInput = params.answer?.toLowerCase().encodeAsPassword()
		def recordedAnswer  = session.user?.securityQuestionAndAnswer?.answer
		
		if(encodedUserInput.equalsIgnoreCase(recordedAnswer)){

			render(view: "resetPasswordForm", model: [userInstance : session.user])
		} else {
			
			render(view: "resetPasswordSecurityQuestion", model: [errorMessage: "Incorrect answer.", securityQuestion: params.securityQuestion])
		}
	}
	
	def resetPasswordSubmit = {
		
		if(params.password.equals(params.confirmPassword) == false) {
			
			render(view: "resetPasswordForm", model: [userInstance : session.user, errorMessage: "Password and Confirm Password should be the same."])
			return
		}
		
        def userInstance = User.get(params.id)
		userInstance.password = params.password.encodeAsPassword()
        if (userInstance.save(flush: true)) {
			session.user = userInstance
			render(view : "userDashboard", model: [message: "Password successfully reset."])
        }
        else {
            render(view: "signup", model: [userInstance: userInstance])
        }
	}

}
