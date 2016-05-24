/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ficha1;


@header{
import java.util.ArrayList;
}

@members {
 ArrayList<Integer> posicoes =  new ArrayList<Integer>(); 
 int iteracao=0;
 }



lista : 'LISTA' elems '.'{
       System.out.println("----|Ficha 1|----");                    
       System.out.println("a)Total de elementos = "+$elems.total);                   
       System.out.println("b) Numero de inteiros = "+$elems.num_inteiros);
       System.out.println("c) Soma de todos os inteiros = "+$elems.soma);
       System.out.println("g) Ordenado crescentemente ? (true | false) :  "+$elems.final_cres);
       System.out.println("h) Posições:");
       for(iteracao=0;iteracao<posicoes.size();iteracao++)
       System.out.print(posicoes.get(iteracao)+" ");
       System.out.println();
       System.out.println("i)Soma de todos os numeros que são antecedidos por, pelo menos, 3 palavras: "+$elems.soma_final_palavras);
       
       
      };

elems  returns [int total,int num_inteiros,int soma,boolean final_cres,int soma_final_palavras] 
      : e1 = elem[false,false,true,0,0,0,0,false]
      {
         
          
          $elems.total=1;
          if($e1.iniciaSoma) {
              $elems.soma = $elem.val;
          } else {
               $elems.soma = 0;
          }
          
          if($e1.iniciaSub) {
              $elems.soma = 0 - $elem.val;
          } else {
               $elems.soma = 0;
          }
          
            if($elem.flag == 1) 
              $elems.num_inteiros++; 
              
           $elem.auxCres = true;
           
           $elems.soma_final_palavras = 0;
      }
      
      (',' e2=elem[$e1.iniciaSoma,$e1.iniciaSub,$e1.auxCres,$elem.anterior,$elems.total,$e1.contaPal,$e1.somaPal,$e1.testaSomaPal]
      
       {
       
        $elems.total++;
        if($e2.iniciaSoma) {                           
            $elems.soma += $e2.val;
        } else {
            $elems.soma += 0;
        }
         
          if($e2.iniciaSub) {                           
            $elems.soma -= $e2.val;
        } else {
            $elems.soma -= 0;
        }
          
         
          if($elem.flag == 1) 
             $elems.num_inteiros++;
             
         $e1.iniciaSoma = $e2.iniciaSoma;
         $e1.iniciaSub = $e2.iniciaSub;
        
         
         $e1.auxCres = $e2.auxCres;
         $e1.anterior = $e2.anterior;
         $elems.final_cres = $e1.auxCres;
         
        
         $e1.somaPal = $e2.somaPal;
         $e1.contaPal = $e2.contaPal;
         $elems.soma_final_palavras = $e1.somaPal;
         $e1.testaSomaPal = $e2.testaSomaPal;
        
      })*;
                                            
                                            
                                            
elem[boolean inicia,boolean inicia2,boolean iniciaCres,int inicia_anterior,int init_ite,int init_contaPal,int init_somaPalaux,boolean init_testaSomaPal] 
    returns [int val,int flag,boolean iniciaSoma,boolean iniciaSub,boolean auxCres,int anterior,int somaPal,int contaPal,boolean testaSomaPal]
    : NUM 
      {
          
          
          if($elem.inicia_anterior > $NUM.int) {
           $elem.auxCres = false;
           posicoes.add($elem.init_ite);
            }
          
          else 
               $elem.auxCres = $elem.iniciaCres;
             
            if($elem.init_testaSomaPal){
                          $elem.somaPal = $NUM.int + $elem.init_somaPalaux;      
                          $elem.contaPal = $elem.init_contaPal;      
                          $elem.testaSomaPal = $elem.init_testaSomaPal;
                          }
           else {
                   $elem.somaPal = $elem.init_somaPalaux;  
                   $elem.contaPal = 0;
                   $elem.testaSomaPal = $elem.init_testaSomaPal;
                           } 
        
          if($elem.init_contaPal >= 3){
               $elem.somaPal = $NUM.int + $elem.init_somaPalaux;
               $elem.contaPal = 0;
               $elem.testaSomaPal = !$elem.init_testaSomaPal;
               
                }
          
          
          
          
          $elem.iniciaSoma = $elem.inicia;
          $elem.anterior = $NUM.int;
          $elem.iniciaSub = $elem.inicia2;
          $elem.val = $NUM.int;
          
          $elem.flag = 1;
          
      } 
    |PAL 
     {
      
      if($elem.contaPal == 3){
                            $elem.contaPal = 0;
                            $elem.testaSomaPal = true;
                            }
      else {
       $elem.contaPal = $elem.init_contaPal + 1;
       $elem.testaSomaPal = false;
       }
      
       $elem.somaPal = $elem.init_somaPalaux;
       $elem.auxCres = $elem.iniciaCres;
       $elem.val=0;
       $elem.flag = 0;
       $elem.iniciaSoma = $elem.inicia;
       $elem.iniciaSub = $elem.inicia2;
      
     }
    |'soma'
     {      
          $elem.contaPal = $elem.init_contaPal + 1;
          $elem.testaSomaPal = $elem.init_testaSomaPal;
          $elem.somaPal = $elem.init_somaPalaux;
          $elem.auxCres = $elem.iniciaCres;  
          $elem.iniciaSoma = !$elem.inicia;
          $elem.iniciaSub = $elem.inicia2;
          $elem.val = 0;
     }
    |'subtrai'
     {
      $elem.contaPal = $elem.init_contaPal + 1;
      $elem.testaSomaPal = $elem.init_testaSomaPal;
      $elem.somaPal = $elem.init_somaPalaux;
      $elem.auxCres = $elem.iniciaCres;
      $elem.iniciaSub = !$elem.inicia2;
      $elem.iniciaSoma = $elem.inicia;
      $elem.val = 0;
      
      }
     
     ;

PAL: [a-zA-Z][a-zA-Z_0-9]*;
NUM: ('+'|'-')?'0'..'9'+;
Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip; 