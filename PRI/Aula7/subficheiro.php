<?php 
    if($_FILES["ficheiro"]["error"] > 0){
        echo "<p> Error: " . $_FILES["ficheiro"]["error"] . "</p>"; 
    }
    else{
        if(file_exists("uploads/" . $_FILES["ficheiro"]["name"])){
            echo $_FILES["ficheiro"]["name"] . " j‡ existe. ";
        }
        else{
            move_uploaded_file($_FILES["ficheiro"]["tmp_name"],"uploads/" . $_FILES["ficheiro"]["name"]);
            echo "<p>Guardado em: uploads/" . $_FILES["ficheiro"]["name"] . "</p>";
        }
    }
    

?>