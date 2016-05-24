/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar arquivo_requerimento_passaportes;

@header{
import java.io.PrintWriter;
import java.io.File;
import java.lang.String;
}

@members{
PrintWriter file;
}

arq @init{
     try{
         file = new PrintWriter("/Users/Perez_25/Desktop/insert_bd.sql");
           }
               
       catch(Exception e){
       e.printStackTrace();                  
       }      
               }
    
@after{file.close();}

: '::ENTIDADES::' entidades '::PROCESSOS::' processos '::ACOMPANHANTES::' acompanhantes '.END.';



entidades : entidade{
              if($entidade.query != null)   file.println($entidade.query);
                
                
                } (entidade{
                if($entidade.query != null)   file.println($entidade.query);                
                            
       })*;


processos
    
   : processo
      {
       
       if($processo.query!=null) file.println($processo.query);
       if($processo.query2!=null) file.println($processo.query2);
       if($processo.query3!=null) file.println($processo.query3);
       if($processo.query4!=null) file.println($processo.query4);
       } 
      
      (processo{
                if($processo.query!=null)    file.println($processo.query);
                if($processo.query2!=null)   file.println($processo.query2);
                if($processo.query3!=null) file.println($processo.query3);
                if($processo.query4!=null) file.println($processo.query4);
                })*;



acompanhantes: acompanhante{
                 if($acompanhante.query!=null)    file.println($acompanhante.query);
                }
               
               (acompanhante
                {
                  if($acompanhante.query!=null)    file.println($acompanhante.query);
                    })*;



//____________________________________ ENTIDADE _______________________________________________\\

entidade returns[String query]: bi? ';' nome ';' freguesia ';' concelho ';' data ';' nome_pai ';' nome_mae ';' (conjugue)? '#'{
       
        if($conjugue.text == null && $bi.text != null){
             $entidade.query = "INSERT INTO Entidade(bi,nome,freguesia,local_nascimento,data,nome_pai,nome_mae,conjugue,estado_civil) VALUES("+$bi.val+",'"+$nome.val+"','"+$freguesia.val+"','"+$concelho.val+"','"+$data.val+"','"+$nome_pai.val+"','"+$nome_mae.val+"',null,'solteiro');";                                                                                             
            }  
                                                                                                                        
          else  if($bi.text != null){
             $entidade.query = "INSERT INTO Entidade(bi,nome,freguesia,local_nascimento,data,nome_pai,nome_mae,conjugue,estado_civil) VALUES("+$bi.val+",'"+$nome.val+"','"+$freguesia.val+"','"+$concelho.val+"','"+$data.val+"','"+$nome_pai.val+"','"+$nome_mae.val+"','"+$conjugue.val+"','casado');";                                                                                             
             }                                                                                       
};


bi returns[Integer val]:NUM+{
{       
   $bi.val = $NUM.int;    
}
   
};

nome returns [String val]:PAL{
       $nome.val = "";
       $nome.val += $PAL.text+" ";                        
        }
    (PAL{
        $nome.val+=$PAL.text+" ";    
       })*           


;
freguesia returns[String val]
    :PAL{
         $freguesia.val = $PAL.text+" ";
    }
        (PAL{
             $freguesia.val += $PAL.text+" ";
             })*
;

concelho returns[String val]
    :PAL{
         $concelho.val = $PAL.text+" ";
    }
        (PAL{
             $concelho.val += $PAL.text+" ";
             })*
    ;


data returns[String val]:
        DATA{
        $data.val = $DATA.text;
        $data.val = $data.val.replace('.','-');
        };

nome_pai returns[String val]
    :PAL{
             $nome_pai.val = $PAL.text+" ";
        }
         (PAL{
              $nome_pai.val += $PAL.text+" "; 
     })*
;
nome_mae
          returns[String val]
        :
        PAL{
            $nome_mae.val = $PAL.text+" ";
        }
        (PAL{
             $nome_mae.val +=$PAL.text+" ";
             })*;
        
conjugue returns[String val]
           
            :PAL{
          $conjugue.val = $PAL.text;       
            }
            (PAL{
            $conjugue.val+=$PAL.text;     
             })*; 
 
 
 





