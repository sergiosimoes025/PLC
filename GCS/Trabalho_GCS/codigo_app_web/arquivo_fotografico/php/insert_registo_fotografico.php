<?php
  //CARREGAR BD
  require_once('../../DB_connect.php');
  	
  $dados = $_POST;
  $bd = new DB_CONNECT();

  if(isset($dados['autor']) && !empty($dados['autor'])){
      $sql = "SELECT * FROM autores WHERE nome=".$dados['autor'];
      if($bd->query($sql) == false){
        $bd->query("INSERT INTO autores(nome,tipo) VALUES('".$dados['autor']."','".$dados['tipo_autor']."')");
      }
  }  

    move_uploaded_file($_FILES["nome_ficheiro"]["tmp_name"],"../images/" . $_FILES["nome_ficheiro"]["name"]);
    
    $query2  = $bd->prepare("INSERT INTO fotos(nome_ficheiro,quem,onde,quando,facto,legenda,nome_autor) VALUES (:nome_ficheiro,:quem,:onde,:quando,:facto,:legenda,:nome_autor)");
    $query2->bindValue(":nome_ficheiro",$_FILES["nome_ficheiro"]["name"], PDO::PARAM_STR);
    $query2->bindValue(":quem",$dados['quem'], PDO::PARAM_STR);

    $xml_add  = '<foto nome_ficheiro="'.$_FILES["nome_ficheiro"]["name"].'">';
    $xml_add .= "<quem>".$dados['quem']."</quem>";

    if(!empty($dados['quando'])){
      $query2->bindValue(":quando",$dados['quando'], PDO::PARAM_STR); 
      $xml_add .= '<quando data="'.$dados['quando'].'" />';
    }
    else 
    {
      $query2->bindValue(":quando",NULL, PDO::PARAM_NULL);   
      $xml_add .= '<quando />'; 
    }

    if(!empty($dados['onde']))
    {
      $query2->bindValue(":onde",$dados['onde'], PDO::PARAM_STR);
      $xml_add .= '<onde>'.$dados['onde'].'</onde>';
    }
    else 
    {
      $query2->bindValue(":onde",NULL, PDO::PARAM_NULL);  
      $xml_add .= '<onde />';
    }

    if(!empty($dados['facto'])){
      $query2->bindValue(":facto",$dados['facto'], PDO::PARAM_STR); 
      $xml_add .= '<facto>'.$dados['facto'].'</facto>';
    }
    else {
      $query2->bindValue(":facto",NULL, PDO::PARAM_NULL);  
      $xml_add .= '<facto />'; 
    }

    if(!empty($dados['legenda'])){
      $query2->bindValue(":legenda",$dados['legenda'], PDO::PARAM_STR);
      $xml_add .= '<legenda>'.$dados['legenda'].'</legenda>';
    }
    else {
      $query2->bindValue(":legenda",NULL, PDO::PARAM_NULL); 
      $xml_add .= '<legenda />';  
    }

    if (!empty($dados['autor'])) {
      $query2->bindValue(":nome_autor", NULL, PDO::PARAM_NULL);
      $xml_add .= '<autor>'.$dados['autor'].'</autor>';
    } else {
      $query2->bindValue(":nome_autor", $dados['autor'], PDO::PARAM_STR);
      $xml_add .= '<autor />';
    }

    $query2->execute();
    $query2->closeCursor(); 
  

  //ADICIONAR / CRIAR XML
  if(file_exists("../xml/fotografias_bd.xml")){
    $xml_load = simplexml_load_file("../xml/fotografias_bd.xml");
    $xml_str = "<fotos>";
    foreach($xml_load as $element)
      $xml_str .= $element->asXML();

    $xml_str .= $xml_add.'</foto></fotos>';
    file_put_contents("../xml/fotografias_bd.xml",$xml_str);
  }
  else{
    $xml_str = '<fotos>'.$xml_add.'</foto></fotos>';
    $myfile = fopen("../xml/fotografias_bd.xml", "w");
    fwrite($myfile, $xml_str);
    fclose($myfile);
  }

  

  header("Content-Type: application/json; charset=utf-8");
  echo json_encode(array("message" => "Dados submetidos com sucesso","code" => 200));
  exit;
?>