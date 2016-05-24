<?php
	require_once '../../DB_connect.php';

	$db = new DB_CONNECT();

	$db->query("DELETE FROM biografia");

	$xml_file = "../xml/biografias_bd.xml"; // get all file names
	if(is_file($xml_file))
		unlink($xml_file);// delete file
?>
