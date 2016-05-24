/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex1;

@members {
          boolean inicia = false;
}

lista
      : 'LISTA' elems '.'
      ;

elems returns [int soma]
        : elem        {$elems.soma = $elem.val;}
        (',' elem   {$elems.soma += $elem.val;})*
      ;
elem returns [int val]
     : PAL  {$elem.val=0;}
     | NUM {if(inicia) $elem.val= $NUM; else  $elem.val=0;} 
     |'inicia' {inicia= !inicia; $elem.val=0;}  
     ;

PAL: [a-zA-Z][a-zA-Z_0-9]*;

NUM: ('+'|'-')?'0'..'9'+;

Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;