<?php

require_once('lib/nusoap.php');

$server = new soap_server;

$server->register('hello');

function hello($name){
  return 'hello, ' . $name;
}

$HTTP_RAW_POST_DATA = isset ...
