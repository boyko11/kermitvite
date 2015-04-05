package app.kermitvite

class SortingEventsService {

    static transactional = true

    def sort(listToSort, params, defaultSortField, defaultSortOrder) {
		
		if(!params.sort){
			params.sort = defaultSortField
		}
		if(!params.order){
			params.order = defaultSortOrder
		}
		
		if(params.sort != "response") {
			return sortByRosterMember(listToSort, params)
		}
		
		listToSort.each {it."${params.sort}" = it."${params.sort}".capitalize()}
		listToSort.sort{it."${params.sort}"}
		if(params.order == "desc") {
			listToSort = listToSort.sort{it."${params.sort}"}.reverse()
		} else {
			listToSort = listToSort.sort{it."${params.sort}"}
		}
		
    
		def listToSortFemaleYes = listToSort.findAll { it.rosterMember.gender == 'Female' && it.response.contains('Yes') }
		def listToSortMaleYes = listToSort.findAll { it.rosterMember.gender == 'Male' && it.response.contains('Yes') }
		def listToSortNoGenderYes = listToSort.findAll { it.rosterMember.gender != 'Male' && it.rosterMember.gender != 'Female' && it.response.contains('Yes') }
		
		def listToSortFemaleNo = listToSort.findAll { it.rosterMember.gender == 'Female' && it.response.contains('No') }
		def listToSortMaleNo = listToSort.findAll { it.rosterMember.gender == 'Male' && it.response.contains('No') }
		def listToSortNoGenderNo = listToSort.findAll { it.rosterMember.gender != 'Male' && it.rosterMember.gender != 'Female' && it.response.contains('No') }
		
		def listToSortFemaleNoResponse = listToSort.findAll { it.rosterMember.gender == 'Female' && it.response.contains("Has not responded yet") }
		def listToSortMaleNoResponse = listToSort.findAll { it.rosterMember.gender == 'Male' && it.response.contains("Has not responded yet") }
		def listToSortNoGenderNoResponse = listToSort.findAll { it.rosterMember.gender != 'Male' && it.rosterMember.gender != 'Female' && it.response.contains("Has not responded yet") }
		
		
		def listToReturn = listToSortFemaleYes
		listToReturn.addAll listToSortMaleYes
		listToReturn.addAll listToSortNoGenderYes
		listToReturn.addAll listToSortFemaleNo
		listToReturn.addAll listToSortMaleNo
		listToReturn.addAll listToSortNoGenderNo
		listToReturn.addAll listToSortFemaleNoResponse
		listToReturn.addAll listToSortMaleNoResponse
		listToReturn.addAll listToSortNoGenderNoResponse
		
		if(params.order == "desc") {
			
			listToReturn
		} else {
		
			listToReturn = listToReturn.toArray().reverse()
		}
		
    }
	
	def sortByRosterMember(listToSort, params){
		
		listToSort.each {it.rosterMember."${params.sort}" = it.rosterMember."${params.sort}".capitalize()}
		listToSort.sort{it.rosterMember."${params.sort}"}
		if(params.order == "desc") {
			listToSort.sort{it.rosterMember."${params.sort}"}.reverse()
		} else {
			listToSort.sort{it.rosterMember."${params.sort}"}
		}

	}
}
