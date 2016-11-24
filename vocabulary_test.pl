#!/usr/bin/perl -w

my $num=10;
my $sentido='directo';
my $nota=0;

#-------------------------------------------------------------------------------
sub help{
#-------------------------------------------------------------------------------
	print "* vocabulary_test.pl
	* Uso
		> vocabulary_test,pl [opciones] [fichero]
		> vocabulary_test,pl -h

	* Descripción
		Realiza un test interactivo y de los grupos de palabras que están en 
		el fichero.

		fichero es un archivo tsv en el que la primera columna están las 
		preguntas en un idioma y en la segunda en el otro idioma.

	* Opciones
		* -h
			Muestra esta ayuda.
		* -i
			Realiza el test inverso, preguntando l
		* -n cantidad
			Indica la cantidad de preguntas que tendrá el test.

			Por defecto es $num.
	";
}
#-------------------------------------------------------------------------------
if( @ARGV >0 && $ARGV[0] eq "-h"){ help; exit 0; }
#-------------------------------------------------------------------------------

while( @ARGV >0 && $ARGV[0] =~/^-/) {
	if( $ARGV[0] eq "-i") { 
		$sentido="inverso";
		shift;
	}
	if( $ARGV[0] eq "-n") { 
		$num=$ARGV[1];
		shift;shift;
	}
}

#
# main
#
@lineas=<>;
chomp @lineas;
s/\r// for  @lineas;
my $informe='';

for(my $i=0; $i<$num; $i++) {
	$posicion=int(rand($#lineas+1));

	my ($pregunta, $respuesta) = split "\t", $lineas[$posicion];
	my ($pregunta_final, $respuesta_final)=($pregunta, $respuesta);
	if($sentido eq 'inverso') {
		$pregunta_final = $respuesta;
		$respuesta_final = $pregunta;
	}
	$respuesta_final=~s/ *\([^\)]*\) *//;

	my $n=$i+1;
	print STDERR "$n. ¿$pregunta_final?\n";
	my $contestacion=<STDIN>;
	chomp $contestacion;

	my $palabra='';
	if($contestacion eq $respuesta_final) {
		$nota++;	
		print STDERR "\tCorrecto\n";
		$palabra="OK";
	} else {
		print STDERR "\tError. La traducción de «$pregunta_final» es «$respuesta_final».\n";
		$palabra="ERROR";
	}
	$informe.="\t$palabra\t$pregunta\t$respuesta\n";
}
print STDERR "Nota: $nota/$num\n";
print $informe;
