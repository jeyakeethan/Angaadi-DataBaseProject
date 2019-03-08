<?php
	if(isset($_GET['signout'])&&$_GET['signout']=='true'){
		setcookie("guest", "", time() - 3600);
		setcookie("user", "", time() - 3600);
		setcookie("pass", "", time() - 3600);
		echo '<meta http-equiv="refresh" content="0;url=index.php">';
	}
	$customer_ID = isset($_COOKIE['guest'])?$_COOKIE['guest']:null || isset($_COOKIE['user'])?$_COOKIE['user']:null;
	if(!(isset($_COOKIE['guest'])||isset($_COOKIE['user'])&&isset($_COOKIE['pass']))){
		echo '<meta http-equiv="refresh" content="0;url=index.php">';
		exit();
	}
	require_once 'adminauthentication.php';
	$conn = mysqli_connect("localhost", "root", "", "angaadi");
	$cart_page = "cart.php";
?>
<html lang="en">
<head>
<title>Admin Home</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles/cart_styles.css">
<link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">

</head>

<body>

<div class="super_container">

	<!-- Header -->
	
	<header class="header">

		<!-- Top Bar -->

		<div class="top_bar">
			<div class="container">
				<div class="row">
					<div class="col d-flex flex-row">
						<div class="top_bar_contact_item"><div class="top_bar_icon"><img src="images/phone.png" alt=""></div>+94 110000000</div>
						<div class="top_bar_contact_item">
							<div class="top_bar_icon"><img src="images/mail.png" alt=""></div><a href="mailto:angaadi@gmail.com">angaadi@gmail.com</a></div>
						<div class="top_bar_content ml-auto">
							<div class="top_bar_menu">
					
							</div>
							<div class="top_bar_user">
								<b><a href='?signout=true'>Sign Out</a></b>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</div>

		<!-- Header Main -->

		<div class="header_main">
			<div class="container">
				<div class="row">

					<!-- Logo -->
					<div class="col-lg-2 col-sm-3 col-3 order-1">
						<div class="logo_container">
							<div class="logo"><a href="index.php">OneTech</a></div>
						</div>
					</div>



					<!-- Wishlist -->
					<div class="col-lg-4 col-9 order-lg-3 order-2 text-lg-left text-right">
						<div class="wishlist_cart d-flex flex-row align-items-center justify-content-end">

						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Main Navigation -->

		<nav class="main_nav">
			<div class="container">
				<div class="row">
					<div class="col">

					</div>
				</div>
			</div>
		</nav>
	</header>
	</br>	<h3>Sales Report</h3>
	<form style='padding-left:100px;' method='get' action='#'>
		<input type='number' name='year' />
		<input type='submit' Value='View Report'/>
	</form>

<div class='container2'>
<!--==============================================================================================================================-->
<?php
if(isset($_GET['year'])){
	$year = $_GET['year'];
	$query="call sales_report($year) "; //********Change Query Here*********
$result = mysqli_query($conn, $query);
if($result){
	$record = mysqli_fetch_assoc($result);
	if(sizeof($record)!=0){
		echo '<table class="universal_table"><tr class="universal_table">';
			foreach($record as $key => $data){
				echo "<th class='universal_table'>$key</th>";
			}
			echo '</tr>';
		while($record){
			echo '<tr class="universal_table">';
			foreach($record as $key => $data){
				echo "<td class='universal_table' width='auto'>$data</td>";
				$data=null;
			}
			echo '</tr>';
			//echo '<td width="auto"><a class="_button" href="profile?client_id='.$customer[1].'">'.$customer[0].'</a></td>';
			$record = mysqli_fetch_row($result);
		}
		echo '</table>';
}}
}

?>
<!--==============================================================================================================================-->


</div>
<?php require_once 'footer.php';?>