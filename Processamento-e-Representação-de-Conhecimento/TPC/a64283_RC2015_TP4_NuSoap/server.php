<?php



require_once('./lib/nusoap.php');

$server = new soap_server;
$server->register('contaNome', array('nome' => 'xsd:string'));
$server->register('listaProcesso',array('nome' => 'xsd:string'));


function contaNome($nome){
  
$xml = simplexml_load_file("xml/processos.xml");

$result = $xml->xpath("//processo[nome='".$nome."' or pai='".$nome."' or mae='".$nome."']");
$res = 0;
    foreach($result as $processo){
    $res++;
    }
    return $res;
}

function listaProcesso($nome){
    $doc = new DOMDocument;
    $doc->load('xml/processos.xml');
    $xpath = new DOMXPath($doc);
    $query = "//@id[../nome='".$nome."' or pai='".$nome."' or mae='".$nome."']";
    $entradas = $xpath->query($query);
    
    $response["ids"] = array();
    
    for($i=0;$i<$entradas->length;$i++){
        $id =$entradas->item($i)->nodeValue;
        array_push($response["ids"], $id);
    }

 return json_encode($response);
}


$HTTP_RAW_POST_DATA = isset($HTTP_RAW_POST_DATA) ? $HTTP_RAW_POST_DATA : '';
$server->service($HTTP_RAW_POST_DATA);

?>
