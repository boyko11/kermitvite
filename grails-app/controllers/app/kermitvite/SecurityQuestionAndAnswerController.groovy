package app.kermitvite

class SecurityQuestionAndAnswerController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST", getSecurityQuestion: "POST"]
	
	def mailService

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[securityQuestionAndAnswerInstanceList: SecurityQuestionAndAnswer.list(params), securityQuestionAndAnswerInstanceTotal: SecurityQuestionAndAnswer.count()]
	}

	def create = {
		def securityQuestionAndAnswerInstance = new SecurityQuestionAndAnswer()
		securityQuestionAndAnswerInstance.properties = params
		return [securityQuestionAndAnswerInstance: securityQuestionAndAnswerInstance]
	}

	def save = {
		def securityQuestionAndAnswerInstance = new SecurityQuestionAndAnswer(params)
		
		if (securityQuestionAndAnswerInstance.save(flush: true)) {
			
			encodeAnswer(securityQuestionAndAnswerInstance, params)
			def userInstance = User.get(session.user.id)
			userInstance.securityQuestionAndAnswer = securityQuestionAndAnswerInstance
			userInstance.save(flush: true)
			session.user = userInstance
			
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), securityQuestionAndAnswerInstance.id])}"
			redirect(controller: "user", action: "userDashboard")
		}
		else {
			render(view: "create", model: [securityQuestionAndAnswerInstance: securityQuestionAndAnswerInstance])
		}
	}

	def show = {
		def securityQuestionAndAnswerInstance = SecurityQuestionAndAnswer.get(params.id)
		if (!securityQuestionAndAnswerInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), params.id])}"
			redirect(action: "list")
		}
		else {
			[securityQuestionAndAnswerInstance: securityQuestionAndAnswerInstance]
		}
	}

	def edit = {
		def securityQuestionAndAnswerInstance = SecurityQuestionAndAnswer.get(params.id)
		if (!securityQuestionAndAnswerInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [securityQuestionAndAnswerInstance: securityQuestionAndAnswerInstance]
		}
	}

	def update = {
		def securityQuestionAndAnswerInstance = SecurityQuestionAndAnswer.get(params.id)
		if (securityQuestionAndAnswerInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (securityQuestionAndAnswerInstance.version > version) {
					
					securityQuestionAndAnswerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer')] as Object[], "Another user has updated this SecurityQuestionAndAnswer while you were editing")
					render(view: "edit", model: [securityQuestionAndAnswerInstance: securityQuestionAndAnswerInstance])
					return
				}
			}
			securityQuestionAndAnswerInstance.properties = params
			if (!securityQuestionAndAnswerInstance.hasErrors() && securityQuestionAndAnswerInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), securityQuestionAndAnswerInstance.id])}"
				redirect(action: "show", id: securityQuestionAndAnswerInstance.id)
			}
			else {
				render(view: "edit", model: [securityQuestionAndAnswerInstance: securityQuestionAndAnswerInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def securityQuestionAndAnswerInstance = SecurityQuestionAndAnswer.get(params.id)
		if (securityQuestionAndAnswerInstance) {
			try {
				securityQuestionAndAnswerInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'securityQuestionAndAnswer.label', default: 'SecurityQuestionAndAnswer'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def encodeAnswer = { securityQuestionAndAnswerInstance, params ->

		securityQuestionAndAnswerInstance.answer = params.answer.toLowerCase().encodeAsPassword()
		securityQuestionAndAnswerInstance.save(flush: true)
	}

	
	def getSecurityQuestion = {
		
		if(!params.username) {
			
			render(template: "../user/forgotPasswordForm", model:[errorMessage: "Invalid username."])
			return
		}
		
		def userInstance = User.findByUsername(params.username)
		def userSecurityQuestion = userInstance.securityQuestionAndAnswer?.question;
		
		if(userSecurityQuestion) {
			
			render(view: "securityAnswerForm", model: [securityQuestion: userSecurityQuestion, username: params.username])
		} else {
			
			render("Sorry, it does not seem there is a security question set for your account. Please contact support at kermitvite@gmail.com.")
		}
	}
	
	def securityAnswerSubmit = {
		
		if(!params.answer) {
			
			render(view: "securityAnswerForm", model: [errorMessage: "Invalid answer.", securityQuestion: params.securityQuestion, username: params.username])
		}
		
		def username = params.username
		def encodedUserInput = params.answer.toLowerCase().encodeAsPassword()
		def userInstance = User.findByUsername(username)
		def securityQA  = userInstance.securityQuestionAndAnswer
		def recordedAnswer = securityQA.answer
		
		if(encodedUserInput.equalsIgnoreCase(recordedAnswer)){
			String randomPassword = UUID.randomUUID().toString().substring(0, 7)
			userInstance.password = randomPassword.encodeAsPassword()
			userInstance.save(flush: true)
			Thread.start {
				mailService.sendMail {
					to username
					subject "Kermitvite request."
					body(view: "securityQuestionAndAnswer/newPassword", model: [newPassword: randomPassword])
				}
			}
			render "Your password has been sent to your email. Please remember to delete that email to protect your privacy."
		} else {
			
			render(view: "securityAnswerForm", model: [errorMessage: "Incorrect answer.", securityQuestion: params.securityQuestion, username: params.username])
		}
	}
		
}