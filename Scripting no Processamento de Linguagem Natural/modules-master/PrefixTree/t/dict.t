use strict;
use warnings;

use Test::More tests => 1;
use PrefixTree;

my $dic = PrefixTree->new(qw {dic.bz2 smalldict.txt});

my @expected = sort qw{ bigamo bigode bigamia bigodes bigorna bigodaca bigornas bigodacas bigodinho big bigger };
my @obtained = sort $dic->get_words_with_prefix('big');

is_deeply(\@expected, \@obtained);
