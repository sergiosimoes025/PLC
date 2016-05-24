<?php

$param = $_REQUEST['name'];

require_once('./lib/nusoap.php');

$location = 'http://epl.di.uminho.pt/jcrbin/WebServices/nusoap-0.9.5/Hello/serv-hello.php';

$client = new nusoap_client($location, false);

//Call soap method

$result = $client->call('hello', array('name' => $param));

//Display the result
print_r($result);

?>
