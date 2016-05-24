<?php

 
/**
 * A class file to connect to database
 */
class DB_CONNECT extends PDO{
 
    // construtor
    function __construct() {
        // connecting to database
        parent::__construct('mysql:host=localhost;dbname=PLC_PRI_TP_BD','root', 'root',array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
    }
 
   /**
     * Function to close db connection
     */
    function close() {
        // closing db connection
        mysql_close();
    }
 
}
 
?>