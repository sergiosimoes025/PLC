<?php

require_once('../../DB_connect.php');
$conn = new DB_connect();


$query1 = "DELETE FROM Processo_Entidade";
$query2 = "DELETE FROM Destino_Entidade";
$query3 = "DELETE FROM Habilitacoes_entidade";
$query4 = "DELETE FROM Acompanhante";
$query5 = "DELETE FROM Processo";
$query6 = "DELETE FROM Entidade";

$conn->exec($query1);
$conn->exec($query2);
$conn->exec($query3);
$conn->exec($query4);
$conn->exec($query5);
$conn->exec($query6);
 ?>
<meta charset="UTF-8">
<center>
 <h1> REMOÇÃO NA BD COM SUCESSO! </h1>
 <a href="../../index.php">Voltar ao início</a>
</center>

