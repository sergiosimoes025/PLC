# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl My-PrefixTree.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use Data::Dumper;
use My::PrefixTree;
use Test::More tests => 14;
BEGIN { use_ok('My::PrefixTree') };


my $dicionario = My::PrefixTree->new();
isa_ok($dicionario, 'My::PrefixTree');


my @words = qw (aba anao abel abobora abola);

$dicionario->add_word($_) for (@words);

is($dicionario->get_words_with_prefix('a'),@words,"get_words_with_prefix_a");
isnt($dicionario->get_words_with_prefix('ab'),qw(aba abel abobora),"get_words_with_prefix_ab");


is($dicionario->word_exists('abel'),"Verdadeiro", "existe_palavra_abel");
is($dicionario->word_exists('anao'),"Verdadeiro", "existe_palavra_ano");
is($dicionario->prefix_exists('ab'),"Verdadeiro","existe_prefixo_ab");
is($dicionario->prefix_exists('z'),"Falso","existe_prefixo_z");
is($dicionario->word_exists('joz'),"Falso","existe j");

is($dicionario->rem_word('abel'),"Sucesso","remover_palavra_aba");
is($dicionario->rem_word('abel'),"Palavra Inexistente","remover_palavra_aba");

is($dicionario->prefix_exists('ab'),"Verdadeiro","existe_prefixo_ab");


#testes relacionados com as operações guardar e carregar ficheiro
is($dicionario->save("teste"),"Ficheiro guardado",'guardar');
is($dicionario->load("teste"),"Ficheiro carregado",'load');



#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

