/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar gic_arq;

gic_arq: '::ENTIDADES::' entidades '::PROCESSOS::' processos '::ACOMPANHANTES::' acompanhantes '.END.';

entidades : entidade (entidade)*;

processos: processo (processo)*;

acompanhantes: acompanhante (acompanhante)*;

entidade : bi? ';' nome ';' freguesia ';' concelho ';' data ';' nome_pai ';' nome_mae ';' (conjugue)? '#';
bi :NUM+;
nome:PAL+;
freguesia:PAL+;
concelho:PAL+;
nome_pai:PAL+;
nome_mae:PAL+;
conjugue:PAL+;


processo:id_emigrante? ';' id_processo? ';' destino ';' expediente ';' idade ';' estado_civil ';' data_saida ';' habilitacoes ';' trabalho_futuro '#';
id_emigrante:NUM+;
idade:NUM+;
estado_civil:PAL;

id_processo : numCM ';' numJE? ';' ano_processo;

numCM:NUM_PROCESSO;
numJE:NUM_PROCESSO;
ano_processo:NUM+;

destino : pais? ';' localidade?;

pais:PAL+;
localidade:PAL+;

expediente : data? ';'  oficio? ';' passaporte?;

oficio:NUM;
passaporte:NUM_PROCESSO+;
data:DATA;
data_saida:PAL+;

habilitacoes: profissao? ';' habLiterarias ';' local_trabalho?;


trabalho_futuro: local? ';' profissao?;

local:PAL+;
profissao:PAL+;
habLiterarias:PAL+;
local_trabalho:PAL+;


acompanhante:  bi? ';' numCM? ';' nome_acompanhante ';' data? ';' relacao?;

relacao:PAL;
nome_acompanhante:PAL;


NUM_PROCESSO:[0-9]+'/'[0-9]+('-'[A-Z0-9]+)?;
NUM: '0'..'9'+;
DATA:[0-9]+('/'|'.')[0-9]+('/'|'.')[0-9]+;
Sep:  ('\r'? '\n' | ' ' |'\t')+ -> skip;
PAL: [A-ZÓÂÁÍa-z\,\"\(\)\`\?\.\'\-\&0-9][\.\(\)&\,A-Za-zí\'\"\è\?\-áìéçóãúêõâÓÂÁ\ª\º]*;