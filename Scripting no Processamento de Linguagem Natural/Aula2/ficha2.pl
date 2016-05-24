# 1 Escreva um programa que leia uma frase e
#imprima a mesma com todas as palavras começadas por uma letra maiúscula;

#  use strict;
#  use warnings;
#  use 5.010;

# my $linha = <>;
# my @lista = split / /, $linha;
# my $a;

# foreach $a (@lista){
#   $a = ucfirst($a);
# }

# print "$_\n" for @lista;

#-------------------------------------------------------------------------------#


#Escreva um programa que imprima todos os nu ́meros entre 1 e 1000 que n ̃ao sejam divis ́ıveis por 5 nem por 7

# my $i = 1;

# while($i<=1000){
#   if(!($i%5) || !($i%7)){
#     print "$i\n";
#   }
#   $i++;
# }


#Escreva um programa que funcione de forma semelhante ao wc, i.e.,
#leia um texto e conte o nu ́mero de carateres, de palavras e de linhas;

# my $chars = 0;
# my $linhas = 0;
# my $words = 0;


# while(<>){
# $linhas++;
# $chars += length($_);
# $words += scalar(split(/\s+/, $_));

# }
# print("lines=$linhas words=$words chars=$chars\n");

# #-------------------------------------------------------------------------------#
# Escreva um programa que leia um texto e imprima todas as palavras do texto e o número de
# vezes que essa palavra aparece no texto;

# my %words;
# my @lista;
# my $a;
# while(<>){

# @lista = split(/\s+|[^A-Za-z]/,$_);

# foreach $a (@lista){
#     $words{"$a"}++;
#     }
#   }

# foreach $a (keys %words){
#   print "$a -> $words{$a}\n";
# }

# #-------------------------------------------------------------------------------#

# Escreva um programa que conte a frequência de cada letra e que seguidamente imprima a letra
#  e a frequˆencia por ordem decrescente de frequências;

# my %letters;
# my @lista;
# my $a;

# while(<>){
#   @lista = split(//,$_);
#   foreach $a(@lista){

#     $words{"$a"}++;
#   }
# }

# foreach $a (keys %words){
#   print "$a -> $words{$a}\n";
# }

# # #-------------------------------------------------------------------------------#
# Escreva um programa que leia uma frase de cada vez e que imprima as
# palavras que existem nessa frase por ordem alfab ́etica (i.e., sem repetir as palavras);

# my @lista;
# my $a;
# while(<>){

# @lista = split(/ /,$_);
# @lista = sort (@lista);
# foreach $a(@lista){
#     print "$a\n";
#    }

# }
# Escreva um programa que seja um filtro que remove linhas duplicadas de um conjunto de ficheiros
# (i.e., ele imprime todas as linhas dos ficheiros sem duplicados);

# my @lista;
# my $a;
# while(<>){
# push(@lista,$_);

# foreach $a(@lista){
#   if(($a cmp $_) == 0){
#     push(@lista,$_);
#     }
#   }
# }

