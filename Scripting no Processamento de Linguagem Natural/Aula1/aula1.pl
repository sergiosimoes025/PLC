#1. Escreva um programa que leia um texto e numere as linhas, isto  ́e,
#que imprima cada linha precedida do no de linha correspondente;

 use strict;
 use warnings;
 use 5.010;
# my $linhas = 0;
# # Ler uma linha de cada vez
# while(<>) { # Repare que a leitura usa a variavel por omissao $_
#     $linhas = $linhas + 1;
#     #print;
#     print $linhas." : ";
#     print;
# }


#---------------------------------------------------------------------------------------------------#
#2.Escreva um programa que leia um texto e o escreva, substituindo as vogais por asteriscos;

# while(<>){
#     y/aeiou/*/;
#     print;
# }

#---------------------------------------------------------------------------------------------------#
# 3. Escreva um programa que leia um texto e o escreva em maiusculas;

# while(<>){
#   $_ = uc($_);
#   print $_;
# }


#---------------------------------------------------------------------------------------------------#
# 4. Escreva um programa que leia uma frase e a escreva colocando a primeira letra em maiu ́sculas;

# while(<>){
#     $_ = ucfirst($_);
#     print $_;
# }


#---------------------------------------------------------------------------------------------------#
# 5. Escreva um programa que leia um texto e que conte o nu ́mero de linhas que cont ́em a palavra ”linguagem”;
# my $linhas = 0;

#  while(<>){
#   print if /linguagem/;
#  }


#---------------------------------------------------------------------------------------------------#
# 6. Escreva um programa que leia um texto e conte o nu ́mero de ocorrˆencias de cada vogal;

# my $a = 0;
# my $e = 0;
# my $i = 0;
# my $o = 0;
# my $u = 0;

# while(<>){
#  if(/a/){
#   $a++;
#  }
#  if(/e/){
#   $e++;
#  }
#  if(/i/){
#   $i++;
#  }
#   if(/o/){
#   $o++;
#  }

#  if(/u/){
#   $u++;
#  }
# }
# print $a . " " . $e . " " . $i . " " .$o. " " .$u. " ";


#---------------------------------------------------------------------------------------------------#
# 7. Escreva um programa que leia um texto e imprima cada frase ao contr ́ario;
# my $string;

# while(<>){
#  $string = reverse($_);
#  print $string;
# }

#---------------------------------------------------------------------------------------------------#
# 8. Escreva um programa que leia um texto em que cada linha
# é um nome de uma pessoa e que escreva o primeiro nome,
# as iniciais de cada nome interm ́edio e o u ́ltimo nome
# (por exemplo, se o nome fosse M ́ario Alberto Nobre Lopes Soares deveria escrever M ́ario A. N. L. Soares);

# while(<>){
#   my $size = 0;
#   my $i = 1;
#   my @tokens = split / /, $_;

#   $size = @tokens;
#   print @tokens[0]." ";

#   while($i<$size-1){
#     print substr(@tokens[$i],0,1).". ";
#     $i++;
#   }
#   print @tokens[-1]."\n";

# }

#---------------------------------------------------------------------------------------------------#
# 9. Escreva um programa que leia um texto e
# conte o no de ocorrˆencias de scripting, linguagem,
# processamento, processamento de linguagem e linguagem natural;

# my %data = ('scripting' => 0, 'linguagem' => 0 , 'processamento' => 0 ,
#  'processamento de linguagem' => 0 ,'linguagem natural' =>0);

# while(<>){
#   if(/scripting/){
#    $data{'scripting'}++;
#   }

#   if(/linguagem/){
#   $data{'linguagem'}++;
#   }

#   if(/processamento/){
#   $data{'processamento'}++;
#   }

#   if(/processamento de linguagem/){
#   $data{'processamento de linguagem'}++;
#   }

#   if(/linguagem natural/){
#     $data{'linguagem natural'}++;
#   }

# }
#   print %data;



