<?php
	class myDB extends PDO{
		public function __construct(){
			parent::__construct('mysql:host=localhost;dbname=ProjectRecord', 'root', 'root');
		}
	}
?>