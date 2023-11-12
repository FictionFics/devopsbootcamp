## Eliminar todos los contenedores que tienes ejecutándose en tu máquina.

```
docker stop $(docker ps -a -q)                                                                                                                                                  ok | took 3m 51s | at 17:36:47
docker rm $(docker ps -a -q)

d879ee7902dd
9374c2c3e396
d879ee7902dd
9374c2c3e396
```