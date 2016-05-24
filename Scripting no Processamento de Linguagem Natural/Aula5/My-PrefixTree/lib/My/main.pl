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
  my $option = -1;

while($option != 0){
  print "\n     |PrefixTree MODULE|   \n\n\n";
  print " 1 - adicionar palavra\n";
  print " 2 - remover palavra\n";
  print " 3 - adicionar ficheiro\n";
  print " 4 - testar se palavra existe\n";
  print " 5 - printDumper\n";
  print " 6 - Guardar ficheiro\n";
  print " 7 - Carregar ficheiro\n";
  print " 0 - Sair\n";

  $option = <>;

  if($option == 1){
    print "Adicione a palavra : ";
    my $word = <>;
    $obj->add_word($word);
  }
  if($option == 2){
    print "Adicione a palavra : ";
    my $word = <>;
    print $obj->rem_word($word);
  }


  if($option == 3){
    print "Adicione o ficheiro : ";
    my $word = <>;
    $obj->add_dict($word);
  }

  if($option == 4){
    print "Adicione a palavra : ";
    my $word = <>;
    print $obj->rem_word($word);
  }

  if($option == 5){
    print Dumper($obj);
  }
  if($option == 6){
  print "Adicione o ficheiro : ";
   my $file = <>;
   $obj->save($file);
  }

  if($option == 7){
  print "Adicione o ficheiro : ";
  my $file = <>;
  $obj =  $obj->load($file);
  }
}





