## Crea una red llamada lemoncode.

```
docker network create lemoncode
```

## Crea dos contenedores dentro de la red. Uno de ellos con nginx, llamado nginx-container, y otro con ubuntu, llamado ubuntu-container

```
docker run -d --name nginx-container --network lemoncode nginx
docker run -dit --name ubuntu-container --network lemoncode ubuntu
```

## Intenta acceder a la web que está sirviendo el contenedor nginx desde ubuntu-container través del nombre.

```
docker exec -it ubuntu-container /bin/bash
ping nginx-container
```
```
root@b4bd281b2325:/# curl nginx-container
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html> 
```