		<?php
			// VERIFY IF FILE IS XML 
			$name_file = $_FILES['ficheiro_xml']['tmp_name'];
			$name = $_FILES["ficheiro_xml"]["name"];
			$ext = pathinfo($name, PATHINFO_EXTENSION);
			if(!strcmp($ext,"xml")){
				//AND VALIDATE IT WITH XSD FILE 
				$xmlDom = new DOMDocument();
				$xmlDom->load($name_file);

				$res = $xmlDom->schemaValidate('../xsd/biografias.xsd');
				if($res == 1){
					require_once('../../DB_connect.php');
					  
					$bd = new DB_CONNECT();
					$ficheiro = simplexml_load_file($_FILES['ficheiro_xml']['tmp_name']);
					$query = $bd->prepare("INSERT INTO biografia(data,sujeito,local,evento,nota) VALUES (STR_TO_DATE(:data,'%d/%m/%Y'),:sujeito,:local,:evento,:nota)");
					//$bd->exec("set names utf8");
					foreach($ficheiro->nota as $biografia) 
				    {
				        $query->bindValue(":data",(string)$biografia->data, PDO::PARAM_STR);
				        $query->bindvalue(":sujeito",(string)$biografia->sujeito,PDO::PARAM_STR);
				        if($biografia->local){
				        	$query->bindvalue(":local",ucfirst(strtolower((string)$biografia->local)),PDO::PARAM_STR);
				        	$query->bindvalue(":evento",(string)$biografia->evento,PDO::PARAM_STR);
				        }
				        else{
				        	$query->bindvalue(":local",ucfirst(strtolower((string)$biografia->evento->local)),PDO::PARAM_STR);
				        	$query->bindvalue(":evento",(string)strip_tags($biografia->evento->asXml()),PDO::PARAM_STR);
				        }
				        $query->bindValue(":nota",trim((string)strip_tags($biografia->asXml())), PDO::PARAM_STR);
				        $query->execute();
				        $query->closeCursor();
				    }
				    $db =null;
					$db2 = new DB_CONNECT();

					$dom = new DOMDocument('1.0', 'UTF-8');

					$element_raiz = $dom->createElement('arquivo_biografias');


					try {
					 
					foreach($db2->query('SELECT * from biografia') as $row) {
					      $biografia = $dom->createElement('biografia');
					      $data = $dom->createElement('data',$row['data']);
					      $sujeito = $dom->createElement('sujeito',$row['sujeito']);
					      $local = $dom->createElement('local',$row['local']);
					      $evento = $dom->createElement('evento',$row['evento']);
					      $nota = $dom->createElement('nota',$row['nota']);
					      
					      
					      $biografia->appendChild($data);
					      $biografia->appendChild($sujeito);
					      $biografia->appendChild($local);
					      $biografia->appendChild($evento);
					      $biografia->appendChild($nota);

					      $element_raiz->appendChild($biografia);
					  }
					  $db2 = null;
					}

					catch (PDOException $e) {
					      print "Error!: " . $e->getMessage() . "";
					  die();
					}
					$dom->appendChild($element_raiz);
					$dom->save('../xml/biografias_bd.xml');

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
		    else{
		    	header("Content-Type: application/json; charset=utf-8");
        		echo json_encode(array("message" => "Introduziu um ficheiro com extensão inválida!","code" => 401));
        		exit;
		    }
		?> 