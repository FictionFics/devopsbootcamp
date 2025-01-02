# Monolito en memoria
En este ejercicio, he decidido ejecutar directamente el deploy sin crear si quiera un yaml, ya que lo que se pedía en el, por lo que yo he entendido, era bastante sencillito. 

### Respuesta Paso 1:
```
kubectl create deployment todo-app --image=lemoncodersbc/lc-todo-monolith:v5-2024
```
```
NAME                        READY   STATUS    RESTARTS   AGE
todo-app-676588cccb-7947s   1/1     Running   0          7s
```

### Respuesta Paso 2 (basada en minikube):
- Crear Tunnel para minikube
```
minikube tunnel
```
- Exponer el servicio en el puerto 3000
```
kubectl expose deployment todo-app --type=LoadBalancer --port=3000
```
- Confirmar que se ha creado el svc
```
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP      10.96.0.1       <none>        443/TCP          71d
todo-app     LoadBalancer   10.100.18.154   127.0.0.1     3000:32568/TCP   3m52s
```
- Curl a localhost para comprobar que responde
```
curl http://localhost:3000/                                                                                                                                                              
<!doctype html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Document</title><script defer="defer" src="app.cd95cccfc69a4f3bd4eb.js"></script><script defer="defer" src="appStyles.81bfdf260f32b489a47b.js"></script><link href="appStyles.css" rel="stylesheet"></head><body><div id="root"></div></body></html>% 
```