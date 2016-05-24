package SuffixTree;

use 5.014002;
use strict;
use warnings;

use List::Util qw{reduce};

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use SuffixTree ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

sub new {
	my ($super, @dicts) = @_;
	$super = bless {dic => {}, words => 0}, $super;
	$super->add_dict($_) for (@dicts);
	$super;
}

sub add_dict {
	my ($self, $dict) = @_;
	my $fh;
	if($dict =~ /.*\.bz2$/) {
		open $fh, "bzcat $dict |" or die "Opening $dict: $!";
	} else {
		open $fh, "<", $dict or die "Opening $dict: $!";
	}

	while(<$fh>) {
		chomp;
		$self->add_word($_);
	}
	close $fh;
}


sub add_word {
	my ($super, $word) = @_;

	for(my $i = 0; $i < length $word; $i++) {
		my $dic = reduce {
			$a->{$b} = {} unless exists $a->{$b};
			$a->{$b};
		} $super->{dic}, split //, substr($word, $i);
		push @{$dic->{'##'}}, [$super->{words}, $i];
	}
	$super->{words}++;
}

sub find {
	my ($super, $word) = @_;
	my $dic = reduce {
		#$a->{$b} if defined $a;
		(defined $a) ? $a->{$b} : undef;
	} $super->{dic}, split //, $word;
	$dic;
}


# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

SuffixTree - Perl extension for blah blah blah

=head1 SYNOPSIS

  use SuffixTree;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for SuffixTree, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

VirtualBoxImages.com, E<lt>adminuser@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by VirtualBoxImages.com

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
