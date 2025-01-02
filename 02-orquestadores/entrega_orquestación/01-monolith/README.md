# Monolito
En este ejercicio, he creado una carpeta por cada paso requerido, con lo snombres Paso 1, 2 y 3 por el mero hecho de organizar un poco todo.
> Nota: He usado la imagen `lemoncodersbc/lc-todo-monolith-psql:v5-2024`, también, como dice el ejercicio he creado el PVC aparte y le he puesto en el statefulset que haga un claim de ese PVC, normalmente la buena práctica sería incluir en el statefulset que haga un claim dinámicamente y cree un pvc directamente, eso lo he probado y funcionaba correctamente también, pero lo he preferido dejar como dice el ejercicio. 

### Respuesta Paso 1:

- Accede a la carpeta Paso1
```
cd 02-orquestadores/ejercicios_practicos/01-monolith/Paso1
```
- Habría que aplicar los yaml en este orden:
```
kubectl apply -f configmap.yaml
```
```
kubectl apply -f storageClass.yaml
```
```
kubectl apply -f persistentVolume.yaml
```
```
kubectl apply -f persistentvolumeClaim.yaml
```
```
kubectl apply -f clusterIp.yaml
```
```
kubectl apply -f statefulSet.yaml
```

- Confirmamos la creación de todos los recursos:
```
kubectl get all
```
```
NAME             READY   STATUS    RESTARTS   AGE
pod/postgres-0   1/1     Running   0          6s

NAME                       TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
service/kubernetes         ClusterIP   10.96.0.1    <none>        443/TCP    72d
service/postgres-service   ClusterIP   None         <none>        5432/TCP   20s

NAME                        READY   AGE
statefulset.apps/postgres   1/1     6s
```
```
kubectl get pv,pvc
```
```
NAME                           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                  STORAGECLASS      VOLUMEATTRIBUTESCLASS   REASON   AGE
persistentvolume/postgres-pv   5Gi        RWO            Retain           Bound    default/postgres-pvc   dynamic-storage   <unset>                          19m

NAME                                 STATUS   VOLUME        CAPACITY   ACCESS MODES   STORAGECLASS      VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/postgres-pvc   Bound    postgres-pv   5Gi        RWO            dynamic-storage   <unset>                 19m
```

### Respuesta Paso 2:
He creado otra carpeta Paso2 para esta parte del ejercicio con lo nuevo añadido, en ese caso he creado un deployment, configmap y clusterip, le he incorporado 2 réplicas al deployment de todos.

- Accede a la carpeta Paso2
```
cd 02-orquestadores/ejercicios_practicos/01-monolith/Paso2
```
- Aplicar estos yaml en orden:
```
kubectl apply -f configMaptodo-app.yaml
```
```
kubectl apply -f deployment.yaml 
```
```
kubectl apply -f clusterIptodo-app.yaml
```
- Comprobamos que todo esté creado correctamente, también puede ver el servicio si usas el comando de minikube 
`minikube service todo-app-service`
```
kubectl get all
```
```
NAME                            READY   STATUS    RESTARTS   AGE
pod/postgres-0                  1/1     Running   0          32m
pod/todo-app-75cd574f4f-c7qq2   1/1     Running   0          12s
pod/todo-app-75cd574f4f-z5thh   1/1     Running   0          12s

NAME                       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes         ClusterIP   10.96.0.1       <none>        443/TCP    72d
service/postgres-service   ClusterIP   None            <none>        5432/TCP   32m
service/todo-app-service   ClusterIP   10.104.189.53   <none>        80/TCP     3s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/todo-app   2/2     2            2           12s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/todo-app-75cd574f4f   2         2         2       12s

NAME                        READY   AGE
statefulset.apps/postgres   1/1     32m
```
### Respuesta Paso 3

He creado otra carpeta Paso3 para esta parte del ejercicio con el loadbalancer service, en este caso habría que crear un tunnel en minikube previamente con este comando `minikube tunnel`, aparte de esto, tendríamos que eliminar primero el cluster Ip creado en el Paso2.

- Accede a la carpeta Paso2
```
cd 02-orquestadores/ejercicios_practicos/01-monolith/Paso2
```
- Elimina el ClusteIp
```
k delete -f clusterIptodo-app.yaml
```
- Accede a la carpeta Paso3
```
cd 02-orquestadores/ejercicios_practicos/01-monolith/Paso3
```
- Aplicamos el yaml:
```
kubectl apply -f lbtodos-app.yaml
```
- Comprobamos el servicio:
```
kubectl get svc todo-app-loadbalancer
```
```
NAME                    TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
todo-app-loadbalancer   LoadBalancer   10.96.163.145   127.0.0.1     80:31522/TCP   28s
```
- Hacemos llamada a localhost con un curl para confirmar:
```
curl http://127.0.0.1
```
```
<!doctype html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Document</title><script defer="defer" src="app.cd95cccfc69a4f3bd4eb.js"></script><script defer="defer" src="appStyles.81bfdf260f32b489a47b.js"></script><link href="appStyles.css" rel="stylesheet"></head><body><div id="root"></div></body></html>%  
```