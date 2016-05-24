/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar cancioneiro;

@header{
import java.io.PrintWriter;
import java.io.File;
import java.lang.String;
}

@members{
PrintWriter file;

}

ficheiro @init{
      try{
        file = new PrintWriter("/Users/Perez_25/Desktop/final.tex");
        file.println("\\documentclass[a4paper,12pt,portuges,openright,openbib]{report}");
        file.println("\\RequirePackage[a4paper,top=2cm,left=2.5cm,right=2.5cm,bottom=1.5cm,nohead,nofoot]{geometry}");
        file.println("\\usepackage[portuges]{babel}");
        file.println("\\usepackage[utf8x]{inputenc}");
        file.println("\\begin{document}");
        file.println("\\title{tpc}");
        file.println("\\author{Sérgio Manuel Pereira Simões}");
        file.println("\\date{19-10-2014}");
        file.println("\\maketitle");
        file.println(""); 
        file.println("\\tableofcontents");
        file.println(""); 
        file.println("%--------------------------------------------------------------------------");
        
        
        }
      
      catch(Exception e){
       e.printStackTrace();                  
       }          
}
    
 @after{
file.println("\\end{document}");
file.close(); 
}
:musicas;
    
musicas: 
        musica{
               try{
                    file.println("\\end{verbatim}");
                    file.println("");
                   }
                     catch(Exception e){
                       e.printStackTrace();                 
                     }
                                                                          
                }
          musica*{
                  try{
                       file.println("\\end{verbatim}");
                       file.println("");
                       
                        
                      }
                     catch(Exception e){
                        e.printStackTrace();                 
                     }
                  
                  };
          
          
musica @init{
             file.println("\\newpage");
             
             
             }
    : 'title:' titulo? 'singer:' singer? 'author:' author? 'from:' from? verso {
    file.println("");       
    file.println("\\begin{verbatim}");
    file.println($verso.pal); 
        }
         
       (verso{
        if($verso.teste) {
         file.println("");                 
                          
         }          
              
        file.println($verso.pal);               
        })* 
 
 ;


verso returns [String pal,boolean teste]:  PAL{
        
        
        $verso.pal = $PAL.text; 
        $verso.pal.trim();
        
        if($PAL.text.charAt(0)>65 && $PAL.text.charAt(0)< 90){
          $verso.teste = true;                             
         }                     
       }    
      ;

titulo : PAL 
         {
         file.println("\\section{"+$PAL.text+"}");
        };
singer : PAL
        
         {   
        file.println("Musico :\\textbf{"+$PAL.text+"}\\\\");   
     };     

author : PAL{
         file.println("Cantor :\\emph{"+$PAL.text+"}\\\\ ");     
};
from : PAL{
          file.println("De :\\textbf{"+$PAL.text+"}\\\\");  
   };

PAL: [A-Za-zÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂à ][ a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð,.'-]*;
NUM: ('+'|'-')?'0'..'9'+;
Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;