# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl ReconhecedorTexto.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use ReconhecedorTexto;
use Test::More tests => 5;
BEGIN { use_ok('ReconhecedorTexto') };

my $rec =  ReconhecedorTexto->new();
isa_ok($rec, 'ReconhecedorTexto');
is(adicionar_palavra_ao_dic($rec,"Benfica","futebol","equipa"), "TRUE", "inserir palavra benfica na classe futebol");
is(trim(" teste "),"teste","Testar o trim");
is(stripchars("teste2 ??!!.","?!!,."),"teste2 ","testar o StripChars");


#########################

# Insert your test code below, the Test::More module is use(ed here so read
# its man page  for help writing this test script.

