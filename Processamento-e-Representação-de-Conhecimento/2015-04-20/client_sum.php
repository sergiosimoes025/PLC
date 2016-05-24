<?php

$n1 = $_REQUEST['n1'];
$n2 = $_REQUEST['n2'];

require_once('./lib/nusoap.php');

$location = 'http://epl.di.uminho.pt/jcrbin/WebServices/nusoap-0.9.5/Soma2nums/serv-ped-soma2nums.php';

$client = new nusoap_client($location, false);

# Usar isto para obter os erros na criação do cliente
$err = $client->getError();
if($err){
  die( "#1 - fault: " . $err );
}

//Call soap method
$result = $client->call('soma', array('n1' => $n1,'n2' => $n2));

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


?>
