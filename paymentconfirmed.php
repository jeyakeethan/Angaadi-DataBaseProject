<?php
require_once 'header.php';
$deliverytext="";
if(isset($_GET['city'])){
	$shippingcity = $_GET['city'];
	$conn = mysqli_connect("localhost", "public_access", "0000", "angaadi");
	$result = mysqli_query($conn,"select * from main_city where mcity='$shippingcity'");
	$deliverytime=(mysqli_num_rows($result)==1)?3:5;
	$deliverytext = "<div class='col-md-6 mb-3'>Order will be delivered within: $deliverytime days</div>";
}
if(isset($_GET['order_ID'])&&isset($_GET['payment_ID'])){
	$order_ID = $_GET['order_ID'];
	$payment_ID = $_GET['payment_ID'];
	$query0 = "Select * FROM payment where order_ID='$order_ID' AND Payment_ID='$payment_ID' AND Payment_status='not paid' AND Payment_method='pay by card';";
	$result0 = mysqli_num_rows(mysqli_query($conn, $query0));
	if($result0!=0||isset($_GET['card'])){
		$query = "UPDATE payment SET Payment_status = 'paid' where payment_ID='$payment_ID';";
		$result = mysqli_query($conn, $query);
		if($result){echo "<div class='container2'>You Order has been paid Successfully. Your order wil be confirmed within few hours!</div>".$deliverytext;}
	}
	else{
		echo "<div class='container2'>You Order has been Recorded Successfully. Your order wil be Delivered!</div>".$deliverytext;
	}
}
?>
<!-- Custom js -->
<!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
<script src="js/jquery-3.3.1.min.js"></script>
<script type="text/JavaScript" src="js/custom_checkout.js"></script>
<?php require_once 'footer.php';?>