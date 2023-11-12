## Crea un contenedor con MongoDB, protegido por usuario y contraseña.

```
docker run -d -p 9999:80 --name lemoncoders-web nginx
```
```
sudo docker ps                                                                                                                                              
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                      NAMES
d879ee7902dd   nginx     "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:9999->80/tcp       lemoncoders-web
9374c2c3e396   mongo     "docker-entrypoint.s…"   10 minutes ago       Up 10 minutes       0.0.0.0:27017->27017/tcp   mongodb-container
```
## Copia el contenido de la carpeta lemoncoders-web de la unidad en la ruta que sirve este servidor.
```
sudo docker cp Documents/Lemoncoderepo/bootcamp-devops-lemoncode/01-contenedores/contenedores-i/lemoncoders-web/index.html lemoncoders-web:/usr/share/nginx/html

sudo docker cp Documents/Lemoncoderepo/bootcamp-devops-lemoncode/01-contenedores/contenedores-i/lemoncoders-web/styles.css lemoncoders-web:/usr/share/nginx/html
```
## Ejecuta ls desde fuera para ver que el contenido se ha copiado correctamente.

```
sudo docker exec lemoncoders-web ls /usr/share/nginx/html

50x.html
index.html
styles.css
```