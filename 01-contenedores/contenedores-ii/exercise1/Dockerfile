#Imagen que voy a utilizar como base
FROM httpd:alpine

#Etiquetado
LABEL maintainer="salvador.penamedina@4evertechie.tech"
LABEL project="Testing"

#Como metadato, indicamos que el contenedor utiliza el puerto 80
EXPOSE 5050

#Modificaciones sobre la imagen que he utilizado como base, en este caso alpine
COPY content/ /usr/local/apache2/htdocs