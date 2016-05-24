use Data::Dumper;
use PrefixTree;

my $pt;

if(@ARGV) {
	my $dic = shift;
	$pt = new PrefixTree($dic);

	#$pt->add_word($_) for (qw {aba abaco abeto abrir aberto abertura});
} else {
	$pt = new PrefixTree();
	$pt->load("guardado");
}

$pt->rem_word(abaco);
$pt->rem_word(abjurar);
$pt->rem_word(abet);
$pt->rem_word(aperta);


print Dumper($pt);

printf("%s: %s\n", $_, join(" ", $pt->get_words_with_prefix($_))) for (qw {ab ap});

$pt->save("guardado");
