package app.kermitvite

class EventResponseCountService {

    static transactional = true

    def count(def actualResponse, def gender, def eventResponses) {
		
		def filterredResponses = eventResponses.findAll {	response -> actualResponse.equalsIgnoreCase(response.response) && gender.equalsIgnoreCase(response.rosterMember.gender) }
		filterredResponses.size()
    }
	
	def countByEvent(def actualResponse, def gender, def event) {
		def filterredResponses = event?.eventResponses.findAll {	response -> actualResponse.equalsIgnoreCase(response.response) && gender.equalsIgnoreCase(response.rosterMember.gender) }
		filterredResponses.size()
	}
}
