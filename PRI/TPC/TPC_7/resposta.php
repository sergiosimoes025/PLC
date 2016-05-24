<?php

$logs = simplexml_load_file("logs.xml");

print 

"<html>
    <head>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
    <!-- Latest compiled and minified CSS -->
		<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css\">
		<!-- Latest compiled and minified CSS -->
		<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css\">


    <style>
      #footer{

    position:


    }

    </style>
		
	<title>Listagem de Logs</title>
    </head>
    <body>
    <center><div style=\"font-family:Arial;font-size:60px;background-image:url(http://images.telcoblue.com.au/mis/header-background.jpg)\"> LOGS </div></center>
      <table width=\"400\" id=\"logs\" border=\"2\" align=\"center\" style=\"margin-top:110px;\">
        <tr>
          <th>Data</th><th>Hora</th><th>Titulo</th><th>Autores</th>
        </tr>
";


foreach ($logs as $log => $l) {
	print "<tr>
               <td>".(string)$l->data."</td>".
               "<td>". (string)$l->hora."</td>".
               "<td>".(string)$l->titulo."</td>".
               "<td>".(string)$l->autores->autor."</td>".
             "</tr>
            ";
}

print "</table>";
print 
	
	"
	<div id=\"footer\"> cenas fixes </div> 
	</body>
</html>";
?>