$(document).ready(function(){
	$('input[type=radio][name=deliverymethod]').change(
		function(){
			if ($('#doordelivery').prop("checked")){
				$('#addresscontainer').attr('Hidden', false);
				$('#first_name').attr('required', true);
				$('#lastt_name').attr('required', true);
				$('#street_address').attr('required', true);
				$('#city').attr('required', true);
				$('#state').attr('required', true);
				$('#zipCode').attr('required', true);
				$('#phone_number').attr('required', true);
				
			}
			else{
				$('#addresscontainer').attr('Hidden', true);
				$('#first_name').attr('required', false);
				$('#lastt_name').attr('required', false);
				$('#street_address').attr('required', false);
				$('#city').attr('required', false);
				$('#state').attr('required', false);
				$('#zipCode').attr('required', false);
				$('#phone_number').attr('required', false);
			}
		}
	);
});