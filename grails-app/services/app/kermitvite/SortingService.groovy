package app.kermitvite

class SortingService {

    static transactional = true

    def sort(listToSort, params, defaultSortField, defaultSortOrder) {
		
		if(!params.sort){
			params.sort = defaultSortField
		}
		if(!params.order){
			params.order = defaultSortOrder
		}
		
		int maxRecords = Math.min(params.max ? params.int('max') : 25, 100)
		
		int offsetRecords = params.offset ?  params.int('offset') : 0
		
		List rosterMembersList = listToSort.asList()
		
		rosterMembersList.each {
			if(it."${params.sort}" instanceof Boolean == false) {
				it."${params.sort}" = it."${params.sort}".capitalize()
			}
		}
		
		rosterMembersList.sort {it."${params.sort}"}
		
		if(params.order == "desc") {
			rosterMembersList.sort{it."${params.sort}"}.reverse()
		}
		
		def upperLimit = offsetRecords + maxRecords
		
		if (upperLimit > rosterMembersList.size()) {
			
			upperLimit = rosterMembersList.size()
		}
		
		rosterMembersList.subList offsetRecords, upperLimit
		
    }
}
