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



## Pendiente
*  Guardar los logs de funcionamiento
*  Añadir usuario (para los logs)
*  Permitir varias respuestas
*  Limitar las palabras repetidas por test
*  Hacer un test con todas las palabras del fichero
*  Generar un nuevo fichero con los errores que hay en el log
*  Permitir la entrada de nuevo de palabra errónea para reforzar.



