#!/bin/bash

# Verificar que se proporcionen dos parámetros
if [ $# -ne 2 ]; then
  echo "Se necesitan únicamente dos parámetros para ejecutar este script"
  exit 1
fi

# Obtener la URL y la palabra a buscar de los parámetros
URL="$1"
PALABRA="$2"

# Descargar el contenido de la página web a un archivo temporal
TMP_FILE=$(mktemp)
wget -q -O "$TMP_FILE" "$URL"

# Buscar la palabra en el archivo descargado y contar su ocurrencia
OCCURRENCES=$(grep -o -i "$PALABRA" "$TMP_FILE" | wc -l)

# Mostrar el resultado
if [ "$OCCURRENCES" -eq 0 ]; then
  echo "No se ha encontrado la palabra \"$PALABRA\""
else
  echo "La palabra \"$PALABRA\" aparece $OCCURRENCES veces"
  LINE=$(grep -n -i "$PALABRA" "$TMP_FILE" | head -n 1 | cut -d: -f1)
  if [ "$OCCURRENCES" -eq 1 ]; then
    echo "Aparece únicamente en la línea $LINE"
  else
    echo "Aparece por primera vez en la línea $LINE"
  fi
fi

# Eliminar el archivo temporal
rm -f "$TMP_FILE"

