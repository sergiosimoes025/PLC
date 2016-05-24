# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl PrefixTree.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 38;
BEGIN { use_ok('PrefixTree') };
use PrefixTree;

my $dic = PrefixTree->new();

isa_ok($dic, 'PrefixTree');

my %tests = (
	'ab' => [qw{aba abaco abeto abrir aberto abertura}],
	'aba' => [qw{aba abaco}],
	'abe' => [qw{abeto aberto abertura}],
	'aber' => [qw{aberto abertura}],
	'ap' => [qw{aparecer aparece aparecida apurar apurado}],
	'apa' => [qw{aparecer aparece aparecida}],
	'aparec' => [qw{aparecer aparece aparecida}],
	'apu' => [qw{apurar apurado}],
	'apura' => [qw{apurar apurado}],
	'ac' => [],
	'ad' => [qw{adesao aderir}]
);

sub nub {
	my %seen = map {($_, 1)} @_;

	sort keys %seen;
}

my @words = nub map {@{$tests{$_}}} keys %tests;

$dic->add_word($_) for (@words);

ok(!$dic->get_words_with_prefix('xyz'), "non existing words");

for my $w (@words) {
	ok(grep {$_ eq $w} $dic->get_words_with_prefix($w), "checking for $w");
}

for my $p (keys %tests) {
	my @expected = sort @{$tests{$p}};
	my @obtained = sort $dic->get_words_with_prefix($p);
	is_deeply(\@expected, \@obtained, "checking for prefix $p");
}

$dic = PrefixTree->new();

my $palavra = "abracadabra";
my @palavras = map {substr $palavra, 0, $_} reverse 1..length($palavra);

for (@palavras) {
	ok(!$dic->get_words_with_prefix($_), "checking for non-existing word $_");
}

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

