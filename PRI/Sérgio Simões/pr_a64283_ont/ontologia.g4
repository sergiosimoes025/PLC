/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ontologia;


@header{
import java.util.ArrayList;

}

@members {
ArrayList<String> conceitos = new ArrayList<String>();
ArrayList<String> relacoes = new ArrayList<String>();
ArrayList<String> ligacoes = new ArrayList<String>();
int i = 0;
 }

ontologia: conceitos ligacoes relacoes{
                         System.out.println("Lista de conceitos:");                
                            for(i=0;i<conceitos.size();i++){
                             System.out.println(conceitos.get(i));
                            }
                         System.out.println("Lista de Relações:");                
                            for(i=0;i<relacoes.size();i++){
                             System.out.println(relacoes.get(i));
                            }   
                            
                              };

conceitos : 'CONCEITOS' conceito  {
           
            
           conceitos.add($conceito.nome_conceito);
            }  
                (';' conceito{
           conceitos.add($conceito.nome_conceito);
             })*;

conceito returns[String nome_conceito]: 'CONCEITO'  nomeConceito atributos{
            $conceito.nome_conceito = $nomeConceito.conceito_init;                                                   
      };

atributos: 'ATRIBUTOS' atributo  {
            
           }  
        (',' atributo{
                       
          })* '.';


atributo: nomeAtributo '->' valorAtributo;

nomeAtributo: PAL;

valorAtributo:NUM
             |PAL;


ligacoes: 'LIGACOES' ligacao{
              ligacoes.add($ligacao.text);               
                             
             } (',' ligacao{
              ligacoes.add($ligacao.text);              
       })* '.';


ligacao: PAL;

relacoes: 'RELACOES' relacao {
                     String relacao_final = $relacao.conceito1 + " "+$relacao.tipo_relacao+" "+ $relacao.conceito2;        
                     relacoes.add(relacao_final);
                        
            }  
                (',' relacao{
                      relacao_final = $relacao.conceito1 + " "+$relacao.tipo_relacao+" "+ $relacao.conceito2;        
                      relacoes.add(relacao_final); 
                       
                       
                })* '.';


relacao returns[String conceito1,String conceito2,String tipo_relacao]:  nomeConceito{
     if(conceitos.contains($nomeConceito.conceito_init) == false){
          System.out.println("Relação incorrecta ! , conceito --> "+ $nomeConceito.conceito_init + " não existe");                                                 
          }             
          $relacao.conceito1 = $nomeConceito.conceito_init;             
            }  tipoRelacao{
                      if(ligacoes.contains($tipoRelacao.text) == false){
            System.out.println("Tipo de relação : "+$tipoRelacao.text+" não existe");                                                            
         }                                                  
                      $relacao.tipo_relacao = $tipoRelacao.text;               
                      
                      } 
                       nomeConceito{
         if(conceitos.contains($nomeConceito.conceito_init) == false){
          System.out.println("Relação incorrecta ! , conceito --> "+ $nomeConceito.conceito_init + " não existe");                                                 
                }                                                              
         $relacao.conceito2 = $nomeConceito.conceito_init; 
 
 } 
       ;

tipoRelacao: PAL+;   
           


nomeConceito returns[String conceito_init]: PAL '.'{
       $nomeConceito.conceito_init = $PAL.text;            
      };          

PAL: [a-zA-Z][a-zA-Z_0-9]*;
NUM: ('+'|'-')?'0'..'9'+;
Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;
