use strict;
use warnings;

use Test::More tests => 11;
BEGIN { use_ok('PrefixTree') };
use PrefixTree;

my $dic = PrefixTree->new();

my @palavras = qw{ aba abaco abeto abrir aberto abertura aparecer aparece aparecida apurar apurado adesao aderir };

$dic->add_word(@palavras);

my @remover = qw{ abaco abertura abertos aparecer apareces aparec apurado };

$dic->rem_word(@remover);

my %tests = (
	'ab' => [qw{aba abeto abrir aberto}],
	'aba' => [qw{aba}],
	'abe' => [qw{abeto aberto}],
	'aber' => [qw{aberto}],
	'ap' => [qw{aparece aparecida apurar}],
	'apa' => [qw{aparece aparecida}],
	'aparec' => [qw{aparece aparecida}],
	'apu' => [qw{apurar}],
	'apura' => [qw{apurar}],
	'ad' => [qw{adesao aderir}]
);

for my $p (keys %tests) {
	my @expected = sort @{$tests{$p}};
	my @obtained = sort $dic->get_words_with_prefix($p);
	is_deeply(\@expected, \@obtained, "checking for prefix $p");
}
