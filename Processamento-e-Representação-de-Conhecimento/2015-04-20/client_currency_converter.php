<?php

if( isset($_REQUEST['de']) && isset($_REQUEST['para']) && isset($_REQUEST['valor']) ){
  $de = $_REQUEST['de'];
  $para = $_REQUEST['para'];
  $valor = $_REQUEST['valor'];

  require_once('./lib/nusoap.php');

  $location = 'http://www.webservicex.net/CurrencyConvertor.asmx?wsdl';

  $client = new nusoap_client($location, true);

  # Usar isto para obter os erros na criação do cliente
  $err = $client->getError();
  if($err){
    print( "#1 - error: " . $err );
  }

  //Call soap method
  $result = $client->call('ConversionRate', array('FromCurrency' => $de,'ToCurrency' => $para));
  
  # usar isto para ver se o serviço está incessível
  $err = $client->fault;
  if($err){
    print( "#2 - fault: " . $err );
  }else{
    # se não houver erros com o fault, verificar se houve erros ao usar o serviço
    $err = $client->getError();
    if($err){
      print( "#3 - error: " . $err );
    }
  }

  //print_r($result);

  print $valor . ' ' . $de . ' = ' . $result['ConversionRateResult'] * $valor . ' ' . $para;

  //htmlspecialchars($client->request);
  //htmlspecialchars($client->response);
  //htmlspecialchars($client->debug_str);
}else{
  require_once 'header.php';
?>

<div class="row">
<div class="col-lg-12">
<form action="client_currency_converter.php" method="POST">
  <input type="text" placeholder="valor" name="valor" />
  <select name="de">
    <?php include 'client_currency_converter_cur.php'; ?>
  </select>
  <select name="para">
    <?php include 'client_currency_converter_cur.php'; ?>
  </select>
  <input type="submit" value="Converter" />
</form>
</div>
</div>

<?php require_once 'footer.php'; } ?>
