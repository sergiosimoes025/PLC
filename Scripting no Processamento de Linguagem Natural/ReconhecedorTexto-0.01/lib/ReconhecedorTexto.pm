package ReconhecedorTexto;
use POD2::Base;
use 5.016002;
use strict;
use Pod::Html;
use warnings;
use Storable;
require Exporter;
use Lingua::StopWords qw( getStopWords );
use Pod::Autopod;


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

our @EXPORT = qw( load save devolve_classe_de_palavra  mudar_ling verifica_se_palavra_pert_a_classe get_entides_by_regex adicionar_entidade_ao_dic  get_percentagem_total get_all_entidades_texto 
trim new get_entidades_by_categoria_dic get_palavras_texto_by_classe read_file add_word get_classes_DIC  get_palavras_DIC_by_sub_classe get_palavras_DIC_by_classe adicionar_palavra_ao_dic get_tipos_entidades_de_dic get_entidades_by_entidade_texto stripchars);

our $VERSION = '0.01';


# Preloaded methods go here.
sub new
{
 my ($self, $ent,$dic) = @_;
 my $objecto = bless {
  dicionario => {}, 
  palavras => 0, 
  texto => {},
  linhas => {},
  ficheiro => 'NR',
  entidades => {},
  lingua => 'pt'
 }, $self;
 if(defined $dic && defined $ent){
  $objecto->read_file($dic); 
  $objecto->read_entidades($ent); 
 }
 return $objecto;
}


sub mudar_ling {
 my($self,$lan) = @_;
 
 $self->{lingua} = $lan;

return "SUCESS";
}

sub save{
my ($self, $name) = @_;

	store [$self->{dicionario},
        $self->{entidades},
        $self->{lingua}],
        $name;
        
        return "SUCESS";
}


