package app.kermitvite

class UserAgentFilters {

	def userAgentIdentService
	
    def filters = {
        all(controller:'*', action:'*') {
            before = {  
			   //REMOVE When done with mobile dev
			   //session['isMobile'] = true
               if(userAgentIdentService.isMobile()) {
				   //session['isMobile'] = true
			   }
            }
        }
    }
    
}
