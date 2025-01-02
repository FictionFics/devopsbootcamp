# Distributed Infrastructure
Para este ejercicio práctico he creado tres carpetas, `todo-api`, `todo-front` e `ingress` Para completar los pasos 1, 2 y 3, en este README podéis encontrar las respuestas directamente sin los enunciados. He decidido usar las imágenes de docker porque ya estaban creadas.

> Nota: He podido confirmar en el enunciado del ejercicio que las imágenes de docker están inversas, en el paso uno, como nota, aparece la docker image de api cuando estás instalando el front y viceversa, en el paso 2 aparece la docker image de front cuando estás preparando la api. 

### Respuesta Paso 1:
- Accedemos a la carpeta `todo-front`:
```
cd 02-orquestadores/entrega_orquestación/02-distributed/todo-front
```
- Aplicamos los yaml:
```
kubectl apply -f deployment-front.yaml
```
```
kubectl apply -f clusterIp-front.yaml  
```
- Confirmamos la creación de todos los recursos:
```
NAME                              READY   STATUS    RESTARTS   AGE
pod/todo-front-79876d4946-dpjd8   1/1     Running   0          110s
pod/todo-front-79876d4946-sst9q   1/1     Running   0          110s

NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
service/kubernetes           ClusterIP   10.96.0.1        <none>        443/TCP   72d
service/todo-front-service   ClusterIP   10.106.180.215   <none>        80/TCP    102s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/todo-front   2/2     2            2           110s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/todo-front-79876d4946   2         2         2       110s
```

### Respuesta Paso 2:

- Accedemos a la carpeta `todo-api`:
```
cd 02-orquestadores/entrega_orquestación/02-distributed/todo-api
```
- Aplicamos los yaml:
```
kubectl apply -f configMap.yaml
```
```
kubectl apply -f deployment-api.yaml  
```
```
kubectl apply -f clusterIp-api.yaml
```
- Confirmamos la creación de todos los recursos:
```
kubectl get all
```
```
NAME                              READY   STATUS    RESTARTS   AGE
pod/todo-api-67d84cd4b9-76dcs     1/1     Running   0          64s
pod/todo-api-67d84cd4b9-hwlhq     1/1     Running   0          64s
pod/todo-front-79876d4946-dpjd8   1/1     Running   0          5m48s
pod/todo-front-79876d4946-sst9q   1/1     Running   0          5m48s

NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/kubernetes           ClusterIP   10.96.0.1        <none>        443/TCP    72d
service/todo-api-service     ClusterIP   10.102.195.145   <none>        3000/TCP   59s
service/todo-front-service   ClusterIP   10.106.180.215   <none>        80/TCP     5m40s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/todo-api     2/2     2            2           64s
deployment.apps/todo-front   2/2     2            2           5m48s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/todo-api-67d84cd4b9     2         2         2       64s
replicaset.apps/todo-front-79876d4946   2         2         2       5m48s
```
```
kubectl get cm
```
```
NAME               DATA   AGE
kube-root-ca.crt   1      72d
todo-api-config    2      90s
```
### Respuesta Paso 3:

- Añadimos el addon de ingress para nuestro minikube:
```
minikube addons enable ingress
```
- Confirmamos la creación del ingress en minikube cluster:
```
kubectl get pods -n 
```
```
NAME                                       READY   STATUS      RESTARTS      AGE
ingress-nginx-admission-create-dw7xh       0/1     Completed   0             72d
ingress-nginx-admission-patch-8vnqb        0/1     Completed   1             72d
ingress-nginx-controller-bc57996ff-rj5wn   1/1     Running     4 (11h ago)   72d
```
- Creamos un tunnel con minkube para que funcione correctamente el ingress:
```
minikube tunnel
```
- Accedemos a la carpeta `ingress`:
```
cd 02-orquestadores/entrega_orquestación/02-distributed/ingress
```
- Aplicamos el yaml:
```
kubectl apply -f ingress.yaml
```
- Confirmamos la creación del recurso:
```
kubectl get ing 
```
```
NAME               CLASS   HOSTS            ADDRESS        PORTS   AGE
todo-app-ingress   nginx   todo-app.local   192.168.49.2   80      11h
```
- Ahora solo tenemos que testear nuestro ingress:
```
curl --resolve "todo-app.local:80:127.0.0.1" -i http://todo-app.local/api
```
```
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Error</title>
</head>
<body>
<pre>Cannot GET /</pre>
</body>
</html>
```
```
curl --resolve "todo-app.local:80:127.0.0.1" -i http://todo-app.local
```
```
HTTP/1.1 200 OK
Date: Thu, 02 Jan 2025 06:17:36 GMT
Content-Type: text/html
Content-Length: 377
Connection: keep-alive
Last-Modified: Tue, 26 Nov 2024 19:17:41 GMT
ETag: "67461ed5-179"
Accept-Ranges: bytes

<!doctype html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Document</title><script defer="defer" src="app.8f643352660e61a72f8f.js"></script><script defer="defer" src="appStyles.81bfdf260f32b489a47b.js"></script><link href="appStyles.css" rel="stylesheet"></head><body><div id="root"></div></body></html>%
```