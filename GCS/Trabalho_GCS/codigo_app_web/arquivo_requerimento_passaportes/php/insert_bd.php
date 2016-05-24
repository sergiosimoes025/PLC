<?php

require_once('../../DB_connect.php');
$connection = new DB_connect();
  
  move_uploaded_file($_FILES["ficheiro_sql"]["tmp_name"],"../sql/" . $_FILES["ficheiro_sql"]["name"]);
  $sql_filename = $_FILES["ficheiro_sql"]["name"];
  $sql_filename = "insert_bd.sql";
  $sql_contents = file_get_contents('../sql/'.$sql_filename);
  $sql_contents = explode(";", $sql_contents);
      
 
      
 foreach($sql_contents as $query){
      $result = $connection->exec($query);
   	}
 ?>
<meta charset="UTF-8">
<center>
 <h1> INSERÇÃO NA BD COM SUCESSO! </h1>
 <a href="../../index.php">Voltar ao início</a>
</center>