//____________________________________ PROCESSO _______________________________________________\\

processo returns[String query,String query2,String query3,String query4,String query5]: id_emigrante ';' id_processo ';' destino ';' expediente ';' idade ';' estado_civil ';' data_saida ';' habilitacoes ';' trabalho_futuro '#'{
       
       if($id_emigrante.text!= null && $id_processo.numJE_final!=null && $id_processo.numCM_final != null && $expediente.final_data!=null){
         $processo.query =  "INSERT INTO Processo (num_processo,ano,camara,data_envio,num_passaporte) VALUES ('"+$id_processo.numCM_final+"',"+$id_processo.ano_final+",'"+$habilitacoes.local_final+"','"+$expediente.final_data+"','"+$expediente.passaporte_final+"');"; 
         $processo.query2 = "INSERT INTO Processo_Entidade(Entidade_bi,Processo_num_processo) VALUES ("+$id_emigrante.val+",'"+$id_processo.numCM_final+"');";
         $processo.query3 = "INSERT INTO Destino_Entidade(pais,cidade,data_prevista_saida,profissao_futura,local,Entidade_bi) VALUES ('"+$destino.final_pais+"','"+$destino.final_localidade+"','"+$data_saida.val+"','"+$trabalho_futuro.profissao_futura_final+"','"+$trabalho_futuro.local_futuro_final+"',"+$id_emigrante.val+");";
         $processo.query4 = "INSERT INTO Habilitacoes_entidade(profissao,habilitacoes,local_trabalho,Entidade_bi) VALUES ('"+$habilitacoes.profissao_final+"','"+$habilitacoes.hab_final+"','"+$habilitacoes.local_final+"',"+$id_emigrante.val+");";
       }                                                                                                       
};


id_emigrante returns[int val]: NUM+{
$id_emigrante.val = $NUM.int;                                        
};


idade returns[int val]: NUM+{
            $idade.val = $NUM.int;                 

    };
estado_civil returns [String val]:PAL{
             $estado_civil.val = $PAL.text;                      
              };

id_processo returns[String numCM_final,String numJE_final,int ano_final] : numCM ';' numJE? ';' ano_processo{
                       $id_processo.numCM_final = $numCM.val;
                       if($numJE.text != null) {
                      $id_processo.numJE_final = $numJE.val;                         
                         }
                       
                      $id_processo.ano_final = $ano_processo.val;
                     };

numCM returns [String val] : NUM_PROCESSO{
                    $numCM.val = $NUM_PROCESSO.text;                        

                    };


numJE returns [String val] : NUM_PROCESSO{
                    $numJE.val = $NUM_PROCESSO.text;                        
    
                };
ano_processo returns [int val]: NUM+{
               $ano_processo.val = $NUM.int;
    };


destino returns[String final_pais,String final_localidade]: pais? ';' localidade?{
                       if($pais.text !=null)  {$destino.final_pais = $pais.val; }
                       if($localidade.text !=null)  {$destino.final_localidade = $localidade.val;}    
                    };


pais returns[String val] : PAL{
         $pais.val = $PAL.text+" ";                      

}(PAL{
       $pais.val += $PAL.text+" ";
    
                })*;

localidade returns[String val]: PAL{
                $localidade.val = $PAL.text+" ";
                
                }(PAL{
              $localidade.val+=$PAL.text+" ";
                      
                      
                      })*;

expediente returns [String final_data,String passaporte_final]: data? ';'  oficio? ';' passaporte?{
                            if($data.text != null) $expediente.final_data = $data.val;
                            if($passaporte.text !=null) $expediente.passaporte_final = $passaporte.val;
                    };

oficio:NUM;

passaporte returns[String val]:NUM_PROCESSO{
                    $passaporte.val = $NUM_PROCESSO.text;    
        };


data_saida returns[String val]:PAL{
                  $data_saida.val = $PAL.text+" ";                  

            } (PAL{
                  $data_saida.val += $PAL.text+" "; 
            })*;


