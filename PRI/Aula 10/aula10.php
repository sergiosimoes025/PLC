<?php

$user = "root";
$pass = "root";
try {
    $dbh = new PDO('mysql:host=localhost;dbname=ProjectRecord', $user, $pass);
    echo "<pre>";
    foreach($dbh->query('SELECT * from Student') as $row) {
        print_r($row);
    }
    echo "</pre>";
    $dbh = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "
";
    die();
}