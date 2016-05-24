/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar familia;


@header{
import java.io.PrintWriter;
import java.io.File;
import java.lang.String;
}

@members{
boolean existe_data_falecimento = false;
int aux;
int chave = 0;
PrintWriter file;

}

ficheiro @init{
               try{
         file = new PrintWriter("/Users/Perez_25/Desktop/final.sql");
                 }
               
       catch(Exception e){
       e.printStackTrace();                  
       }      
               }
    
@after{file.close();} : familias{
               
                   System.out.println("Valores FINAIS");
                   System.out.println("Numero de familias : " +$familias.num_familias);
                   System.out.println("Numero total de filhos: " +$familias.num_filhos);
                   System.out.println("Média de filhos por familia: "+$familias.num_filhos/$familias.num_familias);
                   
                   }                  ;

familias returns [int num_familias,int num_filhos]: familia[0,0] '.'{
            $familias.num_familias = 1;
            $familias.num_filhos = $familia.numFilhos;
            System.out.println("Familia "+$familia.codFamilia+" correctamente formalizada ? "+$familia.res);
            System.out.println("Numero de filhos " +$familia.numFilhos);
            System.out.println("-----------------------------------------");
            file.println($familia.final_query);
           }
      
          
         (familia[$familias.num_familias,$familias.num_filhos]{
                                                               
            System.out.println("Familia "+$familia.codFamilia+" correctamente formalizada ? "+$familia.res);
            System.out.println("Numero de filhos "+$familia.numFilhos);
            $familias.num_familias++;   
            $familias.num_filhos+=$familia.numFilhos;
            System.out.println("-----------------------------------------");
            file.println($familia.final_query);  
             }'.')*
        ;          

familia[int num_familias,int num_filhos] returns[boolean res,String codFamilia,int numFilhos,String final_query] : 'FAMILIA' COD_FAMILIA ':' 
                 pai mae evento[$pai.ano_nascimento,$mae.ano_nascimento]* filhos[$pai.apelidoFilhos,$mae.ano_nascimento]{
                                        
                      $familia.codFamilia = $COD_FAMILIA.text;
                      $familia.res = $mae.res && $pai.res;
                      $familia.numFilhos = $filhos.num_filhos_final;
                      $familia.final_query = "INSERT INTO PESSOAS(key,nome_proprio,apelido,genero) values("+chave+","+$pai.nomePai+","+$pai.apelidoFilhos+",M);";
                      $familia.final_query+="\n"+"INSERT INTO PESSOAS(key,nome_proprio,apelido,genero) values("+chave+","+$mae.nomeMae+","+$mae.apelidoMae+",F);";
                      $familia.final_query+="\n"+$filhos.finalQuery; 
                       chave++;
                 };  
                                               
pai returns [String apelidoFilhos,int ano_nascimento,String nomePai,boolean res]: 'PAI' '"' nome '"' '"' apelido '"' data_nascimento data_falecimento?{
  System.out.println("------- PAI --------");
  $pai.res = true;
  System.out.print($nome.nome_final+" ");
  System.out.println($apelido.apelido_final);
  System.out.println("Data de nascimento: "+ $data_nascimento.ano + "-" + $data_nascimento.mes + "-" + $data_nascimento.dia);   
  if(existe_data_falecimento == true){
  System.out.println("Data de falecimento: "+ $data_falecimento.ano + "-" + $data_falecimento.mes + "-" + $data_falecimento.dia);   
  existe_data_falecimento = false;
  aux = $data_falecimento.ano-$data_nascimento.ano;
  System.out.println("Idade quando faleceu: "+aux);
  if(aux <=0) $pai.res = false; 
  }
  $pai.apelidoFilhos = $apelido.apelido_final;
  $pai.ano_nascimento = $data_nascimento.ano;
  $pai.nomePai = $nome.nome_final;
  
};


mae returns[int ano_nascimento,String nomeMae,String apelidoMae,boolean res]:'MAE' '"' nome '"' '"' apelido '"' data_nascimento data_falecimento?{
    System.out.println("------- MÃE --------");
    $mae.res = true;
    System.out.print($nome.nome_final+" ");
    System.out.println($apelido.apelido_final);
    System.out.println("Data de nascimento: "+ $data_nascimento.ano + "-" + $data_nascimento.mes + "-" + $data_nascimento.dia);   
    if(existe_data_falecimento == true) {
    System.out.println("Data de falecimento: "+ $data_falecimento.ano + "-" + $data_falecimento.mes + "-" + $data_falecimento.dia);   
    existe_data_falecimento = false;
    aux = $data_falecimento.ano-$data_nascimento.ano;
    System.out.println("Idade quando faleceu: "+aux);
    if(aux <=0) $mae.res = false; 
    }
    $mae.nomeMae = $nome.nome_final;
    $mae.apelidoMae = $apelido.apelido_final;
    $mae.ano_nascimento = $data_nascimento.ano;
 };

