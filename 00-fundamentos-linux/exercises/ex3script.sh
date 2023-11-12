#!/bin/bash

# Confirmar si ./foo/dummy existe, si no existe, crearlo
if [ ! -d "./foo/dummy" ]; then
    mkdir -p "./foo/dummy"
fi

# Confirmar si ./foo/empty existe, si no existe, crearlo
if [ ! -d "./foo/empty" ]; then
    mkdir -p "./foo/empty"
fi

# Comprobar si se proporcionó un parámetro o usar el texto por defecto
if [ -z "$1" ]; then
    texto="Que me gusta la bash!!!!"
else
    texto="$1"
fi

# Guardar el texto en file1.txt
echo "$texto" > ./foo/dummy/file1.txt

# Volcar el contenido de file1.txt en file2.txt
cat ./foo/dummy/file1.txt > ./foo/empty/file2.txt


echo "Proceso completado."

