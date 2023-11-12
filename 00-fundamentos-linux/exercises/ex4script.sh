#!/bin/bash

# Definir la URL de la página web
URL="https://kubernetes.io/"  # Reemplaza con la URL de la página web que desees

# Comprobar si se proporciona un parámetro
if [ $# -eq 0 ]; then
  echo "Uso: $0 palabra_a_buscar"
  exit 1
fi

# Descargar el contenido de la página web a un archivo temporal
TMP_FILE=$(mktemp)
wget -q -O "$TMP_FILE" "$URL"

# Buscar la palabra en el archivo descargado y contar su ocurrencia
PALABRA="$1"
OCCURRENCES=$(grep -o -i "$PALABRA" "$TMP_FILE" | wc -l)

# Mostrar el resultado
if [ "$OCCURRENCES" -eq 0 ]; then
  echo "No se ha encontrado la palabra \"$PALABRA\""
else
  echo "La palabra \"$PALABRA\" aparece $OCCURRENCES veces"
  LINE=$(grep -n -i "$PALABRA" "$TMP_FILE" | head -n 1 | cut -d: -f1)
  echo "Aparece por primera vez en la línea $LINE"
fi

# Eliminar el archivo temporal
rm -f "$TMP_FILE"

