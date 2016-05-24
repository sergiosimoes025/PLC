<html>
    
  <head>
        
      <title>Listar registos</title>
      <link rel='stylesheet' type='text/css' href='../../css/stylesheet.css'/>
  </head>
  
  <body>

    <?php
      require_once '../../DB_connect.php';

      $db = new DB_CONNECT();

      $dom = new DOMDocument('1.0', 'UTF-8');
       
      $element_raiz = $dom->createElement('arquivo_biografias');


      try {
         
        foreach($db->query('SELECT * from biografia') as $row) {
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
          $db = null;
      }
       
      catch (PDOException $e) {
              print "Error!: " . $e->getMessage() . "";
          die();
      }
      $dom->appendChild($element_raiz);
      $dom->save('../xml/biografias_bd.xml');
       
      # START XSLT
      $xslt = new XSLTProcessor();
      $XSL = new DOMDocument();
      $XSL->load( '../xsl/listar_registos_biograficos.xsl', LIBXML_NOCDATA);
      $xslt->importStylesheet( $XSL );
      
      #PRINT
      print $xslt->transformToXML($dom);
    ?>
 
  
  </body>

</html>
