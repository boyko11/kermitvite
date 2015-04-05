package app.kermitvite

import groovy.sql.Sql
import java.text.SimpleDateFormat

class QueryService {

	def dataSource
    static transactional = true

    def getAvailableRosterSubs(eventResponseId, gender) {
		
		def query = "select r.* from roster r " +
		"left join roster_roster_member rrm on r.id = rrm.roster_roster_members_id " +
		"left join roster_member rm on rrm.roster_member_id = rm.id " +
		"left join event_response er on rm.id = er.roster_member_id " +
		"where er.id = '${eventResponseId}'"
				
		def db = new Sql(dataSource)
		
		def subs = []
		db.eachRow(query, { resultRowRoster ->
			subs.addAll Roster.get(resultRowRoster.id).subs(gender)
		})
		db.close()
		
		def subsMap = [:]
		
		subs.each { sub ->
			subsMap."${sub.id}" = sub
		}		
		
		EventResponse.get(eventResponseId).event.eventResponses.each { eventResponse ->
			if(subsMap.containsKey(eventResponse.rosterMember.id)) {
				subsMap.remove eventResponse.rosterMember.id
			}
			
		}
		
		subsMap.values()
    }
	
	def generateFindAllEventsAndEventResponseByUsernameQuery (params, rosterMemberEmail){
		
		def query = "select e.id as eventId, e.name, e.location, e.time, e.response_lock_days, e.details, er.id as eventResponseId, er.response from event e " +
					"left join event_response er on e.id = er.event_id " +
					"left join roster_member rm on er.roster_member_id = rm.id " +
					"where rm.email = '${rosterMemberEmail}'"
		
		def now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
		
		if(params.filter == 'passed') {
			query += " and e.time < '${now}'"
		} else if (params.filter == 'future') {
			query += " and e.time > '${now}'"
		}
		
		if (params.sort) {
			query += " order by "
			if(params.sort == 'name') {
				query += "e.name "
			} else if (params.sort == 'location') {
				query += "e.location "
			} else if (params.sort == 'time') {
				query += "e.time "
			} else if (params.sort == 'response') {
				query += "er.response "
			}
			query += params.order
			query += " limit 100"
		}
		query
	}
}
