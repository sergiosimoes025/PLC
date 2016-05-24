<?php
	require_once('bd.php');
	
	$nvs = $_GET;
	$bd = new myDB();
		
	$qstring = "INSERT INTO Student (name,number,email) VALUES ('".
	           $nvs['name']."','".$nvs['number']."','".
	           $nvs['email']."')";
	
	$bd->query($qstring);	
	
	echo "Registo gravado com sucesso. <br/> <a href='index.html'>Voltar ao nicio</a>";
?>