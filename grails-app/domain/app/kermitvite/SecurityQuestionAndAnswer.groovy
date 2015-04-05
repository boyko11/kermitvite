package app.kermitvite


class SecurityQuestionAndAnswer {
	
	String id
	String question
	String answer

    static constraints = {
		question(blank: false)
		answer(blank: false)
    }
	
	static mapping = {
		id generator: 'uuid'
	}
}