sub load{
my ($self,$name) = @_;

 ($self->{dicionario},$self->{entidades},$self->{lingua}) = @{retrieve $name};
 return "SUCESS";
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


sub get_percentagem_by_classe
{
my ($self,$categoria) = @_;
my $count = 0;

for(keys $self->{dicionario}{$categoria}){
  for( @{$self->{dicionario}{$categoria}{$_}}){
       my $pal2 = $_;
       for(keys $self->{texto}){
        my $pal1 = $_;
        $pal1 = uc($_);
        $pal2 = uc($pal2);
        if($pal1 eq $pal2){
        $count++;
        }
       }  
      }
    }
  return ($count/$self->{palavras})*100;
  }


sub get_percentagem_total {
my @res;
my $self = shift;
my $tot=0.0;
for(keys $self->{dicionario}){
 my $c = $self->get_percentagem_by_classe($_);
  $tot+=$c;
 push(@res," $_  =>  $c % \n");
}
my $n = 100.0 - $tot;
 push(@res,"\n TOTAL  : $tot   -   NÃO IDENTIFICADO : ".$n."  \n");
return @res;
}


sub get_all_entidades_texto {
my ($self) = shift;
my @response;
my $aux = 0;
my $aux2 = 0;
for(keys $self->{entidades}){
  my $cat = $_;
  push(@response," - CAT $_\n");
  for(keys $self->{entidades}{$cat}){
    my $sub = $_;
    push(@response,"  -- SUB-CAT $_\n");
   for(keys $self->{entidades}{$cat}{$sub}){
     my $ent1 = $_;
     my $ent = $_;
     $ent = uc($ent);

     for (keys $self->{linhas}){
       my $linha = trim($self->{linhas}{$_});
       $linha = uc($linha);
     if ($linha =~ m/ $ent\,?\.? ?/p) {
           $aux = 1;
           $aux2 = 1;
           push (@response,"    o $ent1 - $self->{entidades}{$cat}{$sub}{$ent1}[0] - LINHA  $_\n");
              } 
           }
        }
      if($aux == 0){
      pop @response;
      }
      else {
      $aux = 0;
       push(@response,"\n");
        }
      }
       if($aux2 == 0){
      pop @response;
      }
      else {
      $aux2 = 0;
      push(@response,"\n\n");
        }
    }
  
  return @response;
}

sub get_entidades_by_entidade_texto{
    my($self,$categoria) = @_;
    $categoria = trim($categoria);
    my %res = ();
    my $response = \%res;
    if(exists  $self->{entidades}{$categoria}){
    
     for(keys $self->{entidades}{$categoria}){
      my $sub = $_;
      for(keys $self->{entidades}{$categoria}{$sub}){
       my $ent = uc($_);
      
       my $ent_1 = $_;
       for (keys $self->{linhas}){
        my $linha = trim($self->{linhas}{$_});
        $linha = uc($linha);
        
        
        if ($linha =~ m/ $ent\,?\.? ?/p) {
            $response->{$sub}{$ent_1}{$self->{entidades}{$categoria}{$sub}{$ent_1}[0]}++;
              } 
            }        
          }
        }
       }
       return %res;
     }
     

sub get_entides_by_regex {
my $self = shift;
my @res;
my $file;
my $i = 1;
open $file, "<", $self->{ficheiro} or return "FALSE";
foreach my $line(<$file>){  
chomp $line; 

 $line =~ s/[\$#@~!&*()\[\];:?^`\\\/]+//g;
 
while(($line =~ m/(([A-Z][a-zàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšž]*( ?(da|de|do|e))?\s?)+([A-ZÚÍÉÓ])*)/g)){
    my @catch = split(/\s+/,$&);
    
    my $stopwords = getStopWords($self->{lingua},'UTF-8');
    my $s = join ' ', grep { !$stopwords->{$_} } @catch;
    @catch =split(/\s+/,$s);

    for(@catch){
    my $linha = trim($_);
       for(keys $self->{dicionario}){
       if($_ ne "Nome Próprio" && $_ ne "Nome Comum"){
       if($self->verifica_se_palavra_pert_a_classe($linha,$_) eq "TRUE"){
        shift @catch;
        }
       }
     }
   }
     my $scal = join(" ", @catch);
     if($scal ne "" &&  $scal ne "?"){
     push(@res, " o ".$scal."   -- LINHA : ".$i." \n");
      }
    }
    $i++;
 }
  return @res;
}


sub verifica_se_palavra_pert_a_classe {
my ($self,$word,$class) = @_;

  if(exists $self->{dicionario}->{$class}){
    for(keys $self->{dicionario}->{$class}){
      for(@{$self->{dicionario}->{$class}{$_}}){
          if(ucfirst($word) eq ucfirst($_)){
          return "TRUE";
          }
        }
      }
    }
  return "FALSE";
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
      open $file, "<", $dic or die "Opening $dic: $!";
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

$texto = trim($texto);
$self->{ficheiro} = $texto;
open $file, "<", $texto or return "FALSE";


my $i = 0;
while(<$file>){
    chomp;
    my @palavras = split(/\.\n/,$_);
    foreach my $palavra (@palavras){
      $self->{linhas}{$i} = $palavra;
      $i++;
      my @words = split(/\s+/,$_);
      foreach my $word (@words){
          $self->{palavras}++;
          $word = stripchars2($word,"\"\“\”\!\.\,\?\;\:");
          $word = trim($word);
          $self->{texto}{$word}++;
          }
        }
      }
return "TRUE";
}



sub get_palavras_texto_by_classe{
my ($self,$classe) = @_;
my @response;
my $aux = 0;
$classe = trim($classe);
if(exists($self->{dicionario}{$classe})){
 push(@response," - CLASSE $classe\n");
 for(keys $self->{dicionario}{$classe}){
    my $sub = $_;
    push(@response," -- SUB CLASSE $sub \n");
   
    for(keys $self->{texto}){
      my $length = @{ $self->{dicionario}{$classe}{$sub}};
        for(my $i=0;$i<$length;$i++){
               my $flag = 0;
               my $pal1 = ucfirst($self->{dicionario}{$classe}{$sub}[$i]);
               my $pal2 = ucfirst($_);
               if($pal1 eq $pal2){
               for(my $j=0;$j<@{response};$j++){
                 if($response[$j] eq "    o ".$self->{dicionario}{$classe}{$sub}[$i]){
                   $flag = 1;
                   last;
                }
               }
               if($flag == 0){
               push (@response,"    o ".$_."\n");
                $aux = 1;
                    }    
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
      if($palavras[1]=~ (m/,T=[a-z\-A-Z]+/p)){
       my $sem = $&;
       $sem =~ m/[^,T=]+/p;
        push @{$self->{dicionario}->{'Verbo'}->{$&}},$palavras[0];
        }
        else {
         push @{ $self->{dicionario}->{'Verbo'}->{'SG'}},$palavras[0];
        }
      return;
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
        return;    
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
         return;
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
         return;
      }
      
       if($& eq 'ppos'){
        if($palavras[1]=~ (m/G=[a-zA-Z]+/p)){
         my $sem = $&;
         $sem =~ m/[^G=]+/p;
         push @{ $self->{dicionario}->{'Pronome Possessivo'}->{$&}},$palavras[0];
        }
      else {
        push @{ $self->{dicionario}->{'Pronome Possessivo'}->{'Sem Género'}},$palavras[0];
        }
       return;
       }
       
       if($& eq 'art'){
        if($palavras[1]=~ (m/CLA=[a-zA-Z]+/p)){
         my $sem = $&;
         $sem =~ m/[^CLA=]+/p;
         push @{ $self->{dicionario}->{'Artigo'}->{$&}},$palavras[0];
        }
      else {
        push @{ $self->{dicionario}->{'Artigo'}->{'SG'}},$palavras[0];
        }
       return;
       }
       
       if($& eq 'nord'){
      
         if($palavras[1]=~ (m/G=[a-zA-Z]+/p)){
         my $sem = $&;
         $sem =~ m/[^G=]+/p;
         push @{ $self->{dicionario}->{'Numeral ordinal'}->{$&}},$palavras[0];
        }
      else {
        push @{ $self->{dicionario}->{'Numeral ordinal'}->{'Sem género'}},$palavras[0];
        }
       return;
       }
       
      if($& eq 'cp'){
        if($palavras[1]=~ (m/G=[a-zA-Z]+/p)){
         my $sem = $&;
         $sem =~ m/[^G=]+/p;
         push @{ $self->{dicionario}->{'Contração da preposição'}->{$&}},$palavras[0];
        }
      else {
        push @{ $self->{dicionario}->{'Contração da preposição'}->{'Sem Género'}},$palavras[0];
        }
       return;
       }
       
       
        if($& eq 'ppes'){
        if($palavras[1]=~ (m/N=[a-zA-Z]+/p)){
         my $sem = $&;
         $sem =~ m/[^N=]+/p;
         push @{ $self->{dicionario}->{'Pronomes Pessoais'}->{$&}},$palavras[0];
        }
      else {
        push @{ $self->{dicionario}->{'Pronomes Pessoais'}->{'Sem Numero'}},$palavras[0];
        }
       return;
       }
       
      if($& eq 'card'){
        push @{ $self->{dicionario}->{'Numero'}->{"SG"}},$palavras[0];
       return;
       }
       
        if($& eq 'pind'){
        push @{ $self->{dicionario}->{'Pronome Indefinido'}->{"SG"}},$palavras[0];
       return;
        }
        
        if($& eq 'pdem'){
        push @{ $self->{dicionario}->{'Pronome Demonstrativo'}->{"SG"}},$palavras[0];
       return;
        }
        
         if($& eq 'prel'){
        push @{ $self->{dicionario}->{'Pronome Relativo'}->{"SG"}},$palavras[0];
       return;
        }
        
         if($& eq 'pint'){
          push @{ $self->{dicionario}->{'Pronome Interrogativo'}->{"SG"}},$palavras[0];
          return;
        }
         
       
       
      if($& eq 'prep'){
         push @{ $self->{dicionario}->{'Preposição'}->{"SG"}},$palavras[0];
        return;
      }
      
        if($& eq 'pref'){
         push @{ $self->{dicionario}->{'Preferencia'}->{"SG"}},$palavras[0];
        return;
      }
      
       if($& eq 'con'){
         push @{ $self->{dicionario}->{'Conector'}->{"SG"}},$palavras[0];
        return;
      }
       if($& eq 'adv'){
        if($palavras[1]=~ (m/SUBCAT=[a-zA-Z]+/p)){
          my $sem = $&;
          $sem =~ m/[^SUBCAT=]+/p;
          push @{ $self->{dicionario}->{'Advérbio'}->{$&}},$palavras[0];
          }
         else {
          push @{ $self->{dicionario}->{'Advérbio'}->{'Sem sub-classe'}},$palavras[0];
        }
         return;
      }
      
      else {
          push @{ $self->{dicionario}->{$&}->{'SG'}},$palavras[0];
      }
    }
 }


sub get_classes_DIC {
my @response;
my $self = shift;
for(keys $self->{dicionario}){
    push(@response," - CLASSE : ".$_."\n\n");
    push(@response," -- SUBCLASSES : \n");
    for(keys $self->{dicionario}->{$_}){
        push(@response,"   o $_\n");
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


sub devolve_classe_de_palavra {
my ($self,$palavra) = @_;

for(keys $self->{dicionario}){
  my $classe = $_;
  for(keys $self->{dicionario}->{$classe}){
  my $sub = $_;
  for(@{$self->{dicionario}->{$classe}->{$sub}}){
      
      if(ucfirst($palavra) eq ucfirst($_)){
      return $classe;
        }
      }
    }
  }
  return "NR";
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
 
 $palavra = trim($palavra);
 $subclasse = trim($subclasse);
 $classe = trim($classe);
 
 push @{ $self->{dicionario}->{$classe}->{$subclasse}},$palavra;
    return 'TRUE';
}

sub adicionar_entidade_ao_dic{
 my($self,$entidade,$classe,$subclasse,$inf) = @_;
 push @{ $self->{entidades}->{$classe}->{$subclasse}{$entidade}},$inf;
    return 'TRUE';
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!


=pod

=head1 NOME

ReconhecedorTexto - Extensão do Perl para reconhecimento de texto.

=head1 SYNOPSIS

  use ReconhecedorTexto;
 
 
=head1 RESUMO

E<8>

Este módulo permite fazer o reconhecimento de texto, tendo sido trabalhado especificamente para o reconhecimento da língua Portuguesa. Contudo,o módulo é bastante modular, ou seja, é apenas necessário
adicionar um dicionário de palavras mais um de entidades. Este pode ser constituido por palavras em qualquer tipo de idioma. Para além disso, o programa consegue através de regex determinar entidades, caso não seja necessário adicionar qualquer tipo
de dicionário.É importante referir que para este caso as entidades encontradas não terão qualquer tipo de informação visto estas têm que estar referenciado no dicionário de entidades.
  
=head1 LÓGICA DO PROGRAMA
  
E<8>

O programa inicialmente começa por ler os dicionários enviados por argumento e através destes popula 
as estruturas que estão presentes no objecto. As estruturas guardam as palavras contidas no dicionário
de palavras assim como as entidades contidas no dicionário. As estruturas são as seguintes:

=over 12

=item I<Palavras>

   o $obj->{dicionario}->{$classe}->{$subclasse}->[$pal1,$pal2,...]
   
=item I<Entidades>

   o $obj->{entidades}->{$classe}->{$subclasse}->{$entidade}->[$inf1,$inf2...]

=back
   
Para além das estruturas que contêm as palavras e as entidades, caso seja enviado um ficheiro de texto como argumento, 
este é igualmente inserido na estrutura. A inserção do texto é feita de duas formas, por linhas e por palavras. Isto deve-se 
ao facto de futuramente ser possível procurar somente palavras ou entidades.
   
   

   
=head1 DICIONÁRIOS

E<8>

São necessários dois dicionários, um constituido por palavras e outro por entidades.
O dicionário de palavras é formado por linhas com o seguinte formato :
  

  o "palavra [CAT=classe,(SEM|TR|G)=subclasse]". 

Por outro lado o dicionário de entidades é formado por linhas com o seguinte formato :
   
  o "ent [CAT=classe,SUB=subclasse,INF=inf]".
   



=head1 FICHEIRO DE TESTES

E<8>

O ficheiro de teste é constituido por 18 testes. Foi necessário testar algumas sub-rotinas auxiliares que foram criadas
tal como sub-rotinas principais do programa.

   
   
=head1 TESTAR O MÓDULO

E<8>
   
De modo a poder testar todas as funcionalidades do módulo ReconhecedorTexto, foi criado um ficheiro chamado main.pl para esse efeito.



=head1 OBJECTIVOS PROPOSTOS

E<8>

O enunciado do trabalho refere alguns requisitos que o módulo deverá ter. Vou enunciar cada um deles, e explicar como foi
implementado para cada um dos casos:

=over 12

=item I<Ser configurável através de classes de palavras como por exemplo preposicões, títulos, lugares, nomes próprios, apelidos, tempo, etc>

E<8>

O módulo pemite adicionar palavras/entidades dependendo de uma classe e sub-classe. Por exemplo, se quisesse adicionar o lugar "Braga", bastava
adicionar ao dicionário de entrada ou utilizar o método adicionar_entidade. 


=item I<Possibilitar o uso de estruturas de dados hierárquicas que relacionem palavras para melhorar o seu desempenho>


E<8>

É possível guardar entidades ou palavras nas estruturas referentes ao módulo. A estrutura destinada às palavras tem a seguinte organização:

o CLASSE  CLA 1 

E<8>

  oo SUB-CLASSE  SUB 1

E<8>  

    ooo ENTIDADE   E1  [INFORMAÇÃO RESPECTIVA A E1]

E<8>

E<8>

=item I<Ter formas de configurar heurísticas que possam ser utilizadas no reconhecimento de nomes e entidades>

E<8>

O módulo oferece dois métodos distintos para reconhecer entidades. Um usa as informações que estão presentes na 
estrutura, e basicamente percorre linha, a linha à procura de entidades. Por outro lado, também existe um método que apenas reconhece entidades
através de regex. Contudo, este não consegue detetar qualquer tipo de informação aliado a este. 
Para o reconhecimento de palavras, caso o utilizador tenha enviado um dicionário por argumento, o método irá procurar as palavras que estavam 
presentes neste.


=item I<Permitir definir novas entidades a serem reconhecidas e disponibilizar a forma de apresentá-las>

E<8>

O utilizador pode adicionar ao dicionário de entrada novas entidades ou criar novas entidades a executar o programa.


E<8>

=item I<Definir situações de excepção>



E<8>

Para o reconhecimento de entidades por regex foram criadas várias situações de excepção. Por exemplo, se acontecer um caso
onde ocorra uma frase semelhante a esta " O empresário Carlos Santos Silva", apenas fica "Carlos Santos Silva". Isto, devido ao filtro que 
foi implementado o qual elimina todos os conetores,verbos,advérbios,etc... que possam ocorrer no início, no meio e no  fim de entidades. Para além 
deste filtro é usado o método stopwords para filtrar ainda mais o input.


=item I<Disponibilizar ferramentas auxiliares como por exemplo formas de partir texto por frases e palavras>


E<8>

No momento de leitura do ficheiro de teste enviado por argumento, este é partido por linhas e depois por palavras.
Estes são guardados no objecto.


=back

=head1 MÉTODOS

E<8>

A API desenvolvida permite ter um completo conhecimento de como o módulo funciona. 

=over 12

   

=item I<new>

Retorna um objecto novo do tipo ReconhecedorTexto. Este é constituido por :
 
  o dicionario => {}, 
  o palavras => 0, 
  o texto => {},
  o linhas => {},
  o ficheiro => 'NR',
  o entidades => {},
  o lingua => 'pt'


=item I<adicionar_entidade_ao_dic>

Permite adicionar uma entidade ao programa. É necessário inserir a classe, subclasse e a entidade. 
Retorna "TRUE".

=item I<get_percentagem_total>

Mediante das classes presentes no dicionário, retorna para cada uma destas a percentagem total encontrada
no texto lido. Retorna uma array.

=item I<mudar_ling>

Caso queria mudar a lingua para o reconhecimento deve executar esta função. Por exemplo para Inglês envie 'eng'.
Tal funcionalidade é devido ao facto de estar a usar um módulo para eliminar as stopwords.

=item I<get_all_entidades_texto>

Retorna todas as entidades encontradas no programa que estão presentes no dicionário. Este método apenas
procura em cada linha  entidades que estejam inseridas no dic. Devolve um array.


=item I<get_tipos_entidades_de_dic>

Retorna a lista de entidades do dic em forma de array.

=item I<get_entidades_by_entidade_texto>

Retorna as entidades do texto lido dado uma categoria. Retorna uma hash.

=item I<adicionar_palavra_ao_dic>

Permite adicionar uma palavra ao dic, dada uma classe e subclasse.


=item I<get_palavras_DIC_by_sub_classe>

Retorna as palavras de uma classe e subclasse do dic.
Retorna um array.


=item I<get_palavras_texto_by_classe>

Retorna as palavras de uma dada classe do texto lido.
Retorna um array.

=item I<get_palavras_DIC_by_classe>

Retorna as palavras de uma dada classe do dic
Retorna um array.


=item I<save>

Permite guardar o objecto em memória


=item I<load>

Permite carregar um objecto que está guardado em memória

=back




=head1 CONCLUSÃO

E<8>

Em suma, foram implementadas neste módulo diversas funcionalidades. Caso o utilizador necessite de mudar de lingua pode fazê-lo,
basta alterar os dicionários de entrada. Com a organização do módulo, é muito fácil adicionar novas entidades, ou palavras no momento da execução do programa.
Posso concluir que o trabalho desenvolvido cumpriu com os requisitos propostos.

=head1 AUTHOR

Sérgio  Simões, E<lt>Perez_25@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Sérgio  Simões

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.



=cut
