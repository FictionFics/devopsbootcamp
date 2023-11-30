# Final Lab Containers

## Creation of Dockerfiles, backend and frontend 

- Go to backend folder in your repo and create the dockerfile.backend
```bash
touch Dockerfile.backend
```
- Copy this content in the dockerfile
```dockerfile
# Dockerfile.backend

FROM node:14

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 5000
CMD ["npm", "start"]
```
- In the same folder that you created the docker file execute this to build the image: 
```bash
docker build -f Dockerfile.backend -t lcchallenge-back:v1.0.0 .
```

- Go to frontend folder in your repo and create the dockerfile.frontend
```bash
touch Dockerfile.frontend
```
- Copy this content in the dockerfile
```dockerfile
# Dockerfile.frontend
FROM node:14

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["node", "server.js"]

```
- In the same folder that you created the docker file execute this to build the image: 
```bash
docker build -f Dockerfile.frontend -t lcchallenge-front:v1.0.0 .
```

## Creation of Network and Containers

- Create Lemoncode Network

```bash
docker network create lemoncode-challenge
```

- Create the folder from mongo to storage the information, **you should be in the node-stack repo**
```bash
mkdir ./mongodb/data/db
```
- Create mongodb container first to incorporate information inside, incorporate in the lemoncode network and attach a volume to the container

```bash
docker run -d --network lemoncode-challenge --name some-mongo -v ./mongodb/data/db:/data/db mongo:7.0.3
```
- Access to the mongo container and add information inside

```bash
docker exec -it some-mongo bash
```
```bash
mongosh
```
```bash
use TopicstoreDb
```
```bash
db.Topics.insertOne({topicName:"Grafana"})
db.Topics.insertOne({topicName:"Kubernetes"})
db.Topics.insertOne({topicName:"Docker"})
```

- Let's create the backend container using the image built before, it is important the var **HOST** and **DATABASE_URL**

```bash
docker run -d --network lemoncode-challenge --name topics-api -e DATABASE_URL=mongodb://some-mongo:27017 -e HOST=0.0.0.0 lcchallenge-back:v0.0.1
```
- Let's create the frontend container using the image built before, it is important the var **API_URI** and the port forwarding

```bash
docker run -d --network lemoncode-challenge --name frontend -p 8080:3000 -e API_URI=http://topics-api:5000/api/topics lcchallenge-front:v0.0.1
```

- You should have these 3 containers running with different ids:
```bash
  CONTAINER ID   IMAGE                      COMMAND                  CREATED        STATUS          PORTS                    NAMES
cbd3f4bd0e6a   lcchallenge-front:v0.0.1   "docker-entrypoint.s…"   16 hours ago   Up 15 minutes   0.0.0.0:8080->3000/tcp   frontend
0766a68aafe9   lcchallenge-back:v0.0.1    "docker-entrypoint.s…"   17 hours ago   Up 15 minutes   5000/tcp                 topics-api
9064b22a6568   mongo:7.0.3                "docker-entrypoint.s…"   2 days ago     Up 15 minutes   27017/tcp                some-mongo
```

## Docker Compose of the exercise
- Create a docker compose file in the node-stack repo folder
```bash
touch docker-compose.yml
```
- Paste this into the compose file

```yml
version: '3.7'

networks:
  lemoncode-challenge:
    driver: bridge

services:
  mongodb:
    image: mongo:7.0.3
    container_name: some-mongo
    networks:
      - lemoncode-challenge
    volumes:
      - ./mongodb/data/db:/data/db

  backend:
    image: lcchallenge-back:v0.0.1
    container_name: topics-api
    networks:
      - lemoncode-challenge
    environment:
      - DATABASE_URL=mongodb://some-mongo:27017
      - HOST=0.0.0.0
    depends_on:
      - mongodb

  frontend:
    image: lcchallenge-front:v0.0.1
    container_name: frontend
    ports:
      - "8080:3000"
    networks:
      - lemoncode-challenge
    environment:
     - API_URI=http://topics-api:5000/api/topics
    depends_on:
      - backend
```
- **If you want to see content, remember to add information inside the mongodb container!!**