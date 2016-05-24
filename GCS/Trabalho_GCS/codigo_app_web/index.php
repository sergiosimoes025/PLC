<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0"> 

  <link rel="stylesheet" type="text/css" href="css/default.css" />
  <link rel="stylesheet" type="text/css" href="css/component.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" >
  <link rel="stylesheet" type="text/css" href="css/jquery.growl.css" >


  <title>Base de dados de Emigração</title>
</head>

<body class="cbp-spmenu-push" style="font-family: 'Lato', Calibri, Arial, sans-serif;">

<nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom" id="cbp-spmenu-s4">
  <h3>Créditos</h3>
  <p style="border-left:0px;">Fernando Martins - PG25297</p>
  <p>Hélder Rocha - PG27737</p>
  <p>Sérgio Simões - A64283</p>
  <p>Tiago Martins - PG25306</p>
</nav>

<div class="container">
  
  <header class="clearfix">
    <span style="display:block;">Processamento e Representação de Informação</span>
    <h1>Base dados de Emigração</h1>
    <div class="masthead">
      <nav>
        <ul class="nav nav-justified" style="margin-top:20px;">
          <li class="active"><a href="#">Ínicio</a></li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Arquivo Fotográfico<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-header">Registos</li>
              <li><a href="arquivo_fotografico/html/adicionar_registos_fotograficos.html">Adicionar</a></li>
              <li><a class="resetButton" href="arquivo_fotografico/php/reset_registos_fotograficos.php">Remover</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Arquivo Biográfico<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-header">Registos</li>
              <li><a href="arquivo_biografico/html/adicionar_registos_biograficos.html">Adicionar</a></li>
              <li><a class="resetButton" href="arquivo_biografico/php/reset_registos_biograficos.php">Remover</a></li>
            </ul>
          </li>
 	  <li><a href="arquivo_requerimento_passaportes/html/adicionar_registos_passaporte.html">A.R.P.</a></li>
          <li><a href="relatorio/php/relatorio.php">Relatório</a></li>
          <li><a id="showBottom" href="#">Créditos</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <div class="main">
    <div class="row">
      <center>
        <div class="col-md-6">
          <h2>Arquivo Fotográfico</h2>
          <h5>Número de registos: <?php 
            if(is_file('arquivo_fotografico/xml/fotografias_bd.xml')){
              $ficheiro = simplexml_load_file('arquivo_fotografico/xml/fotografias_bd.xml');
              $fotos = $ficheiro->xpath("//foto");
              echo count($fotos);
            }
            else{
              echo "0";
            }
          ?></h5>

          <h3>Índice de Autores (<?php 
            if(is_file('arquivo_fotografico/xml/fotografias_bd.xml')){
              $ficheiro = simplexml_load_file('arquivo_fotografico/xml/fotografias_bd.xml');
              $autores = $ficheiro->xpath("//autor[not(.=following::autor)]");
              echo count($autores);
            }
            else{
              echo "0";
            }
          ?>)</h3>
            <?php
              if(is_file('arquivo_fotografico/xml/fotografias_bd.xml')){
                $ficheiro = simplexml_load_file('arquivo_fotografico/xml/fotografias_bd.xml');
                $autores_aux = $ficheiro->xpath("//autor[not(.=following::autor)]");
                $autores=array_map('trim',$autores_aux);
                sort($autores);
                foreach($autores as $key => $autor)
                { 
                  echo "<h5><a href=\"arquivo_fotografico/html_listagem/".$autor.".html\">".$autor."</a></h5>";
                }
              }
              else{
                echo "<h5>Não existem registos fotográficos no sistema!</h5>";
              }
            ?>        
        </div>
        <div class="col-md-6">
          <h2>Arquivo Biográfico</h2>
          <h5>Número de registos: <?php 
            if(is_file('arquivo_biografico/xml/biografias_bd.xml')){
              $ficheiro = simplexml_load_file('arquivo_biografico/xml/biografias_bd.xml');
              $notas = $ficheiro->xpath("//biografia");
              echo count($notas);
            }
            else{
              echo "0";
            }
          ?></h5>
          
          <h3>Índice de Sujeitos (<?php 
            if(is_file('arquivo_biografico/xml/biografias_bd.xml')){
              $ficheiro = simplexml_load_file('arquivo_biografico/xml/biografias_bd.xml');
              $sujeitos = $ficheiro->xpath("//sujeito[not(.=following::sujeito)]");
              echo count($sujeitos);
            }
            else{
              echo "0";
            }
          ?>)</h3>
          
            <?php
              if(is_file('arquivo_biografico/xml/biografias_bd.xml')){
                $ficheiro = simplexml_load_file('arquivo_biografico/xml/biografias_bd.xml');
                $sujeitos_aux = $ficheiro->xpath("//sujeito[not(.=following::sujeito)]");
                $sujeitos=array_map('trim',$sujeitos_aux);
                sort($sujeitos);
                foreach($sujeitos as $sujeito)
                { 
                  echo "<h5><a href=\"arquivo_biografico/html_listagem/".$sujeito.".html\">".$sujeito."</a></h4>";
                }
              }
              else{
                echo "<h5>Não existem registos biográficos no sistema!</h5>";
              }
              // SORT, tentar depois
              // foreach ($xml->responsedata->databases->database as $db) {
              //   $dbs[(string)$db->name] = $db;
              // }

              // ksort($dbs);
            ?>
          
          
        </div>
      </center>
    </div>
  </div>

