/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex2;


lista : 'LISTA' elems[false] '.' 
      { System.out.println("Soma da lista: " + $elems.soma); };

elems [boolean inicia] returns [int soma]
      : e1=elem[$elems.inicia, 0, false]  { $elems.soma = $elem.val; }
      (',' e2=elem[$e1.iniciaOut, $e1.seg, $e1.cresceOut]  
      { 
        $elems.soma += $elem.val; 
        $e1.iniciaOut = $e2.iniciaOut; 
        $e1.seg = $e2.seg; 
        $e1.cresceOut = $e2.cresceOut;
      } )* ;

elem [boolean inicia, int ant, boolean cresce] returns [int val, boolean iniciaOut, int seg, boolean cresceOut] 
    : 'inicia'  { $elem.iniciaOut = !$elem.inicia; $elem.val = 0 ; }
    | PAL       { 
                    $elem.cresceOut = $elem.cresce; 
                    $elem.seg = $elem.ant; 
                    $elem.iniciaOut = $elem.inicia ; 
                    $elem.val = 0;
                }
    | NUM       { 
                    $elem.seg = $NUM.int; 
                    if($NUM.int < $elem.ant) $elem.cresceOut = true; 
                    else $elem.cresceOut = false;
                    if ($elem.inicia) $elem.val = $NUM.int; 
                    else $elem.val = 0; 
                    $elem.iniciaOut = inicia ;
                } ;  
    
PAL : (('a'..'z')|('A'..'Z'))+;
NUM : [0-9]+;
WS  : ('\r'?'\n' | ' ' | '\t')+ -> skip;