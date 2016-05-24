
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
$obj = new ReconhecedorTexto("../dic/entidades.txt","../dic/pt-PT.dic");
$obj->read_texto("../ficheiros_de_teste/".$texto);
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

print " 1  - Ver classes do dicionário\n\n";
print " 2  - Devolver todas as entidades encontradas do texto lido por linha\n\n";
print " 3  - Devolver palavras do texto lido de certa classe\n\n";
print " 4  - Devolver entidades do texto lido de certa categoria\n\n";
print " 5  - Ver percentagem total por classe\n\n"; 
print " 6  - Ver entidades detectadas por regex\n\n";
print " 7  - Guardar \n\n";
print " 8  - Adicionar palavra de certa classe e subclasse ao dicionário\n\n";
print " 9  - Adicionar entidade de certa classe e subclasse ao dicionário\n\n";
print " 10 - Ler novo ficheiro\n\n";
print " 11 - Carregar \n\n";
print " 0  - Sair\n\n";

}

while ($opcao != 0) {
    menu();
    $opcao = <>;
    
       if($opcao == 1)  {  my @res = $obj->get_classes_DIC();
                foreach my $line(@res){
                    print $line."\n";
                    }
             print "Prima qualquer tecla : ";
             $_ = <>;
         }
         
        if($opcao == 2){
             my @res = $obj->get_all_entidades_texto();
             print @res; 
             print "Prima qualquer tecla : ";
             $_ = <>;  
        }
        if($opcao == 3){
             print "Insira a classe : ";
             my $classe = <>;
             my @res = $obj->get_palavras_texto_by_classe($classe);
             print @res;
             print "Prima qualquer tecla : ";
             $_ = <>;
        }
        if($opcao == 4){
          print "Insira a categoria : ";
          my $cat = <>;
          my %res = $obj->get_entidades_by_entidade_texto($cat);
          printHash(%res);
          print "Prima qualquer tecla : ";
          $_ = <>;
        }  
        
        if($opcao == 5){
             my @res = $obj->get_percentagem_total();
            print @res;
          print "Prima qualquer tecla : ";
             $_ = <>;
        }
        
        
        
        if($opcao == 6){
         my @res = $obj-> get_entides_by_regex();
         print "Possiveis entidades : \n ";
         print @res;
         print "Prima qualquer tecla : ";
         $_ = <>;
        }
        
        if($opcao == 8){
         print "Insira a classe : ";
         my $classe = <>;
         print "Insira a subclasse : ";
         my $subclasse = <>;
         print "Insira a palavra : ";
         my $palavra = <>;
        
        $obj->adicionar_palavra_ao_dic($palavra,$classe,$subclasse);
        print "Prima qualquer tecla : ";
        $_ = <>;
        }
        
        if($opcao == 9){
         print "Insira a classe : ";
         my $classe = <>;
         print "Insira a subclasse : ";
         my $subclasse = <>;
         print "Insira a entidade : ";
         my $palavra = <>;
         print "Insira a info : ";
         my $inf = <>;
         $obj->adicionar_entidade_ao_dic($palavra,$classe,$subclasse,$inf);
         print "Prima qualquer tecla : ";
         $_ = <>;
        }
        
        if($opcao == 10){
        print "Insira o novo ficheiro : ";
        my $file = <>;
        $obj = new ReconhecedorTexto("../dic/entidades.txt","../dic/pt-PT.dic");
        $obj->read_texto("../ficheiros_de_teste/".$file);
        print "Prima qualquer tecla : ";
        $_ = <>;
        }
        
        if($opcao == 7){
        print "Nome do ficheiro :";
        my $file = <>;
        $obj->save($file);
        print "Prima qualquer tecla : ";
        $_ = <>;
        }
        
        if($opcao == 11){
         print "Nome do ficheiro :";
        my $file = <>;
            $obj->load($file);
             print "Prima qualquer tecla : ";
        $_ = <>;
        }
        
        
        print "\n\n";
  }












