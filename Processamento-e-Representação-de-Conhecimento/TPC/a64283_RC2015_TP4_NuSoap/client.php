<?php

if(isset($_REQUEST["name"]) && isset($_REQUEST["type"])){

$nome = $_REQUEST["name"];
$type = $_REQUEST["type"];

require_once('./lib/nusoap.php');
$location = 'http://localhost:8888/a64283_RC2015_TP4_NuSoap/server.php';
$client = new nusoap_client($location, false);

$result = $client->call($type, array('nome' => $nome));

# Usar isto para obter os erros na criação do cliente
$err = $client->getError();
if($err){
  die( "#1 - fault: " . $err );
}

# usar isto para ver se o serviço está incessível
$err = $client->fault;
if($err){
  die( "#2 - fault: " . $err );
}else{
  # se não houver erros com o fault, verificar se houve erros ao usar o serviço
  $err = $client->getError();
  if($err){
    die( "#3 - fault: " . $err );
  }else{
   if($type == 'contaNome'){
   echo "<div class='text-center'> O número de nomes iguais a '".$nome."' é : ";
   print_r($result);
   echo "</div>";
   }
   else {
  $ids = json_decode($result);

  echo "<h2> Lista de IDS</h2><ul>";
   foreach($ids as $id){
   print_r($id);
   }
   echo "</ul>";
   }
  }
 }
}

else{
  require_once 'header.php';
?>

<div class="row">
<div class="col-lg-12">
<form action="client.php" method="GET">
  <label for="name">Nome</label>
  <input type="text" placeholder="Abel Almeida" name="name" />

  <select name="type">
    <option value="contaNome">Contar nomes</option>
    <option value="listaProcesso">Listar processos</option>
  </select>
  <input type="submit" value="Submeter" />
</form>
</div>
</div>

<?php require_once 'footer.php'; } ?>

