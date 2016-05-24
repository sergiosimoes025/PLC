<html>
<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
    <body>
   
    <?php

	$dom = new DOMDocument('1.0', 'ISO-8859-1');
 
	$element_raiz = $dom->createElement('project-record');
	
	$meta = $dom->createElement('meta');
	$title = $dom->createElement('title',$_POST['title']);
	$subtitle = $dom->createElement('subtitle',$_POST['subtitle']);
	$key_name = $dom->createElement('key-name',$_POST['chave']);

	$meta->appendChild($title);
	$meta->appendChild($subtitle);
	$meta->appendChild($key_name);	
	
	$supervisors = $dom->createElement('supervisors');

	$name_sup = $_POST['name_super'];
   	$email_sup = $_POST['email_super'];
    
    foreach( $name_sup as $key => $n ) {
 		$supervisor = $dom->createElement('supervisor');
 		$sup_name = $dom->createElement('name',$n);
 		$sup_email = $dom->createElement('email',$email_sup[$key]);
 		$sup_homepage = $dom->createElement('homepage');	 

 		$supervisor->appendChild($sup_name);
 		$supervisor->appendChild($sup_email);
 		$supervisor->appendChild($sup_homepage);
 		$supervisors->appendChild($supervisor);
 		}
 	$meta->appendChild($supervisors);
	
 	$begin_date = $dom->createElement('begin-date',$_POST['begin-date']);
	$end_date = $dom->createElement('end-date',$_POST['end-date']);
	
	$meta->appendChild($begin_date);
	$meta->appendChild($end_date);
	$element_raiz->appendChild($meta);
	
	


	$name_worker = $_POST['worker_name'];
   	$email_worker = $_POST['worker_email'];
   	$id_worker = $_POST['worker_id'];



	$workteam = $dom->createElement('workteam');


	foreach ($id_worker as $key => $value) {
		$worker = $dom->createElement('student');
		$worker_id = $dom->createElement('ident',$value);
 		$worker_name = $dom->createElement('name',$name_worker[$key]);	 
 		$worker_email = $dom->createElement('email',$email_worker[$key]);	 
 		$worker->appendChild($worker_id);
 		$worker->appendChild($worker_name);
 		$worker->appendChild($worker_email);
		$workteam->appendChild($worker);
		}

	$element_raiz->appendChild($workteam);


	$abstract = $dom->createElement('abstract');
	$paragrafo = $dom->createElement('p',$_POST['abstract']);
	$abstract->appendChild($paragrafo);	
	$element_raiz->appendChild($abstract);	

	$logs = $dom->createElement('logs');
	$log = $dom->createElement('log');
	$log_date = $dom->createElement('date',$_POST['log_date']);
	$log_des = $dom->createElement('description',$_POST['log_des']);
	
	$log->appendChild($log_date);
	$log->appendChild($log_des);


	$logs->appendChild($log);

	$element_raiz->appendChild($logs);

	$ficheiros = $dom->createElement('deliverables');

	$nome_ficheiro = $_POST['file_name'];
	
	foreach($nome_ficheiro as $key => $value){
		$ficheiro = $dom->createElement('xref',$value);

		$ficheiro->setAttribute('url',$value);
		$ficheiros->appendChild($ficheiro);
	}	

	$element_raiz->appendChild($ficheiros);
	$dom->appendChild($element_raiz);
	$dom->save('project-record.xml');
	

	echo "<div> Resultado Validação </div>";

	if (!$dom->schemaValidate('./pr.xsd')) { 
		echo "<p>Ficheiro não é válido!!!<p/>";
		echo "<center><a href=\"http://localhost:8888/TPC_7/project_record_form.html\">ERROR</a></center>";
   		} 


		else {
		echo "<p>Ficheiro válido!!!<p/>"; 
		
		$logs = new DOMDocument();
		$var = date('H:i');
		$logs->load('logs.xml');
		$log = $logs->createElement('log');
		$log_data = $logs->createElement('data',$_POST['log_date']);
		$autores = $logs->createElement('autores');
		$log_hora = $logs->createElement('hora',$var);
		$log_titulo = $logs->createElement('titulo',$_POST['title']);
		
		$name_worker = $_POST['worker_name']; 

		foreach($name_worker as $key => $value){
		$log_name = $logs->createElement('autor',$value);
		$autores->appendChild($log_name);
		}	
		
		$log->appendChild($log_data);
		$log->appendChild($log_hora);
		$log->appendChild($log_titulo);
		$log->appendChild($autores);
		
		$logs->documentElement->appendChild($log);
 		$logs->formatOutput = true;
		$logs->save('logs.xml');
		
		echo "<center><a href=\"http://localhost:8888/TPC_7/resposta.php\">OK</a></center>";
		
		$resposta = new DOMDocument();
		$inicio = $reposta->createElement('<html>');
		$fim = $reposta->createElement('</html>');
		echo $resposta->saveHTML();



		}


    ?>
    </body>
</html>