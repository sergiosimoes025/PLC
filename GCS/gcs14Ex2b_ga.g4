/*
 * GCP 2014/15
 * Gramatica de uma linguagem de programação muito simples
 * GT para contar identificadores e calcular expressões
 */

grammar gcs14Ex2b_ga;

@members {
          
}

prog  : 'PROGRAM' decls[new ...()] stats[$decls.tabId]  'END'
      ;
decls : declTipos declVars
      ;
declTipos : 'TYPE' idTipo (',' idTipo)*
          ;
declVars : 'VAR' dcl  (';' dcl)*    
      ;
dcl   : idTipo lstIds
      ;
idTipo : ID
       ;
lstIds : idVar (',' idVar)*
       ;
idVar  : ID
       ;

stats: 'BODY' stat (';' stat)*
      ;
stat  : atr
      | cond
      | ciclo
      | invoc
      ;

atr   : ID '=' exp 
        {  }     
      ;
exp   : operand { } 
      (OPER operand {})*
      ;
operand: NUM    { }
      ;

ID  : (('a'..'z')|('A'..'Z'))+ ;
NUM : [0-9]+;
OPER: '+' | '-' ;

WS  : ('\r'?'\n' | ' ' | '\t')+ -> skip;
