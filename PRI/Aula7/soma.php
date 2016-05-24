<?php
    $operandos = [];
    $soma = 0;
    
    foreach( $_REQUEST as $key=>$value ){
        array_push($operandos, $value);
        $soma += $value;
            
    }
    
    echo 'Operandos: ',implode(", ",$operandos), '<br/>', 'Soma: ', $soma;
                                          
?>