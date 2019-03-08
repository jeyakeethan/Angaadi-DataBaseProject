function login(){
	alert(87589);
	var username = $("#username").val().trim();
	var passhash = CryptoJS.MD5($("#password")).toString();

	if( username != "" && passhash != "" ){
		alert(87589);
		$.ajax({
			url:'index.php',
			type:'post',
			data:{username:username,password:passhash},
			success:function(response){
				var msg = "";
				if(response == 0){
					window.location = "signup.php";
				}else{
					msg = "Invalid username and password!";
				}
				$("#message").html(msg);
			}
		});
	}
	return false;
}
