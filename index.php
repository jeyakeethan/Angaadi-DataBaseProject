<?php
if(isset($_POST['username'])&&isset($_POST['password'])){
	$username = $_POST['username'];
	$password = MD5($_POST['password']);
	$conn = mysqli_connect("localhost", "public_access", "0000", "angaadi_users");
	$result0 = mysqli_query($conn, "SELECT customer_ID FROM users WHERE username='$username' LIMIT 1;");
	$result = mysqli_num_rows($result0);
	$result1 = mysqli_num_rows(mysqli_query($conn, "SELECT * FROM users WHERE username='$username' AND Password='$password' LIMIT 1;"));
	if($result==1){
		
		if($result1==1){
			$customer_ID = mysqli_fetch_row($result0)[0];
			setcookie("user", $username, time()+345600);
			setcookie("pass", $password, time()+345600);
			setcookie("customer", $customer_ID, time()+345600);
			if($username=='admin'){
				header("Location: adminhome.php");
			}
			else{
				header("Location: home.php");
			}
			
		}
		else{
			echo "Incorrect password, Try again!";
		}
	}
	else{
		echo "Incorrect User name!";
	}
}
else{
	if((isset($_COOKIE['guest'])||(isset($_COOKIE['user'])&&isset($_COOKIE['pass'])))){
		if($_COOKIE['user']=='admin'){
			header("Location: adminhome.php");
		}
		else{
			header("Location: home.php");
		}
		exit();
	}
}
?>
<html lang="en">
<head>
	<title>Login V10</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form method="post" action="index.php" class="login100-form validate-form">
					<span class="login100-form-avatar">
						<img src="images/avatar-01.jpg" alt="AVATAR">
					</span>
					<span class="login100-form-title">
						Welcome
					</span>
					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "Enter username">
						<input class="input100" type="text" name="username" id ="username">
						<span class="focus-input100" data-placeholder="username"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="Enter password">
						<input class="input100" type="password" name="password" id ="password">
						<span class="focus-input100" data-placeholder="password"></span>
					</div>

					<ul class="login-more p-t-20">
						<li class="m-b-8">
							<span class="txt1">
								Forgot
							</span>

							<a href="#" class="txt2">
								username / password?
							</a>
						</li>

						<li>
							<span class="txt1">
								Don’t have an account?
							</span>

							<a href="signup.php" class="txt2">
								Sign up&nbsp;|&nbsp;
								Guest Login
							</a>
						</li>
					</ul><div class="container-login100-form-btn">
					<input value="Login"  type="submit" class="login100-form-btn" id="login0">
					
				</div>
				</form>
			
				

			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>