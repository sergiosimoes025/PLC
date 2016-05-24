package ReconhecedorSpam;

use 5.016002;
use strict;
use warnings;
use Lingua::Stem;
use Data::Dumper;
use Lingua::StopWords(qw (getStopWords));
require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use ReconhecedorSpam ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw( calcula_prob_de_pal_pertencer_a_spam classificador_naive_bayes
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw( new
	
);

our $VERSION = '0.01';


sub new {
my ($self,@dic) = @_;
    my $objecto = bless {
       files_ham => {},
       files_spam => {},
       num_ham => 0,
       num_spam =>0,
    }, $self;
    return $objecto;
}

sub trim {
    my $s = shift;
    $s =~ s/^\s+|\s+$//g;
    return $s;
}


sub stripchars {
    my ( $s, $chars ) = @_;
    $s =~ s/[$chars]//g;
    return $s;
}


sub load_ham_files
{
   my ($self,$path) = @_;
   my $directory = $path;
   opendir (DIR, $directory) or die $!;
   while (my $file = readdir(DIR)) {
         $self->{num_ham}++;
         open (my $fh,"<","$path/$file") or die $!;
         my $flag = 0;
         
         
         while(<$fh>){
         my @words = split(/\s+/,$_);
          my $stopwords = getStopWords('en');
         my $aux =  join ' ', grep { !$stopwords->{$_} } map { lc } @words;
         #STEAMING INGLES
         #my $stemmer = Lingua::Stem->new();
         #my $stems = $stemmer->stem(@aux);
         @words = split(/\s+/,$aux);
         foreach my $word(@words){
          $word =~ s/[\$#@~\<\>\"\=\-!&*()\[\];.,:?^ `\\\/]+//g;
          $word = trim($word);
          if($word ne ""){
              $self->{files_ham}->{$file}->{$word}++;
             }
         
           }
         } 
       }  
return "TRUE";
}




sub load_spam_files 
{
   my ($self,$path) = @_;
   my $directory = $path;
   opendir (DIR, $directory) or die $!;
   while (my $file = readdir(DIR)) {
         $self->{num_spam}++;
         open (my $fh,"<","$path/$file") or die $!;
         my $flag = 0;
         
         while(<$fh>){
         my @words = split(/\s+/,$_);
         my $stopwords = getStopWords('en');
         my $aux =  join ' ', grep { !$stopwords->{$_} } map { lc } @words;
         #STEAMING INGLES
         #my $stemmer = Lingua::Stem->new();
         #my $stems = $stemmer->stem(@aux);
         @words = split(/\s+/,$aux);
         foreach my $word(@words){
           $word =~ s/[\$#@~<>\"\=\-!&*()\[\];.,:?^ `\\\/]+//g;
           $word = trim($word);
         
             if(!($word=~ m/\^s+/)){
              $self->{files_spam}->{$file}->{$word}++;
            }
           } 
         } 
          
       }
return "TRUE";
}

#devolve o numero de vezes que uma palavra ocorre nos ficheiros de SPAM ou HAM
sub get_num_of_occ_of_word{
  my ($self,$word,$m) = @_;
  my $res = -1;
  if($m eq "spam"){
      $res = 0;
      for(keys $self->{files_spam}){
      if(exists($self->{files_spam}->{$_}->{$word})){
        $res++;
        }
      }
   }
  else {
  if($m eq "ham"){
     $res = 0;
     for(keys $self->{files_ham}){
        if(exists($self->{files_ham}->{$_}->{$word})){
        $res++;
        }
    }
  }
}
return $res;
}


sub get_number_of_spam_files{
my $self = shift;
return $self->{num_spam};
}


sub get_number_of_ham_files{
my $self = shift;
return $self->{num_ham};
}


sub get_prob_of_be_ham{
my $self = shift;
return $self->{num_ham}/($self->{num_ham}+$self->{num_spam});
}


sub get_prob_of_be_spam{
my $self = shift;
return $self->{num_spam}/($self->{num_ham}+$self->{num_spam});
}


sub verifica_se_existe_pal_in_ham
{
my ($self,$word) = @_;
for(keys  $self->{files_ham}){
   
  if(exists $self->{files_ham}->{$_}->{$word}){
    return "TRUE";
  }
}
return "FALSE";
}





sub verifica_se_existe_pal_in_spam
{
my ($self,$word) = @_;
for(keys  $self->{files_spam}){
 if(exists $self->{files_spam}->{$_}->{$word}){
    return "TRUE";
  }
}
return "FALSE";
}


sub calcula_prob_de_num_emails_com_pal_spam{
 my ($self,$word) = @_;
 my $numero_de_emails_com_pal = $self->get_num_of_occ_of_word($word,"spam")/$self->{num_spam};
 return $numero_de_emails_com_pal;
}

sub calcula_prob_de_pal_pertencer_a_spam {
  my ($self,$word) = @_;
  my $numero_de_emails_com_pal = $self->get_num_of_occ_of_word($word,"spam")/$self->{num_spam};
  my $den = $self->get_num_of_occ_of_word($word,"spam")+$self->get_num_of_occ_of_word($word,"ham");
  $den = $den/($self->{num_ham}+$self->{num_spam});
  #print $numero_de_emails_com_pal." * ".$self->get_prob_of_be_spam()." ".$den."\n";
return (($numero_de_emails_com_pal * $self->get_prob_of_be_spam()) /($den));
}


sub classificador_naive_bayes
{
my ($self,$text) = @_;
my $res = 0.0;
my @array = split(/\s+/,$text);

for(@array){
  if($self->calcula_prob_de_num_emails_com_pal_spam($_) != 0){
     
      $res += -(log($self->calcula_prob_de_num_emails_com_pal_spam($_)));
   }
}

$res = $res * $self->get_prob_of_be_spam();
$res = $res / ($self->{num_ham}+$self->{num_spam});
 return $res;
}








# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

ReconhecedorSpam - Perl extension for blah blah blah

=head1 SYNOPSIS

  use ReconhecedorSpam;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for ReconhecedorSpam, created by h2xs. It looks like the
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

Sérgio  Simões, E<lt>Perez_25@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Sérgio  Simões

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
