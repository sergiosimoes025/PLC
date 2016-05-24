# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl ReconhecedorSpam.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';
use strict;
use warnings;
use Data::Dumper;
use ReconhecedorSpam;
use Test::More tests => 1;

BEGIN { use_ok('ReconhecedorSpam') };
my $ob = ReconhecedorSpam->new();
$ob->load_ham_files("../corpus/ham");
$ob->load_spam_files("../corpus/spam");
#print $ob->get_num_of_occ_of_word("choice","spam")."\n";
#print $ob->verifica_se_existe_pal_in_spam("from")."\n";
print $ob->classificador_naive_bayes("Hello i am joson from England. What does dasd dasdlçk das")."\n";
print $ob->calcula_prob_de_pal_pertencer_a_spam("from");
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

