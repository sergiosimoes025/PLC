/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex2;

@members {
          int nVars; int val = 0; String var;
}

program
@init {}
@after {System.out.println("Numero de variaveis: " + nVars);}    
      : 'PROGRAM' vars 'BODY' atrs 'END'
      ;
vars : var      {nVars=1;}
     (',' var   {nVars++;} )* 
      ;
var : PAL
     ;
atrs : atr 
      (';' atr)*
     ;

atr : PAL '=' NUM   {var=$PAL.text; val=$NUM.int;}
    (OPR NUM          {if($OPR.text.equals("+")){val+=$NUM.int;} else {val-=$NUM.int;}}  )*
    {System.out.println("Variavel " + var + (" tem valor de ")+ val );}
    ;



PAL: [a-zA-Z][a-zA-Z_0-9]*;

NUM: '0'..'9'+;

OPR: ('+'|'-');

Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;