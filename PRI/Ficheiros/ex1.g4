/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex1;

@members{ // members para declarar variáveis globais
         int contador, contaN,soma;
         }

lista
@init {contaN=soma = 0;} // código que executa antes de conhecer o lado direito
@after{System.out.println("Tamanho da lista: " +contador); // código que executa depois de conhecer o lado direito
      System.out.println("Número de Inteiros: " +contaN);
      System.out.println("Soma da lista: " +soma);
      }
    : 'LISTA' elems '.'
    ;

elems : elem {contador = 1;}
        (',' elem{contador++;})*
      ;

elem : NUM {contaN = contaN+1; soma+=$NUM.int;}  // ou então se  elem: a = NUM { soma+= $a.int;}
     |PAL
     ;

PAL : (('a'..'z')|('A'..'Z'))+; // com números [a-zA-Z][a-zA-Z_0-9]* 
NUM: [0-9]+;
WS: ('\r'?'\n' | ' ' | '\t')+ -> skip;