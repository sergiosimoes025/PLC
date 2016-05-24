<?php
	require_once('bd.php');
	
	$bd = new myDB();
	$bd->query("DELETE * FROM Student");
	
	echo "Os logs foram apagados. <br/><a href='index.html'>Voltar ao in’cio</a>";
?>
