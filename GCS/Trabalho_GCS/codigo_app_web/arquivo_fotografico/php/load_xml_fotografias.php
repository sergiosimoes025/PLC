
<?php

      // FALTA VALIDAR SCHEMA

      //VALIDAR SE É UM FICHEIRO XML
$tmp_name = $_FILES["ficheiro_xml"]["tmp_name"];
$name = $_FILES["ficheiro_xml"]["name"];
$ext = pathinfo($name, PATHINFO_EXTENSION);
if(!strcmp($ext,"xml"))
{
  
        //VALIDAR COM XSD
  $xmlDom = new DOMDocument();
  $xmlDom->load($tmp_name);

  $res = $xmlDom->schemaValidate('../xsd/fotografias.xsd');
  if($res == 1){

    $path = $_POST["path_pasta"];
          // GUARDA NA BD
    require_once('../../DB_connect.php');
    
    $bd = new DB_CONNECT();
    $ficheiro = simplexml_load_file($tmp_name);

    $query = $bd->prepare("INSERT INTO autores(nome,tipo) VALUES (:nome,:tipo)");
    $bd->exec("set names utf8");
    foreach($ficheiro->autor as $autor) 
    {  
            //testar se não existe este autor já
      $sql = "SELECT * FROM autores WHERE nome=".$autor;
      if(!$bd->exec($sql)){
        $query->bindValue(":nome",(string)$autor, PDO::PARAM_STR);
        $query->bindvalue(":tipo",(string)$autor->attributes(),PDO::PARAM_STR);
        $query->execute();
        $query->closeCursor();
      }
    }

    $query2 = $bd->prepare("INSERT INTO fotos(nome_ficheiro,quem,onde,quando,facto,legenda,nome_autor) VALUES (:nome_ficheiro,:quem,:onde,:quando,:facto,:legenda,:nome_autor)");
    
          //para cada foto
    foreach($ficheiro->foto as $foto){
            //verifica se existe já existe a foto no back-end
      if(!file_exists("../images/" .(string)$foto->attributes())){
              //verifica se a foto existe mesmo na pasta/sitio que me disseram
        if(file_exists($path."/".(string)$foto->attributes())){
                //função para copiar a foto para o back-end
          copy($path."/".(string)$foto->attributes(), "../images/".(string)$foto->attributes());
          
          $query2->bindValue(":nome_ficheiro",(string)$foto->attributes(), PDO::PARAM_STR);
          $query2->bindValue(":quem",(string)$foto->quem, PDO::PARAM_STR);
          
          if (empty($foto->onde)) {
            
            $query2->bindValue(":onde", NULL, PDO::PARAM_NULL);
          } else {
            $query2->bindValue(":onde", (string) $foto->onde, PDO::PARAM_STR);
          }
          
          if (empty($foto->facto)) {
            
            $query2->bindValue(":facto", NULL, PDO::PARAM_NULL);
          } else {
            $query2->bindValue(":facto", (string) $foto->facto, PDO::PARAM_STR);
          }
          
          if (empty($foto->legenda)) {
            
            $query2->bindValue(":legenda", NULL, PDO::PARAM_NULL);
          } else {
            $query2->bindValue(":legenda", (string) $foto->Legenda, PDO::PARAM_STR);
          }
          
          $time = strtotime($foto->quando->attributes());
          $newformat = date('Y-m-d',$time);
          $query2->bindValue(":quando",$newformat, PDO::PARAM_STR);
          
          $sql3 = "SELECT * FROM autores WHERE nome=".$foto->autor;
          if($bd->query($sql3) == false && !empty($foto->autor)){
            $sql4 = $bd->prepare("INSERT INTO autores(nome,tipo) VALUES (:nome,:tipo)");
            $sql4->bindValue(":nome",(string)$foto->autor, PDO::PARAM_STR);
            $sql4->bindValue(":tipo",(string)$foto->autor->attributes(), PDO::PARAM_STR);
            $sql4->execute();
            $sql4->closeCursor();
          }
          
          if(empty($foto->autor)){
            
            $query2->bindValue(":nome_autor",NULL, PDO::PARAM_NULL);
            $query2->execute();
            $query2->closeCursor();   
          }
          else {
            $query2->bindValue(":nome_autor",(string)$foto->autor, PDO::PARAM_STR);
            $query2->execute();
            $query2->closeCursor();   
          }
          
        }
        else{
                // header("Content-Type: application/json; charset=utf-8");
                // echo json_encode(array("message" => $path.(string)$foto->attributes()." não existe!","code" => 401));
                // exit;
        }
      }
      else{
              // header("Content-Type: application/json; charset=utf-8");
              // echo json_encode(array("message" => "A foto ".$foto->attributes()." já existe no sistema!","code" => 401));
              // exit;
      }        
    }

          //CRIAR FICHEIRO XML (BD)
    $db2 = new DB_CONNECT();

    $dom = new DOMDocument('1.0', 'UTF-8');
    
    $element_raiz = $dom->createElement('fotos');


    try {
     
      foreach($db2->query('SELECT * from fotos') as $row) {
        $foto = $dom->createElement('foto');
        $foto->setAttribute('nome_ficheiro', $row['nome_ficheiro']);
        $quem = $dom->createElement('quem',$row['quem']);
        $quando = $dom->createElement('quando');
        $quando->setAttribute('data',$row['quando']);
        $onde = $dom->createElement('onde',$row['onde']);
        $facto = $dom->createElement('facto',$row['facto']);
        $legenda = $dom->createElement('legenda',$row['legenda']);
        $autor = $dom->createElement('autor',$row['nome_autor']);
        
        
        $foto->appendChild($quem);
        $foto->appendChild($quando);
        $foto->appendChild($onde);
        $foto->appendChild($facto);
        $foto->appendChild($legenda);
        $foto->appendChild($autor);

        $element_raiz->appendChild($foto);
      }
      $db2 = null;
    }
    
    catch (PDOException $e) {
      print "Error!: " . $e->getMessage() . "";
      die();
    }
    $dom->appendChild($element_raiz);
    $dom->save('../xml/fotografias_bd.xml');
    
    header("Content-Type: application/json; charset=utf-8");
    echo json_encode(array("message" => "Dados submetidos com sucesso","code" => 200));
    exit;
  }
  else{
    header("Content-Type: application/json; charset=utf-8");
    echo json_encode(array("message" => "Introduziu um ficheiro XML inválido!","code" => 401));
    exit;
  }
}
else
{
  header("Content-Type: application/json; charset=utf-8");
  echo json_encode(array("message" => "Introduziu um ficheiro com extensão inválida!","code" => 401));
  exit;
}
?>