</div>

<script src="js/jquery-2.1.3.min.js"></script>
<script src="js/jquery.growl.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.custom.js"></script>
<script src="js/classie.js"></script>
<script src="js/custom.js"></script>

      <?php

        $header = "
          <html>
            <head>
              <meta charset='UTF-8'>
              <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'> 
              <meta name='viewport' content='width=device-width, initial-scale=1.0'> 
              <link rel='stylesheet' type='text/css' href='../../css/default.css' />
              <link rel='stylesheet' type='text/css' href='../../css/component.css' />
              <link rel='stylesheet' type='text/css' href='../../css/bootstrap.min.css' />
              <link rel='stylesheet' type='text/css' href='../../css/font-awesome.min.css' />
        ";

          $nav = "<body class='cbp-spmenu-push' style='font-family: \"Lato\", Calibri, Arial, sans-serif;'>
                    <nav class='cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom' id='cbp-spmenu-s4'>
                      <h3>Créditos</h3>
                      <p style='border-left:0px;'>Fernando Martins - PG25297</p>
                      <p>Helder Rocha - PG27737</p>
                      <p>Sergio Simões - A64283</p>
                      <p>Tiago Martins - PG25306</p>
                    </nav>

                    <div class='container'>
                      
                      <header class='clearfix'>
                        <span style='display:block;'>Processamento e Representação de Informação</span>
                        <h1>Base dados de Emigração</h1>
                        <div class='masthead'>
                          <nav>
                            <ul class='nav nav-justified' style='margin-top:20px;'>
                              <li class='active'><a href='../../index.php'>Ínicio</a></li>
                              <li class='dropdown'>
                                <a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-expanded='false'>Arquivo Fotográfico<span class='caret'></span></a>
                                <ul class='dropdown-menu' role='menu'>
                                  <li class='dropdown-header'>Registos</li>
                                  <li><a href='../../arquivo_fotografico/html/adicionar_registos_fotograficos.html'>Adicionar</a></li>
                                  <li><a class=\"resetButton\" href='../../arquivo_fotografico/php/reset_registos_fotograficos.php'>Remover</a></li>
                                </ul>
                              </li>
                              <li class='dropdown'>
                                <a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-expanded='false'>Arquivo Biográfico<span class='caret'></span></a>
                                <ul class='dropdown-menu' role='menu'>
                                  <li class='dropdown-header'>Registos</li>
                                  <li><a href='../../arquivo_biografico/html/adicionar_registos_biograficos.html'>Adicionar</a></li>
                                  <li><a class=\"resetButton\" href='../../arquivo_biografico/php/reset_registos_biograficos.php'>Remover</a></li>
                                </ul>
                              </li>
                              <li><a href='../../arquivo_requerimento_passaportes/html/adicionar_registos_passaporte.html'>A.R.P.</a></li>
                              <li><a href='../../relatorio/php/relatorio.php'>Relatorio</a></li>
                              <li><a id='showBottom' href='#'>Créditos</a></li>
                            </ul>
                          </nav>
                        </div>
                      </header>

                     <div class='main'>
                        
                      ";

          $footer = "</div>
                  </div>
                  <script src='../../js/jquery-2.1.3.min.js'></script>
                  <script src='../../js/bootstrap.min.js'></script>
                  <script src='../../js/modernizr.custom.js'></script>
                  <script src='../../js/classie.js'></script>
                  <script src='../../js/custom.js'></script>
                </body>
              </html>";

        //BIOGRAFIA
        if(is_file('arquivo_biografico/xml/biografias_bd.xml'))
        {
          $ficheiro = simplexml_load_file('arquivo_biografico/xml/biografias_bd.xml');
          $sujeitos_aux = $ficheiro->xpath("//sujeito[not(.=following::sujeito)]");

          $sujeitos=array_map('trim',$sujeitos_aux);
          sort($sujeitos);
          $keys = array_keys($sujeitos);
          foreach(array_keys($keys) AS $k )
          { 
            $sujeito = $sujeitos[$keys[$k]];
            $nextval = $sujeitos[$keys[$k+1]];
            $prevval = $sujeitos[$keys[$k-1]];
            if($nextval==null){$nextval = $sujeitos[$keys[0]];}
            if($prevval==""){
              $prevval = $sujeitos[$keys[count(sujeitos)+1]];}
            $href = trim((string)$sujeito);
            $href_next = trim((string)$nextval);
            $href_prev = trim((string)$prevval);

            $myfile = fopen("arquivo_biografico/html_listagem/".$href.".html", "w");
            fwrite($myfile, "");

            $body = $header."<title>Notas Biográficas de ".$sujeito."</title></head>".$nav."<h2>Notas Biográficas de ".$sujeito."</h2><hr/>";
    
            $body .= "<div class='row'><div class='col-md-12'>";

            $notas_sujeito = $ficheiro->xpath("//biografia[sujeito=\"".$sujeito."\"]");
            foreach($notas_sujeito as $nota)
            {
              $body .= '
                <dl class="dl-horizontal">
                  <dt>Data</dt>
                  <dd>'. $nota->data .'</dd>
                  <dt>Local</dt>
                  <dd>'. $nota->local .'</dd>
                  <dt>Evento</dt>
                  <dd>'. $nota->evento .'</dd>
                  <dt>Nota Biográfica</dt>
                  <dd>'. $nota->nota .'</dd>
                </dl>
              ';
            }

            $body .= "</div>
              <nav style='margin-bottom:70px;'>
                <ul class='pager'>
                  <li><a href=\"".$href_prev.".html\">&larr; Anterior</a></li>
                  <li><a href=\"".$href_next.".html\">Próximo &rarr;</a></li>
                </ul>
              </nav>            
            </div>". $footer;

            fwrite($myfile, $body);

            fclose($myfile);
          } 
        }

        //FOTOGRAFIA
        if(is_file('arquivo_fotografico/xml/fotografias_bd.xml'))
        {
          $ficheiro = simplexml_load_file('arquivo_fotografico/xml/fotografias_bd.xml');

          $fotos_sem_autor = $ficheiro->xpath("//foto[not(autor)]");
          //FOTOS SEM AUTOR
          if(count($fotos_sem_autor) > 0)
          {

            $pag_sem_autor =  fopen("arquivo_fotografico/html_listagem/Sem_autor.html", "w");

            $file_init = "<html>
              <head>
                <meta charset=\"UTF-8\">
                    <title>Listar Registos</title>
                    <link rel='stylesheet' type='text/css' href='../../css/stylesheet.css'/>
              </head>


              <body>
                <center>
                  <div id=\"titulo_listar\">Fotos sem Autor
                  </div>
                  </center>
            ";
            
            fwrite($pag_sem_autor, $file_init);
            $flag = 0;  

            foreach ($fotos_sem_autor as $foto_sem_autor) 
            {
              $flag = 1;
              $foto_sem_autor->attributes();

              $file_foto_name = "<ul>
                         <li> ".$foto_sem_autor->attributes().

                   "</li>";

              $file_foto_des = "
              <ul>  
                <li>".$foto_sem_autor->quem."</li>
                <li>".$foto_sem_autor->quando->attributes()."</li>
                <li>".$foto_sem_autor->onde."</li>
                <li>".$foto_sem_autor->facto."</li>
                <li>".$foto_sem_autor->legenda."</li>
              </ul>
              <hr/> 
              ";

              if($flag == 1){
               fwrite($pag_sem_autor, $file_foto_name);
               fwrite($pag_sem_autor, $file_foto_des);        
                }
           
            }

            if($flag == 0){
              $vazio = "<h2> Não existem fotos</h2>";
              fwrite($pag_sem_autor, $vazio);
              }

            $file_end = "
              </ul>
              </body>
            </html> 
               ";

              fwrite($pag_sem_autor, $file_end);  
            fclose($pag_sem_autor);

          }

          //FOTOS COM AUTOR
          $autores_aux = $ficheiro->xpath("//autor[not(.=following::autor)]");
          $autores=array_map('trim',$autores_aux);
          sort($autores);
          $keys = array_keys($autores);
          foreach(array_keys($keys) AS $k )
          { 
            $autor = $autores[$keys[$k]];
            $nextval = $autores[$keys[$k+1]];
            $prevval = $autores[$keys[$k-1]];
            if($nextval==null){$nextval = $autores[$keys[0]];}
            if($prevval==""){$prevval = $autores[$keys[count(autores)+1]];}

            $href = trim((string)$autor);
            $href_next = trim((string)$nextval);
            $href_prev = trim((string)$prevval);

            $body = '';

            $myfile = fopen("arquivo_fotografico/html_listagem/".$href.".html", "w");
            $fotos_de_autor = $ficheiro->xpath("//foto[contains(autor,'".$autor."')]"); 

            $body .= $header."<title>Fotos de ".$autor."</title></head>".$nav."<h2>Fotos de ".$autor."</h2><hr/>";


            foreach($fotos_de_autor as $foto_de_autor)
            {
              $body .= 
                "<div class='row'>
                  <div class='col-md-4'>
                    <a href='#' class='thumbnail'>
                      <img src='../images/".$foto_de_autor->attributes()."' alt='foto'>
                    </a>
                  </div>
                  <div class='col-md-8'>
                    <dl class='dl-horizontal'>
                ";

              if(strlen($foto_de_autor->quem))
                $body .= "<dt>Quem</dt><dd>".$foto_de_autor->quem."</dd>";
              
              if(strlen($foto_de_autor->quando))
                $body .= "<dt>Quando</dt><dd>".$foto_de_autor->quando->attributes()."</dd>";

              if(strlen($foto_de_autor->onde))
                $body .="<dt>Onde</dt><dd>".$foto_de_autor->onde."</dd>";

              if(strlen($foto_de_autor->facto))
                $body .= "<dt>Facto</dt><dd>".$foto_de_autor->facto."</dd>";

              if(strlen($foto_de_autor->legenda))
                $body .= "<dt>Legenda</dt><dd>".$foto_de_autor->legenda."</dd>";

              $body .="</dl></div></div>";
            }

            $body .= "</div>
              <nav style='margin-bottom:70px;'>
                <ul class='pager'>
                  <li><a href=\"".$href_prev.".html\">&larr; Anterior</a></li>
                  <li><a href=\"".$href_next.".html\">Próximo &rarr;</a></li>
                </ul>
              </nav>
            </div>".$footer;

            fwrite($myfile, $body); 
            fclose($myfile);
          }

        }
      ?>
</body>
</html>