evento[int ano_pai,int ano_Mae] : 'CASAMENTO' '"' local '"' data_nascimento data_falecimento?{
       System.out.println("------- CASAMENTO --------");
       System.out.println("Casaram-se em : "+ $data_nascimento.ano + "-" + $data_nascimento.mes + "-" + $data_nascimento.dia);   
       aux = $data_nascimento.ano - ano_pai;
       System.out.println("A idade do pai era de: "+aux);
       aux = $data_nascimento.ano - ano_Mae;
       System.out.println("A idade da mãe era de: "+aux);
                                                                     
       };

filhos[String apelidoFilhos,int nascimento_mae] returns [int num_filhos_final,String finalQuery] : filho[0,""]{
      $filhos.num_filhos_final = 1;
     System.out.println("------- FILHOS --------");
     System.out.print($filho.nomeF+" ");
     System.out.println($filhos.apelidoFilhos);
     aux = $filho.anoN - $filhos.nascimento_mae;
     System.out.println("Nasceu na data : "+$filho.anoN+"-"+$filho.mesN+"-"+$filho.diaN);
     $filhos.finalQuery = "INSERT INTO PESSOAS(key,nome_proprio,apelido,sexo) values("+chave+","+$filho.nomeF+","+$filhos.apelidoFilhos+","+$filho.sexo_filho+");"; 
      }
     (',' filho[$filhos.num_filhos_final,$filhos.finalQuery]{
              System.out.print($filho.nomeF+" ");
              System.out.println($filhos.apelidoFilhos);
              System.out.println("Nasceu na data : "+$filho.anoN+"-"+$filho.mesN+"-"+$filho.diaN);
              $filhos.num_filhos_final++;
              if(($filho.anoN-$filhos.nascimento_mae)>aux) aux = $filho.anoN-$filhos.nascimento_mae;
              $filhos.finalQuery+= "\n"+"INSERT INTO PESSOAS(key,nome_proprio,apelido,sexo) values("+chave+","+$filho.nomeF+","+$filhos.apelidoFilhos+","+$filho.sexo_filho+");"; 
    
         })*;
          
   filho[int num_filhos,String query] returns[String nomeF,String sexo_filho,int anoN,int mesN,int diaN,int anoF,int mesF,int diaF]: 'FILHO' '"' nome '"' sexo data_nascimento data_falecimento?{
                    $filho.nomeF = $nome.nome_final;
                    $filho.anoN = $data_nascimento.ano;
                    $filho.mesN = $data_nascimento.mes;
                    $filho.diaN = $data_nascimento.dia;
                   
                   if(existe_data_falecimento == true) {
                    $filho.anoF = $data_falecimento.mes;
                    $filho.mesF = $data_falecimento.ano;
                    $filho.diaF = $data_falecimento.dia;
                    existe_data_falecimento = false;
                  }
                  $filho.sexo_filho = $sexo.sexo_final; 
                    
                    }; 




data_nascimento returns[int ano,int mes,int dia] : 
 ANO{$data_nascimento.ano = $ANO.int;} '-' 
 MES{ $data_nascimento.mes = $MES.int;} '-' 
 DIA{$data_nascimento.dia = $DIA.int;};


data_falecimento returns[int ano,int mes,int dia,boolean existe_final] : 
 ANO{ existe_data_falecimento = true; $data_falecimento.ano = $ANO.int;} '-' 
 MES{ $data_falecimento.mes = $MES.int;} '-' 
 DIA{$data_falecimento.dia = $DIA.int;};


nome returns[String nome_final]: PAL{
                       $nome.nome_final = $PAL.text;
                       
                       }
(PAL{
$nome.nome_final+=" "+$PAL.text;

})*;

apelido returns[String apelido_final]: PAL{
                       $apelido.apelido_final = $PAL.text;
                       
                       }
(PAL{
$apelido.apelido_final+=" "+$PAL.text;

})*;

local : LOC;
sexo returns[String sexo_final] : SEXO{$sexo_final = $SEXO.text;};

SEXO: ('M'|'F');
ANO:[1-2][0-9][0-9][0-9];
MES:[0-1]?[0-9];
DIA:(([0-9])||([0-3]?[0-9])||([0-3][0-9]?));
COD_FAMILIA: [A-Z]*[0-9]+;
PAL: [a-zA-Z][a-zA-Z]*;
LOC: [A-Za-z] [a-zA-Z/-]*;
NUM: ('0'..'9');
Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;     