/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ex1;

@members {
          int contador, contaN, soma;
}

lista
@init {contaN = soma = 0;}
@after { System.out.println("Tamanho da lista: " +contador);
      System.out.println("Número de Inteiros: " +contaN);
      System.out.println("Soma da lista: " +soma);
      }    
      : 'LISTA' elems '.'
      ;
elems : elem        {contador=1;}
        (',' elem   {contador++;})*
      ;
elem : PAL
     | NUM {contaN = contaN+1; soma += $NUM.int;}
     ;

PAL: [a-zA-Z][a-zA-Z_0-9]*;

NUM: ('+'|'-')?'0'..'9'+;

Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;