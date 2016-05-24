
use 5.016002;
use strict;
use warnings;
require Exporter;
use ReconhecedorTexto;
use Data::Dumper;
use Switch;

my $obj;
my $nb;
if(@ARGV){
my $texto = shift;
$obj = new ReconhecedorTexto();
$obj->read_texto($texto);
}

else {
$obj = new ReconhecedorTexto();
}

my $opcao = -1;


sub printHash {
my %hash = @_;
my $ref = \%hash;
foreach my $cat (keys %hash) {
   print "SUB - CATEGORIA $cat: \n";
    foreach my $value(keys $ref->{$cat}){
            print " o $value - ";
        foreach my $value2 (keys $ref->{$cat}->{$value}){
          print " $value2\n";
            }
        }
    }
}

sub menu{

print "\t\t========================================\n";
print "\t\t          RECONHECEDOR DE TEXTO\n";
print "\t\t========================================\n\n\n";

print " 1 - Ver classes do dicionário\n\n";
print " 2 - Ver subclasses de classe do dicionário\n\n";
print " 3 - Devolver palavras do texto lido de certa classe\n\n";
print " 4 - Devolver entidades do texto lido de certa categoria\n\n";
print " 5 - Ver tipos de entidades do dicionário\n\n";
print " 6 - Devolver palavras do dicionário de uma certa classe e subclasse\n\n";
print " 7 - Adicionar palavra de certa classe e subclasse ao dicionário\n\n"; 


}

while ($opcao != 0) {
    menu();
    $opcao = <>;
    
       if($opcao == 1)  {  my @res = $obj->get_classes_DIC();
                foreach my $line(@res){
                    print $line."\n";
                    }
         }
         
        if($opcao == 2){
                print "Insira a classe : ";
                my $classe = <>;
                  print "Insira a subclasse : ";
                my $subclasse = <>;
               
                my @res = $obj->get_palavras_DIC_by_sub_classe($classe,$subclasse);
                foreach my $line(@res){
                print $line."\n";
                }
        }
        if($opcao == 3){
             print "Insira a classe : ";
             my $classe = <>;
             my @res = $obj->get_palavras_texto_by_classe($classe);
             foreach my $line(@res){
                print $line."\n";
            }
        }
        if($opcao == 4){
          print "Insira a categoria : ";
          my $cat = <>;
          my %res = $obj->get_entidades_by_entidade_texto($cat);
          printHash(%res);
        }  
        
        if($opcao == 5){
          my @res = $obj->get_tipos_entidades_de_dic();
          foreach my $line(@res){
                print $line."\n";
            }
        }
        if($opcao == 6){
         print "Insira a classe : ";
         my $classe = <>;
         print "Insira a subclasse : ";
         my $subclasse = <>;
         my @res = $obj->get_palavras_DIC_by_sub_classe($classe,$subclasse);
         foreach my $line(@res){
                print $line."\n";
            }
        }
        
        if($opcao == 7){
         print "Insira a classe : ";
         my $classe = <>;
         print "Insira a subclasse : ";
         my $subclasse = <>;
         print "Insira a palavra : ";
         my $palavra = <>;
        
        print $obj->adicionar_palavra_ao_dic($palavra,$classe,$subclasse);
        
        }
        print "\n\n";
  }












