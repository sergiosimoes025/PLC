
use Data::Dumper;

sub max_ilegivel {
    ($_[0] > $_[1])?$_[0] : $_[1];
}
sub max1 {
    #o shift retorna a 1º posição do array e tira o da lista
    my $x = shift;
    my $y = shift;
    ($x > $y) ? $x : $y;
}
sub max2 {
    my($x, $y) = @_;
    ($x > $y) ? $x : $y;
}


#REFERENCIAS

# Um scalar pode armazenar uma referência para uma variável.
# Uma referência é a posição interna no programa em Perl, onde uma variável se encontra.
# Dessa forma, uma referência "aponta" para uma variável. Assim:

$a = "oi";
$b = \$a;

print "$b\n";

%idade = (
      Carlos => 26,
      Amanda => 21
      );

@nomes = ('Carlos', 'Joao', 'Amanda');

$a = \%idade;
$b = \@nomes;
$c = \$idade{Carlos};
$d = \$nomes[1];

print "@$b\n";


@telefones_do_Carlos=('55-5555','911-3456','33-2323');
$telefone{Carlos} = \@telefones_do_Carlos;

$ref = \%telefone;

print $$ref{Carlos}[1]."\n";

print $telefone{Carlos}[0];


sub potencia {
    my %args = @_;
    return "Falta a base" unless exists $args{base};
    $args{expoente} = 1 unless exists $args{expoente};
    $args{base} ** $args{expoente};
}


@_ = (base => 2, expoente => 3);
$x = potencia;
$y = potencia(); # Esta invocacao e a anterior sao equivalentes
$z = &potencia; # Neste caso, a invocacao esta a usar o @_ deste nivel
$w = potencia(base => 7);
print "$x\n$y\n$z\n$w\n";




$bd = {100 => {nome => 'rui', gostos => [ler, programar, puzzles, jogos]}, 101 => {nome =>'alberto',
 gostos => [ler, programar,dormir, comer]}};
print Dumper($bd);

