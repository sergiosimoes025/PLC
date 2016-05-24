use strict;
use warnings;
use Data::Dumper;
use SuffixTree;

my $st = new SuffixTree('dic');

print Dumper($st);

__END__
for (qw {abaco baco aco xyzw}) {
	my $res = $st->find($_);
	printf "%s: %d %s\n", $_, ! $res, Dumper $res;
}
