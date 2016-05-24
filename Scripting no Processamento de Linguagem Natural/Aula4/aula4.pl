#  Escreva um programa (usando o operador de substitui ̧c ̃ao)
# que leia uma frase e para cada palavra coloque so a inicial seguida de um ponto, isto  ́e,
# para a frase viva o perl o programa imprima v. o. p.

use strict;

my @a;
my $word;

while(<>){
chomp;
@a = split;
foreach $word(@a){
  if($word=~ /^(((\w+(\.\w+)*)@(\w+(\.\w+)+)))$/){
    print $word."\n";
    }
  }
}



