class SecurityFilters {
  def filters = {
    doLogin(controller:'*', action:'*'){
        before = {
            def allowedActions = ['login','signup', 'loginValidate', 'createUser', 'submitResponse', 'sendEmail', 'getSecurityQuestion', 'securityAnswerSubmit', 'sendEmailToNewRosters']
			if(session.user){
				return true
			}
            if (allowedActions.contains(actionName)){
				return true
            }
			redirect(controller:'user', action:'login',
				params:['controllerName': controllerName, 'actionName':actionName])
			return false
        }
    }     
  }
}
