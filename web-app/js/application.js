var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}
var AddNewMember = {
		
	hideForm: function() {
		$('addMemberLink').show();
		$('addMemberAjax').update();
	},

	clearMessages: function() {
		
		if($('errorMessage') != null ) {
			
			$('errorMessage').update();
		}
		$$('.message').each(
				   function (message) {
				      message.hide();
				   } 
				);
	}
	
}

var CheckboxChanger = {
		
		onClickCheckBoxForTextField : function (checkBoxElement, textFieldElementId, textFieldValue) {
			if(checkBoxElement.checked == true) {
				$(textFieldElementId).enable();
				$(textFieldElementId).value = textFieldValue;
			} else {
				$(textFieldElementId).value = '';
				$(textFieldElementId).disable();
			}
		}
}

var TextAreaDivDisplayer = {
		
		display : function (triggerUpdateRow, divId, textAreaId, successMessageId) {
			$(triggerUpdateRow).hide();
			$(successMessageId).hide();
			$(textAreaId).value = '';
			$(divId).show();
			$(textAreaId).focus();
			$(textAreaId).selectionStart = 0;
			$(textAreaId).selectionEnd = 0;
		}
}

var SecurityQuestionAndAnswer = {
		
		confirmQA : function () {
			
			var question = $('question').value;
			var answer = $('answer').value;
			
			return confirm('You are about to set your security question as:\r\n\r\n' + question + '\r\n\r\nAnd your answer as:\r\n\r\n' + answer);
		}
}

var CheckboxChecker = {
		
		checkIfRostersSelected : function () {
			
    		var checkboxes  = $$('input[type="checkbox"][id^="roster-"]');
    		var onecheckboxSelected = false;
    		checkboxes.each ( function(checkbox) {
    		
    				if(checkbox.checked) {

    					onecheckboxSelected = true;
    				}
    		});
    		
    		if(!onecheckboxSelected) {
    			
    			return confirm("You did not select any rosters.\nClick OK to continue or\nclick Cancel if you wish to add a roster.");
    		}
    			
    		return true;
		}
}