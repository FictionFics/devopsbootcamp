## Ejercicios Jenkins

### 1. CI/CD de una Java + Gradle - OBLIGATORIO

Esta parte del ejercicio se encuentra en `ejercicio_1/jenkins-resources` dentro de la carpeta `calculator` he creado el Jenkinsfile con distintos valores, una cosa a considerar es que la versión de Java de Jenkins es la 17 y la que está ejecutando Gradle era la 8, y daba un fallo de versión al ejecutar el compilar Java, he tenido que cambiar en el fichero `gradle-wrapper.properties` el distributionURL, adjunto una foto del pipeline funcionando.

![alt text](image.png)

### 2. Modificar la pipeline para que utilice la imagen Docker de Gradle como build runner - OBLIGATORIO

* Utilizar Docker in Docker a la hora de levantar Jenkins para realizar este ejercicio
* Como plugins deben estar instalados `Docker` y `Docker Pipeline`
* Usar la imagen de Docker `gradle:6.6.1-jre14-openj9`