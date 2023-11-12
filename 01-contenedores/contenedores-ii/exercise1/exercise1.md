## Crea una imagen con un servidor web Apache y el mismo contenido que en la carpeta content. Fíjate en el Dockerfile que cree simple-nginx. Usa docker build para crear la imagen llamada simple-apache:new

```
docker build . -f ./Dockerfile -t simple-apache:v1
docker tag simple-apache:v1 fictionfics/simple-apache:v1
docker push fictionfics/simple-apache:v1
```