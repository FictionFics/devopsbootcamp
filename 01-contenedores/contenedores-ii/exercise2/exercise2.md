## Ejecutar tu nueva imagen, El contenedor se debe llamar my_apache, Debes usar el puerto 5050 de tu localhost para poder acceder a él.


```
docker run -d --name my_apache -p 5050:80 fictionfics/simple-apache:v1
```
```
lemoncodeuser@MacBook-Pro-6 exercise1 % docker ps
CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS         PORTS                  NAMES
b75550953e54   fictionfics/simple-apache:v1   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:5050->80/tcp   my_apache
```
```
lemoncodeuser@MacBook-Pro-6 exercise1 % docker history b242bc992105
IMAGE          CREATED         CREATED BY                                      SIZE      COMMENT
b242bc992105   5 minutes ago   COPY content/ /usr/local/apache2/htdocs # bu…   327B      buildkit.dockerfile.v0
<missing>      5 minutes ago   EXPOSE map[5050/tcp:{}]                         0B        buildkit.dockerfile.v0
<missing>      5 minutes ago   LABEL project=Testing                           0B        buildkit.dockerfile.v0
<missing>      5 minutes ago   LABEL maintainer=salvador.penamedina@4everte…   0B        buildkit.dockerfile.v0
<missing>      2 weeks ago     /bin/sh -c #(nop)  CMD ["httpd-foreground"]     0B        
<missing>      2 weeks ago     /bin/sh -c #(nop)  EXPOSE 80                    0B        
<missing>      2 weeks ago     /bin/sh -c #(nop) COPY file:c432ff61c4993ecd…   138B      
<missing>      2 weeks ago     /bin/sh -c #(nop)  STOPSIGNAL SIGWINCH          0B        
<missing>      2 weeks ago     /bin/sh -c set -eux;   apk add --no-cache --…   22MB      
<missing>      2 weeks ago     /bin/sh -c #(nop)  ENV HTTPD_PATCHES=           0B        
<missing>      2 weeks ago     /bin/sh -c #(nop)  ENV HTTPD_SHA256=fa16d72a…   0B        
<missing>      2 weeks ago     /bin/sh -c #(nop)  ENV HTTPD_VERSION=2.4.58     0B        
<missing>      2 weeks ago     /bin/sh -c set -eux;  apk add --no-cache   a…   39.5MB    
<missing>      2 weeks ago     /bin/sh -c #(nop) WORKDIR /usr/local/apache2    0B        
<missing>      2 weeks ago     /bin/sh -c mkdir -p "$HTTPD_PREFIX"  && chow…   0B        
<missing>      2 weeks ago     /bin/sh -c #(nop)  ENV PATH=/usr/local/apach…   0B        
<missing>      2 weeks ago     /bin/sh -c #(nop)  ENV HTTPD_PREFIX=/usr/loc…   0B        
<missing>      2 weeks ago     /bin/sh -c set -x  && adduser -u 82 -D -S -G…   4.68kB    
<missing>      5 weeks ago     /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B        
<missing>      5 weeks ago     /bin/sh -c #(nop) ADD file:ff3112828967e8004…   7.66MB 
```