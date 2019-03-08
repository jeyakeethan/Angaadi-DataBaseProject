$('#createaccount').change(
	function(){
		if ($(this).prop('checked')){
			$('#username').attr('Hidden', false);
			$('#password').attr('Hidden', false);
			$('#username').attr('required', true);
			$('#password').attr('required', true);
		}
		else{
			$('#username').attr('Hidden', true);
			$('#password').attr('Hidden', true);
			$('#username').attr('required', false);
			$('#password').attr('required', false);
		}
	}

	
);