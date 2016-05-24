<?php

if( isset($_REQUEST['n1']) && isset($_REQUEST['n2']) && isset($_REQUEST['type']) ){
  $n1 = $_REQUEST['n1'];
  $n2 = $_REQUEST['n2'];
  $type = $_REQUEST['type'];

  require_once('./lib/nusoap.php');

  $location = 'http://127.0.0.1/prc/2015-04-20/server_contas.php';

  $client = new nusoap_client($location, false);

  # Usar isto para obter os erros na criação do cliente
  $err = $client->getError();
  if($err){
    die( "#1 - fault: " . $err );
  }

  //Call soap method
  $result = $client->call($type, array('n1' => $n1,'n2' => $n2));

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
      //Display the result
      print_r($result);
    }
  }

  //htmlspecialchars($client->request);
  //htmlspecialchars($client->response);
  //htmlspecialchars($client->debug_str);
}else{
  require_once 'header.php';
?>

<div class="row">
<div class="col-lg-12">
<form action="client_contas.php" method="GET">
  <input type="text" placeholder="n1" name="n1" />
  <input type="text" placeholder="n2" name="n2" />
  <select name="type">
    <option value="sum">Soma</option>
    <option value="sub">Subtração</option>
    <option value="div">Divisão</option>
    <option value="mul">Multiplicação</option>
  </select>
  <input type="submit" value="Submeter" />
</form>
</div>
</div>

<?php require_once 'footer.php'; } ?>
