package lista_telefonica.pm;

sub new {
my $invoca = shift;
my $class = ref($invoca) || $invoca;

#Inicializando os campos do objecto
my $self = {
  ANO => 1000,
  FICHEIRO => "lista_telefonica",
  lista_telefones => undef,
  @_,
  };
bless($self,$class);

le_lista_telefonica($self->{FICHEIRO});
}


sub ano{
  my $self = shift;
  if(@_) { $self->{ANO} = shift }
    return $self->{ANO};
}

sub ficheiro {
  my $self = shift;
  if(@_) { $self->{FICHEIRO} = shift}
  return $self->{FICHEIRO};
}

sub escreve_lista_telefonica{
  my $self = shift;

  if(open (LISTA_TEL,"> " . $self->ficheiro())){
    foreach $nome(keys %lista_telefones){
      $telefone = $lista_telefones{$nome};
      print LISTA_TEL "$nome\n";
      print LISTA_TEL "$telefone\n";
    }
  close(LISTA_TEL);
  }
  else {
    print "\n ERRO :!";
  }
}


