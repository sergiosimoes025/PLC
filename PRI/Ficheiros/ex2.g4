/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex2;


prog: 'PROGRAM' elems bod
    ;

elems: VAR 
        (',' elems)*
     ;
bod: 'BODY' exp 'END'
    ;

exp: VAR '=' exp1 
     (';' VAR '=' exp1)*
    ;


exp1: NUM 
        (SIG NUM)* 
    ;


VAR: ('a'..'z') ;
NUM: [0-9]+ ;
SIG: ('+'|'-') ;
WS: ('\r'?'\n' | ' ' | '\t')+ -> skip;