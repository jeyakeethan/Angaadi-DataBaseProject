<?php
$cart_page = "cart.php";
if(isset($_COOKIE['guest']))$quest = $_COOKIE['guest'];
if(isset($_COOKIE['user']))$user = $_COOKIE['user'];
$customer_ID = $quest?$quest:$user;
?>