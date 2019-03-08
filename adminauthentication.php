<?php
if($_COOKIE['user']!='admin'){
	echo 'You have no permission to access!';
	exit();
}
?>