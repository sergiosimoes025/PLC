# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl ReconhecedorTexto.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use ReconhecedorTexto;
use Test::More tests => 18;
BEGIN { use_ok('ReconhecedorTexto') };

#Para correr os testes colocar "../" em $path3 !

my $path3 = "";
my $path1 = $path3."dic/pt-PT.dic";
my $path2 = $path3."dic/entidades.txt";
my $rec =  ReconhecedorTexto->new($path2,$path1);

isa_ok($rec, 'ReconhecedorTexto');
is(adicionar_palavra_ao_dic($rec,"Benfica","futebol","equipa"), "TRUE", "inserir palavra benfica na classe futebol");
is(trim(" teste "),"teste","Testar o trim");
is(stripchars("teste2 ??!!.","?!!,."),"teste2 ","testar o StripChars");


is($rec->read_texto($path3."ficheiros_de_teste/dasdas.txt"),"FALSE","Ler ficheiro inexistente");
is($rec->read_texto($path3."ficheiros_de_teste/teste.txt"),"TRUE","Ler ficheiro teste.txt");
is($rec->{palavras},"536","Contar numero de palavras");
is($rec->adicionar_entidade_ao_dic("João Sousa","Desportista","Tenis"),"TRUE","inserir entidade nova");

$rec =  ReconhecedorTexto->new($path2,$path1);

is($rec->read_texto($path3."ficheiros_de_teste/testeus.txt"),"TRUE","Ler de novo outro ficheiro");
is($rec->verifica_se_palavra_pert_a_classe("andar","Verbo"),"TRUE","Verificar se andar é um verbo");
is($rec->verifica_se_palavra_pert_a_classe("correr","Nome Próprio"),"FALSE","Verificar se andar é um Nome Próprio");
is($rec->verifica_se_palavra_pert_a_classe("é","Artigo"),"TRUE","Verificar se 'é' é um artigo");
is($rec->verifica_se_palavra_pert_a_classe("a","Artigo"),"TRUE","Verificar se 'a' é um artigo");
is($rec->devolve_classe_de_palavra("é"),"Artigo","Devolver a classe da palavra é");
is($rec->devolve_classe_de_palavra("dasdsad"),"NR","Verificar que a palavra dasdsad não existe");
ok($rec->save("teste") eq "SUCESS", "Guardar objecto em memória");
ok($rec->load("teste") eq "SUCESS", "Carregar objecto em memória");

my @res = $rec-> get_entides_by_regex();

#print @res;
#########################

# Insert your test code below, the Test::More module is use(ed here so read
# its man page  for help writing this test script.

