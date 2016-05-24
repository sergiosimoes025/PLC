package ReconhecedorTexto;
use POD2::Base;
use 5.016002;
use strict;
use warnings;
use Algorithm::NaiveBayes;
require Exporter;


our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions.

# This allows declaration	use MyModule ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw( trim new get_entidades_by_categoria_dic get_palavras_texto_by_classe read_file add_word get_classes_DIC  get_palavras_DIC_by_sub_classe get_palavras_DIC_by_classe adicionar_palavra_ao_dic get_tipos_entidades_de_dic get_entidades_by_entidade_texto stripchars);

our $VERSION = '0.01';


# Preloaded methods go here.
sub new
{
 my ($self, $texto) = @_;
 my $objecto = bless {dicionario => {}, palavras => 0, texto => {},linhas => [], entidades => {} }, $self;
 $objecto->read_file("dic/pt-PT.dic"); 
 $objecto->read_entidades("dic/entidades.txt"); 
 return $objecto;
}


sub stripchars {
    my ($s, $chars) = @_;
    eval("\$s =~ tr/$chars//d;");
    return $s;
}

sub stripchars2 {
    my ($s, $chars) = @_;
    $s =~ s/[$chars]//g;
    return $s;
}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub read_entidades{
my ($self,$entidades) = @_;
my $file;
  open $file, "<", $entidades or die "Opening $entidades: $!";
   while(<$file>) {
      chomp;
     $self->add_entidade($_);
    }
    close $file;
 }


sub add_entidade{
    my ($self,$linha)  = @_;
    my $cat;
    my @palavras = split(/\[/,$linha);  
    $palavras[0] =~ m/[^\|]+/p;
    $palavras[0] = $&;
    $palavras[0] = trim($palavras[0]);
    $palavras[1] =~ m/CAT=/p;
    $cat = ${^POSTMATCH};
    $cat =~ m/[^\,]+/p;
    $cat = $&;
    $cat = stripchars($cat,"\[\,\]");
    $cat = trim($cat);
   
   if($palavras[1] =~ m/SUB=/p)
      {
      my $sub = ${^POSTMATCH};
      
        if($palavras[1] =~ m/INF=/p){
         my $inf = ${^POSTMATCH}; 
         $inf =~ m/[^\]]+/p;
         $inf = $&;
         $sub = stripchars($sub,"\[\]");
         $sub =~ m/[^\,]+/p;
         $sub = $&;
         
       
         push @ {$self->{entidades}->{$cat}->{$sub}->{$palavras[0]}},$inf;
       }
        else {
         $sub =~ m/[^\]]+/p;
         $sub = $&;
         $sub = stripchars($sub,"\[\]");
        push @ {$self->{entidades}->{$cat}->{$sub}->{$palavras[0]}},"NR";
       }
      }
    
  else {
    if($palavras[1] =~ m/INF=/p){
     my $inf = ${^POSTMATCH};
     $inf =~ m/[^\]]+/p;
     $inf = $&;
     $inf = stripchars($inf,"\]");
    push @ {$self->{entidades}->{$cat}->{"SEM SUB-CATEGORIA"}->{$palavras[0]}},$inf;
  }
  else {
  
   push @ {$self->{entidades}->{$cat}->{"SEM SUB-CATEGORIA"}->{$palavras[0]}},"NR";
        }
    }
}


sub get_tipos_entidades_de_dic
{
my ($self) = shift;
my @response;
for(keys $self->{entidades}){
    push (@response," o ".$_);
   }
    
return @response;
}

sub get_entidades_by_entidade_texto{
    my($self,$categoria) = @_;
    $categoria = trim($categoria);
    my %res = ();
    my $response = \%res;
     for(keys $self->{entidades}{$categoria}){
      my $sub = $_;
      for(keys $self->{entidades}{$categoria}{$sub}){
        foreach my $linha (@{$self->{linhas}}){
        $linha = trim($linha);
            if (index($linha, $_) != -1 && !($linha eq "")) {
             $response->{$sub}{$_}{$self->{entidades}{$categoria}{$sub}{$_}[0]}++;
             } 
           }        
         }
       }
       return %res;
     }
     