habilitacoes returns[String profissao_final,String hab_final,String local_final]
        : profissao? ';' habLiterarias ';' local_trabalho?{
                   if($profissao.text != null) $habilitacoes.profissao_final = $profissao.val;                                       
                   if($habLiterarias.text != null) $habilitacoes.hab_final = $habLiterarias.val;                                         
                   if($local_trabalho.text != null) $habilitacoes.local_final = $local_trabalho.val;                                      
            };


profissao returns[String val]:PAL{
                $profissao.val = $PAL.text+" ";
        }
                              (PAL{
              $profissao.val += $PAL.text+" "; 
              
     })*;

habLiterarias returns[String val]:PAL{
               $habLiterarias.val = $PAL.text+" ";                       

            }(PAL{
                  $habLiterarias.val += $PAL.text+" ";

            })*;


local_trabalho returns[String val]:PAL{
               $local_trabalho.val = $PAL.text+" ";                       
               $local_trabalho.val = $local_trabalho.val.replace('\'',' ');
               $local_trabalho.val = $local_trabalho.val.replace('"',' ');
               $local_trabalho.val = $local_trabalho.val.replace('`',' ');
              
            }(PAL{
                    $local_trabalho.val += $PAL.text+" ";
                    $local_trabalho.val = $local_trabalho.val.replace('\'',' ');
                    $local_trabalho.val = $local_trabalho.val.replace('"',' ');
                    $local_trabalho.val = $local_trabalho.val.replace('`',' ');
            })*;


trabalho_futuro returns[String local_futuro_final,String profissao_futura_final]: local? ';' profissao?{
         if($local.text != null) $trabalho_futuro.local_futuro_final = $local.val;
         if($profissao.text != null) $trabalho_futuro.profissao_futura_final = $profissao.val;
         };

local returns[String val]:PAL{
           $local.val = $PAL.text+" ";
           $local.val = $local.val.replace('\'',' ');
           $local.val = $local.val.replace('"',' ');
           $local.val = $local.val.replace('`',' ');

        }(PAL{
           $local.val += $PAL.text+" ";
            $local.val = $local.val.replace('\'',' ');
           $local.val = $local.val.replace('"',' ');
           $local.val = $local.val.replace('`',' ');
              
    })*;



//____________________________________ ACOMPANHANTE _______________________________________________\\

acompanhante returns[String query]: bi? ';' numCM? ';' nome_acompanhante ';' data? ';' relacao? '#'{
                    if($bi.text!=null && $numCM.text!=null && $nome_acompanhante.nome_final.equals("Nenhum ") == false){
                        if($data.text != null && $relacao.text!=null){ 
                          $acompanhante.query="INSERT INTO Acompanhante(nome_acompanhante,data_nascimento,relacao,Entidade_bi,Processo_num_processo) VALUES ('"+$nome_acompanhante.nome_final+"','"+$data.val+"','"+$relacao.relacao_final+"',"+$bi.val+",'"+$numCM.val+"');";                                                                                    
                         }
                  }                
                    else if($bi.text!=null && $numCM.text!=null && $nome_acompanhante.nome_final.equals("Nenhum ") == true){
                        $acompanhante.query="INSERT INTO Acompanhante(nome_acompanhante,data_nascimento,relacao,Entidade_bi,Processo_num_processo) VALUES ('"+$nome_acompanhante.nome_final+"',null,null,"+$bi.val+",'"+$numCM.val+"');";                                                                                    
                        }  
            };



nome_acompanhante returns[String nome_final]: PAL{
               $nome_acompanhante.nome_final = $PAL.text+" ";    
          }(PAL{
              $nome_acompanhante.nome_final += $PAL.text+" ";    
            })*;


relacao returns[String relacao_final]:PAL{
            $relacao.relacao_final = $PAL.text;
            };



NUM_PROCESSO:[0-9]+'/'[0-9]+('-'[A-Z0-9]+)?;
NUM: '0'..'9'+;
DATA:[0-9]+('/'|'.')[0-9]+('/'|'.')[0-9]+;
Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;
PAL: [A-ZÓÂÁÍa-z\,\"\(\)\`\?\.\'\-\&0-9][\.\(\)&\,A-Za-zí\'\"\è\?\-áìéçóãúêõâÓÂÁ\ª\º]*;