/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex2;

@members {
          int contador, contaN, soma;
}

program
@init {contaN = soma = 0;}
@after { System.out.println("Numero de variáveis: " +contador);
      System.out.println("Número de Inteiros: " +contaN);
      System.out.println("Soma da lista: " +soma);
      }    
      : 'PROGRAM' vars 'BODY' atrs 'END'
      ;
vars : var
     (',' var  )*
      ;
var : PAL
     ;
atrs : atr 
      (';' atr)*
     ;

atr : var '=' num 
    (opr num)*
    ;

num : NUM
    ; 

opr : OPR
    ;


PAL: [a-zA-Z][a-zA-Z_0-9]*;

NUM: ('+'|'-')?'0'..'9'+;

OPR: ('+'|'-');

Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;