sub get_entidades_by_categoria_dic{
my ($self,$categoria) = @_;
my @response;
if(!exists $self->{entidades}{$categoria}) {
return @response;
}
for(keys $self->{entidades}{$categoria}){
     push(@response,"SUB CLASSE $_ \n");
     my $sub = $_;
     for(keys $self->{entidades}{$categoria}{$_}){
     
       push(@response, "o $_");
         my $length = @{$self->{entidades}{$categoria}{$sub}{$_}};
         for(my $i=0;$i<$length;$i++){
           push(@response, " INF - $self->{entidades}{$categoria}{$sub}{$_}[$i]\n");
            }
        }
    push(@response,"\n");
    }
    return @response;
}

sub read_file{
my ($self, @DICS) = @_;
foreach my $dic (@DICS) {
     my $file;
     if($dic =~ /.*\.gz$/) {
     open $file, "gzcat $dic |" or die "Opening $dic: $!";
      }
    if($dic =~ /.*\.bz2$/) {
      open $file, "bzcat $dic |" or die "Opening $dic: $!";
    }
    else {
      open $file, "<", $dic or die "Opening $dic: $!";
    }

   while(<$file>) {
      chomp;
      
      $self->add_word($_);
      
    }
    close $file;
  	}
}

sub read_texto{
my  ($self,$texto) = @_;
my $file;
open $file, "<", $texto or die "Opening $texto: $!";


while(<$file>){
    chomp;
    $self->insert_words_of_text($_);
    }
    print "Leitura completa do ficheiro $texto\n";
}


sub insert_words_of_text{
 my($self,$linha) = @_;
 my @palavras = split(/\./,$linha);
 foreach my $palavra(@palavras){
    push($self->{linhas},$palavra);
    my @words = split(/\s+/,$linha);
    foreach my $word (@words){
        $word = stripchars2($word,"\"\“\”\!\.\,\?\;\:");
        $word = trim($word);
        $self->{texto}{$word}++;
        }
    }
}

sub get_palavras_texto_by_classe{
my ($self,$classe) = @_;
my @response;
my $aux = 0;
$classe = trim($classe);
if(exists($self->{dicionario}{$classe})){
 push(@response,"CLASSE $classe\n");
 for(keys $self->{dicionario}{$classe}){
    my $sub = $_;
    push(@response,"- SUB CLASSE $sub \n");
   
    for(keys $self->{texto}){
      my $length = @{ $self->{dicionario}{$classe}{$sub}};
        for(my $i=0;$i<$length;$i++){
           
               if($self->{dicionario}{$classe}{$sub}[$i] eq $_){
                push (@response," o ".$_);
                $aux = 1;
                    }    
                }
            }
            if($aux == 0) {
                pop @response;
            }
            else {
            $aux = 0;
            push(@response,"\n");
            }
            
        }
        push(@response,"\n\n");
    }
    return @response;
}


 sub add_word{
 my ($self,$linha) = @_;
 
 my @palavras = split(/\s+/,$linha);

if($palavras[1] =~ m/CAT=[a-zA-Z]+/p)
  { my $aux = $&;
    $aux =~ m/[^CAT=]+/p;
   
   
    if($& eq 'v'){
      if($palavras[1]=~ (m/SEM=[a-zA-Z]+/p)){
       my $sem = $&;
       $sem =~ m/[^SEM=]+/p;
        push @{$self->{dicionario}->{'Verbo'}->{$&}},$palavras[0];
        }
        else {
         push @{ $self->{dicionario}->{'Verbo'}->{'SG'}},$palavras[0];
        }
      }
    
    if($& eq 'np'){
     if($palavras[1]=~ (m/SEM=[a-zA-Z]+/p)){
       my $sem = $&;
       $sem =~ m/[^SEM=]+/p;
        push @{ $self->{dicionario}->{'Nome Próprio'}->{$&}},$palavras[0];
        }
    else {
         push @{ $self->{dicionario}->{'Nome Próprio'}->{'SG'}},$palavras[0];
        }    
    }
      
    if($& eq 'nc'){
     if($palavras[1]=~ (m/SEM=[a-zA-Z]+/p)){
       my $sem = $&;
       $sem =~ m/[^SEM=]+/p;
       push @{ $self->{dicionario}->{'Nome Comum'}->{$&}},$palavras[0];
      }
        
      else {
        push @{ $self->{dicionario}->{'Nome Comum'}->{'SG'}},$palavras[0];
        }
     }
     
    
    if($& eq 'adj'){
    
      if($palavras[1]=~ (m/SEM=[a-zA-Z]+/p)){
       my $sem = $&;
       $sem =~ m/[^SEM=]+/p;
       push @{ $self->{dicionario}->{'Adjectivo'}->{$&}},$palavras[0];
        }
      else {
        push @{ $self->{dicionario}->{'Adjectivo'}->{'SG'}},$palavras[0];
        }
      } 
    };
 }




