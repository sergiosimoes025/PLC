use strict;
use warnings;

my %hash;
my @lista;
my $string;

while (<>) {
    chomp;

    s/[^a-z]/ /gi;
    @lista = split;


      foreach $string (@lista){
      $string =  lc($string);
      if(exists($hash{"$string"})){
                 $hash{"$string"}++;
        }
       else {
         $hash{"$string"} = 1;
       }
    }
}



my @keys = sort { $hash{$b} <=> $hash{$a} or $a cmp $b}   keys(%hash);

my $key;

foreach $key (@keys){
  print "$key\t$hash{$key}\n";
}

