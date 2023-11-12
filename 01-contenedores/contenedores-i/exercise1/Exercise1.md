## Crea un contenedor con MongoDB, protegido por usuario y contraseña.

```
sudo docker run -d --name mongodb-container -p 27017:27017 \
>   -e MONGO_INITDB_ROOT_USERNAME=admin \
>   -e MONGO_INITDB_ROOT_PASSWORD=secretpassword \
>   mongo
```
```
sudo docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                           NAMES
d3d727f34a81   mongo     "docker-entrypoint.s…"   30 seconds ago   Up 16 seconds   0.0.0.0:27017->27017/tcp, :::27017->27017/tcp   mongodb-container
```