sub get_classes_DIC {
my @response;
my $self = shift;
for(keys $self->{dicionario}){
    push(@response,"CLASSE : ".$_."\n\n");
    push(@response,"SUBCLASSES : \n");
    for(keys $self->{dicionario}->{$_}){
        push(@response,"$_\n");
        }
    }
    return @response;
}


sub get_palavras_DIC_by_classe{
my ($self,$classe) = @_;
my @response;
if(exists($self->{dicionario}->{$classe})){
  for(keys $self->{dicionario}->{$classe}){
    my $length = @{ $self->{dicionario}{$classe}{$_}};
        push (@response,"CATEGORIA : $_ \n ");
        for(my $i=0;$i<$length;$i++){
               push (@response,$self->{dicionario}{$classe}{$_}[$i]);
          }
       }
    }
    return @response;
}


sub get_palavras_DIC_by_sub_classe{
my ($self,$classe,$subclasse) = @_;
$classe = trim($classe);
$subclasse = trim($subclasse);
 my @response;
if(exists($self->{dicionario}->{$classe}{$subclasse})){
   
    my $length = @{ $self->{dicionario}{$classe}{$subclasse}};
    for(my $i=0;$i<$length;$i++){
               push (@response,$self->{dicionario}{$classe}{$subclasse}[$i]);
          }
    }
    return @response;
}



sub adicionar_palavra_ao_dic{
 my($self,$palavra,$classe,$subclasse) = @_;
 if(!exists $self->{dicionario}->{$classe}->{$subclasse}){
 push @{ $self->{dicionario}->{$classe}->{$subclasse}},$palavra;
    return 'TRUE';
   }
   return 'FALSE';
}




1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

ReconhecedorTexto - Extensão do Perl para reconhecimento de texto em PT.

=head1 SYNOPSIS

  use ReconhecedorTexto;
  
  Para testar o programa basta enviar como argumento o ficheiro a testar. Permite determinar
tipos de palavras e as entidades no programa. Para além de tal é possível inserir novas palavras.


=head1 DESCRIPTION



=head2 Methods

=over 12

=item C<new>

Retorna um objecto novo do tipo ReconhecedorTexto. 

=item C<get_tipos_entidades_de_dic>

Retorna a lista de entidades do dic

=item C<get_entidades_by_entidade_texto>

Retorna as entidades do texto lido dado uma categoria.

=item C<adicionar_palavra_ao_dic>

Permite adicionar uma palavra ao dic, dada uma classe e subclasse existentes.


=item C<get_palavras_DIC_by_sub_classe>

Retorna as palavras de uma classe e subclasse do dic.


=item C<get_palavras_texto_by_classe>

Retorna as palavras de uma dada classe do texto lido.


=item C<get_palavras_DIC_by_classe>

Retorna as palavras de uma dada classe do dic


=back




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
