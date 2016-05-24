
<html>
  <head>
      <meta charset="UTF-8">
      <title>Listar Registos</title>
      <link rel='stylesheet' type='text/css' href='../../css/stylesheet.css'/>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
      <script type="application/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  </head>
  

  <body style="">
       <div id="title">Registos</div> 
       
       
    <center>
      <div style="" id="titulo_listar">Autores</div>
      <br/> 
        <?php
          require_once '../../DB_connect.php';
          $db = new DB_CONNECT();
          
          try {
            $flag = 1;
            foreach($db->query('SELECT * from autores') as $row) {
               echo " <hr/>";
                $flag = 0;
               echo "<h3>".$row["nome"]."</h3><br/> ";
               echo "<p style=\"font-family:Arial;font-size:20px;font-style:italic;\">".$row["tipo"]."</p>";
              
            }
            
            if($flag == 1){
                echo "<h3> Sem autores inseridos </h3>";
            }
             else {
                    echo "<hr/>";
                }

            $db = null;
          } catch (PDOException $e) {
              print "Error!: " . $e->getMessage() . "";
          die();
          }           
        ?>
        
        
        
        
        
      <div id="titulo_listar">Fotos</div>
      <br/>
      <br/>
                
        <?php
          require_once '../../DB_connect.php';
          $db = new DB_CONNECT();
          $flag = 1;
          try {
              foreach($db->query('SELECT * from fotos order by nome_ficheiro') as $row) {
                  
                 $flag = 0;
                 echo "<div id=\"foto\">";
                 echo '<a href="../images/'.$row["nome_ficheiro"].'"><img onClick="swipe();" src="../images/'.$row["nome_ficheiro"].'" width="200" height="200" /></a></div><br />';
                 echo "<div id=\"imagem_descricao\"><b>Nome:</b>".$row["nome_ficheiro"]."<br/>
                 <b>Quem:</b>".$row["quem"]."<br/><b>Onde:</b>".
                 $row["onde"]."<br/><b>Quando:</b>".
                 $row["quando"]."<br/><b>Facto:</b>".
                 $row["facto"]."<br/><b>Legenda:</b>".
                 $row["legenda"]."<br/><b>Autor:</b>".
                 $row["nome_autor"]."</div>";
                 echo "<br/>";
              }
              if($flag == 1){
                  echo "<h3> Sem fotos inseridas</h3>";
              }
              $db = null;
          } catch (PDOException $e) {
              print "Error!: " . $e->getMessage() . "";
          die();
          }    
        ?>
      <br/>
      <br/>
      <hr/>
      <a style="font-variant: small-caps;color:#b43004;text-decoration: none;margin-top:100px;font-size:40px;" 
      href="../html/arquivo_fotografico.html"> Voltar </a> 
    </center>
  
  </body>
      
</html>