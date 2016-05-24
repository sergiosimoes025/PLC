package My::PrefixTree;

use 5.016002;
use strict;
use utf8;
use Unicode::UCD 'charinfo';

use warnings;
use File::Basename;
use IO::Uncompress::Gunzip qw(gunzip $GunzipError) ;
require Exporter;
use Storable;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use My::PrefixTree ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(new load add_dict add_word rem_word get_words_with_prefix word_exists prefix_exists);

our $VERSION = '0.01';

#construtor do objecto Prefix Tree
sub new {
  my ($self, @dicionario) = @_;
  #bless  método que concebe o objecto
  my $objecto = bless {dicionario => {}, palavras => 0}, $self;
  $objecto->add_dict($_) for (@dicionario);
  return $objecto;
}

  sub add_dict{
  my ($self, @dicionarios) = @_;

  foreach my $dicionario (@dicionarios) {
     my $file;
    if($dicionario =~ /.*\.gz$/) {
     open $file, "gzcat $dicionario |" or die "Opening $dicionario: $!";
      }
    if($dicionario =~ /.*\.bz2$/) {
      open $file, "bzcat $dicionario |" or die "Opening $dicionario: $!";
    }
    else {
      open $file, "<", $dicionario or die "Opening $dicionario: $!";
    }
   while(<$file>) {
      chomp;
      $self->add_word($_);
    }
    close $file;
  }
}

#carregar o objecto
sub load{
  my ($self,$ficheiro) = @_;
  $self->{dic} = retrieve $ficheiro;
  return "Ficheiro carregado";
}

#guardar o objecto
sub save{
  my ($self, $ficheiro) = @_;
  store $self->{dicionario}, $ficheiro;
  return "Ficheiro guardado";

}

sub add_word{
  my ($self, @palavras) = @_;
    foreach my $palavra (@palavras){
      my $ref_dic = $self->{dicionario};
      if(!$self->word_exists($palavra)){
          $self->{palavras}++;
        }
      foreach my $letra(split //, $palavra){

        #se não existir ainda a letra x
        if(!exists $ref_dic->{$letra}){
            $ref_dic->{$letra} = {};
          }
          #passo lhe a ref
          $ref_dic = $ref_dic->{$letra};
          #print "$ref_dic\n";
          }
          $ref_dic->{'$'} = 1;
         }
       }


sub rem_word{
 my ($self,$palavra) = @_;
 my @ref_palavras;
 my $letra;
 my $ref_dic = $self->{dicionario};
 if($self->word_exists($palavra) eq "Falso"){
  return "Palavra Inexistente";
 }

  foreach  my $letter(split //,$palavra){
    if(exists $ref_dic->{$letter}){
      #apanho todas as ref desta palavra
      push @ref_palavras, [$letter, $ref_dic];
      $ref_dic=$ref_dic->{$letter};
    }
  }
  delete $ref_dic->{'$'};

  while((keys $ref_dic == 0)){
      ($letra, $ref_dic) = @{pop @ref_palavras};
      delete $ref_dic->{$letra};
  }
  return "Sucesso";
}



sub word_exists {
  my ($self,$palavra) = @_;
  my $res = 1;
  #passo a referencia
  my $ref_dic = $self->{dicionario};
  foreach my $letter(split //,$palavra){
    if(!exists $ref_dic->{$letter}){
      return "Falso";
      }
    $ref_dic = $ref_dic->{$letter};
    }

    if(exists $ref_dic->{'$'}){
        return "Verdadeiro";
    }
    else {
      return "Falso";
    }
  }

sub prefix_exists{

    my($self,$prefixo) = @_;
    my $ref_dic = $self->{dicionario};
    foreach my $letter(split //,$prefixo){
    if(!exists $ref_dic->{$letter}){
      return "Falso";
      }
     $ref_dic = $ref_dic->{$letter};
    }
    return "Verdadeiro";
}

sub get_words_with_prefix {
  my ($self,$prefix) = @_;
  my @palavras;
  #execepcao eval /join  concatena string com um token
  my $dic = eval sprintf('$self->{dicionario}{%s}', join("}{", split //, $prefix));
  $dic = {} unless defined $dic;

    foreach my $letra (keys $dic){
     if($letra eq '$'){
       push @palavras, $prefix;
      }
      else {
        push @palavras, $self->get_words_with_prefix($prefix.$letra);
      }
    }
    @palavras;
  }



# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

My::PrefixTree - Extensão do perl para uma árvore de prefixos.


=head1 SYNOPSIS

use Data::Dumper;
use My::PrefixTree;

use strict;
use warnings;

my $dicionario;
my $obj;

if(@ARGV){
  $dicionario = shift;
  $obj = new My::PrefixTree($dicionario);
  $obj->save("teste");

}
else {
  $obj = new My::PrefixTree();
  $obj->load("teste");
}


my @words = qw (aba abel abobora abola);

$obj->add_word($_) for (@words);

$obj->add_word('aba');

my @res = $obj->get_words_with_prefix('ab');

=head1 DESCRIPTION

Este módulo armazena todos os prefixos das palavras introduzidas.
 Uma das grandes vantagens desta estrutura é que serve para armazenar uma lista de palavras de uma forma compacta.

=head2 Métodos

=over 12

=item Construtor:new([$ficheiros])

Aqui, [] indica que é um parâmetro opcional.
Este método vai retornar uma PrefixTree. Aceita um,ou mais argumentos que se forem validados
(se os ficheiros tiverem extensão .gz ou .bz2 ou .txt), os dados que estes contiverem,serão inseridos na
árvore.


=item add_dict($ficheiro)

Sub rotina que se vai encarregar de tratar um ficheiro de texto com
a finalidade de o inserir na estrutura.


=item save($ficheiro)

 Este método permite armazenar o objeto em disco.

=item load($ficheiro)

 Este método permite carregar o objeto em disco.


=item addword($palavra)

Este método permite adicionar uma palavra na árvore de prefixos.

=item get_words_with_prefix($prefix)

Este método devolve todas as palavras que tenham o prefixo "$prefix".


=item prefix_exists($prefix)

Este método devolve verdadeiro ou falso caso o prefixo exista na estrutura.

=item word_exists($palavra)

Este método devolve verdadeiro ou falso caso a palavra exista na estrutura.

=item rem_word($palavra)

Este método elimina uma palavra da estrutura.

=back


=head1 EXTRAS

De modo a facilitar a utilização deste módulo foi criado um ficheiro onde se encontra um menu simples.


=head1 AUTHOR

Sérgio  Simões, E<lt>Perez_25@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Sérgio  Simões

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
