# vocabulary_test.pl
## Uso
```
 vocabulary_test,pl [opciones] [fichero]
```

```
 vocabulary_test,pl -h
```


## Descripción
Realiza un test interactivo y de los grupos de palabras que están en 
el fichero.

fichero es un archivo tsv en el que la primera columna están las 
preguntas en un idioma y en la segunda en el otro idioma.


## Opciones
### -h
Muestra esta ayuda.


### -i
Realiza el test inverso, preguntando l


### -n cantidad
Indica la cantidad de preguntas que tendrá el test.

Por defecto es 10.



## Fichero de vocabulario
Es un [fichero tsv](https://en.wikipedia.org/wiki/Tab-separated_values) 
formado por dos columnas.

En la primera columna están las preguntas y en la segunda las respuestas.

Preguntas y respuestas se intercambian si se utiliza la opción -i.

El texto que se ponga entre paréntesis en la respuesta no se utiliza 
para comprobar la respuesta, tan sólo aparece cuando se pregunta.

Cuando una pregunta tiene varias posibles respuestas se separan con 
la barra inclinada (/).


## Pendiente
*  Guardar los logs de funcionamiento
*  Añadir usuario (para los logs)
*  Limitar las palabras repetidas por test
*  Hacer un test con todas las palabras del fichero
*  Generar un nuevo fichero con los errores que hay en el log
*  Permitir la entrada de nuevo de palabra errónea para reforzar.



