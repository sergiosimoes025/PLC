<?php

require_once('./lib/nusoap.php');

$server = new soap_server;

$server->register('sum', array('n1' => 'xsd:integer', 'n2' => 'xsd:integer'),
                         array('res' => 'xsd:integer' ));
$server->register('sub', array('n1' => 'xsd:integer', 'n2' => 'xsd:integer'),
                         array('res' => 'xsd:integer' ));
$server->register('div', array('n1' => 'xsd:integer', 'n2' => 'xsd:integer'),
                         array('res' => 'xsd:integer' ));
$server->register('mul', array('n1' => 'xsd:integer', 'n2' => 'xsd:integer'),
                         array('res' => 'xsd:integer' ));

function sum($n1, $n2){
  return $n1+$n2;
}

function sub($n1, $n2){
  return $n1-$n2;
}

function div($n1, $n2){
  return $n1/$n2;
}

function mul($n1, $n2){
  return $n1*$n2;
}

$HTTP_RAW_POST_DATA = isset($HTTP_RAW_POST_DATA) ? $HTTP_RAW_POST_DATA : '';
$server->service($HTTP_RAW_POST_DATA);

?>
