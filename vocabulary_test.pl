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

	* Fichero de vocabulario
		Es un [[https://en.wikipedia.org/wiki/Tab-separated_values fichero tsv]] 
		formado por dos columnas.

		En la primera columna están las preguntas y en la segunda las respuestas.

		Preguntas y respuestas se intercambian si se utiliza la opción -i.

		El texto que se ponga entre paréntesis en la respuesta no se utiliza 
		para comprobar la respuesta, tan sólo aparece cuando se pregunta.

		Cuando una pregunta tiene varias posibles respuestas se separan con 
		la barra inclinada (/).
	* Pendiente
		- Guardar los logs de funcionamiento
		- Añadir usuario (para los logs)
		- Limitar las palabras repetidas por test
		- Hacer un test con todas las palabras del fichero
		- Generar un nuevo fichero con los errores que hay en el log
		- Permitir la entrada de nuevo de palabra errónea para reforzar.
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
	if($pregunta_final =~/\//) {
		my @preguntas_finales=split " *\/ *", $pregunta_final;
		$pregunta_final=$preguntas_finales[int(rand($#preguntas_finales+1))];
	}

	my $n=$i+1;
	print STDERR "$n. $pregunta_final: ";
	my $contestacion=<STDIN>;
	chomp $contestacion;

	my $palabra='ERROR';
	foreach $posible (split " *\/ *", $respuesta_final) {
		if($contestacion eq $posible) {
			$palabra="OK";
		}
	}
	if($palabra eq 'OK' ) {
		$nota++;	
		print STDERR "\tCorrecto\n";
	} else {
		print STDERR "\tError. La traducción de «$pregunta_final» es «$respuesta_final».\n";
	}
	$informe.="\t$palabra\t$pregunta\t$respuesta\n";
}
print STDERR "Nota: $nota/$num\n";
print $informe;
