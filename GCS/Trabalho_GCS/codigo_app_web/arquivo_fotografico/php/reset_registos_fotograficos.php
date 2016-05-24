<?php
	require_once '../../DB_connect.php';

	$db = new DB_CONNECT();

	$db->query("DELETE FROM fotos");
	$db->query("DELETE FROM autores");

	$files = glob('../images/*'); // get all file names
	foreach($files as $file){ // iterate files
		if(is_file($file))	
		    unlink($file); // delete file
	}

	$xml_file = "../xml/fotografias_bd.xml"; // get all file names
	if(is_file($xml_file))
		unlink($xml_file);// delete file
?>
