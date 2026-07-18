# Docker CLI Cheatsheet

A quick-reference guide for common Docker commands used to build, run, inspect, connect, persist, compose, and publish containerized applications.


## Docker Information

| Command            | Purpose                                            |
|--------------------|----------------------------------------------------|
| `docker --version` | Show the installed Docker version                  |
| `docker version`   | Show detailed client and server versions           |
| `docker info`      | Display Docker engine configuration and statistics |


## Images

| Command                       | Purpose                                |
|-------------------------------|----------------------------------------|
| `docker images`               | List local images                      |
| `docker pull IMAGE`           | Download an image from a registry      |
| `docker build -t NAME:TAG .`  | Build an image from a Dockerfile       |
| `docker image inspect IMAGE`  | Show detailed image metadata           |
| `docker tag SOURCE TARGET`    | Create another tag for an image        |
| `docker rmi IMAGE`            | Remove an image                        |
| `docker history IMAGE`        | Display image layers and build history |


Example:

```bash
docker build -t company-web-app:v1.0 .
docker tag company-web-app:v1.0 rhanifrizal/company-web-app:v1.0
```


## Containers

| Command                           | Purpose                                           |
|-----------------------------------|---------------------------------------------------|
| `docker run IMAGE`                | Create and start a container                      |
| `docker run --name NAME IMAGE`    | Run a container with a custom name                |
| `docker run -d IMAGE`             | Run a container in detached mode                  |
| `docker run --rm IMAGE`           | Automatically remove the container after it exits |
| `docker ps`                       | List running containers                           |
| `docker ps -a`                    | List all containers                               |
| `docker start CONTAINER`          | Start an existing stopped container               |
| `docker stop CONTAINER`           | Gracefully stop a running container               |
| `docker restart CONTAINER`        | Restart a container                               |
| `docker rm CONTAINER`             | Remove a stopped container                        |
| `docker rm -f CONTAINER`          | Force-remove a running container                  |


## Common `docker run` Flags

| Flag                  | Purpose                                       |
|-----------------------|-----------------------------------------------|
| `-i`                  | Keep standard input open                      |
| `-t`                  | Allocate a pseudo-terminal                    |
| `-it`                 | Open an interactive terminal                  |
| `-d`                  | Run in detached mode                          |
| `--rm`                | Remove the container automatically after exit |
| `--name`              | Assign a custom container name                |
| `-p HOST:CONTAINER`   | Publish a container port                      |
| `-v SOURCE:TARGET`    | Mount a volume or bind mount                  |
| `--network NETWORK`   | Connect to a Docker network                   |
| `-e KEY=VALUE`        | Set an environment variable                   |


Example:

```bash
docker run --rm -it ubuntu bash
docker run -d --name company-nginx -p 8080:80 nginx
```


## Logs and Inspection

| Command                           | Purpose                               |
|-----------------------------------|---------------------------------------|
| `docker logs CONTAINER`           | Show container logs                   |
| `docker logs -f CONTAINER`        | Follow logs in real time              |
| `docker inspect CONTAINER`        | Show detailed container metadata      |
| `docker exec -it CONTAINER bash`  | Open Bash inside a running container  |
| `docker exec -it CONTAINER sh`    | Open `sh` when Bash is unavailable    |
| `docker top CONTAINER`            | Show processes inside a container     |
| `docker stats`                    | Show live resource usage              |
| `docker port CONTAINER`           | Display published ports               |


## Networking

| Command                                       | Purpose                           |
|-----------------------------------------------|-----------------------------------|
| `docker network ls`                           | List Docker networks              |
| `docker network create NETWORK`               | Create a custom network           |
| `docker network inspect NETWORK`              | Inspect network configuration     |
| `docker network connect NETWORK CONTAINER`    | Attach a container to a network   |
| `docker network disconnect NETWORK CONTAINER` | Detach a container                |
| `docker network rm NETWORK`                   | Remove an unused network          |


Example:

```bash
docker network create devops-network
docker run -d --name company-nginx --network devops-network -p 8081:80 nginx
```


## Volumes

| Command                           | Purpose                   |
|-----------------------------------|---------------------------|
| `docker volume ls`                | List named volumes        |
| `docker volume create VOLUME`     | Create a named volume     |
| `docker volume inspect VOLUME`    | Inspect a volume          |
| `docker volume rm VOLUME`         | Remove an unused volume   | 
| `docker volume prune`             | Remove all unused volumes |


Named volume:

```bash
docker run --rm -it -v company-data:/data ubuntu bash
```

Bind mount:

```bash
docker run --rm -it -v "$(pwd)/volume-demo:/data" ubuntu bash
```


## Docker Compose

| Command                           | Purpose                                       |
|-----------------------------------|-----------------------------------------------|
| `docker compose config`           | Validate and render the Compose configuration |
| `docker compose build`            | Build service images                          |
| `docker compose up`               | Start services in the foreground              |
| `docker compose up -d`            | Start services in detached mode               |
| `docker compose up --build -d`    | Rebuild images and start services             |
| `docker compose ps`               | List running Compose services                 |
| `docker compose ps -a`            | Include exited Compose containers             |       
| `docker compose logs`             | Display service logs                          |
| `docker compose logs -f SERVICE`  | Follow logs for a service                     |
| `docker compose restart SERVICE`  | Restart a service                             |
| `docker compose down`             | Remove Compose containers and networks        |
| `docker compose down -v`          | Also remove Compose-managed volumes           |
| `docker compose exec SERVICE bash`| Open Bash inside a running Compose service    |
| `docker compose exec SERVICE sh`  | Open `sh` when Bash is unavailable            |


## Registry and Docker Hub

| Command                                   | Purpose                               |
|-------------------------------------------|---------------------------------------|
| `docker login`                            | Authenticate with a registry          |
| `docker logout`                           | Remove stored registry credentials    |
| `docker search TERM`                      | Search public Docker Hub repositories |
| `docker tag SOURCE USER/REPOSITORY:TAG`   | Prepare an image for a registry       |
| `docker push USER/REPOSITORY:TAG`         | Upload an image                       |
| `docker pull USER/REPOSITORY:TAG`         | Download an image                     |


Example:

```bash
docker tag company-web-app \
  rhanifrizal/company-web-app:v1.0

docker push rhanifrizal/company-web-app:v1.0
docker pull rhanifrizal/company-web-app:v1.0
```


## Cleanup

| Command                   | Purpose                                                   |
|---------------------------|-----------------------------------------------------------|
| `docker container prune`  | Remove all stopped containers                             |
| `docker image prune`      | Remove dangling images                                    |
| `docker image prune -a`   | Remove all unused images                                  |
| `docker network prune`    | Remove unused networks                                    |
| `docker volume prune`     | Remove unused volumes                                     |
| `docker system df`        | Show Docker disk usage                                    |
| `docker system prune`     | Remove unused containers, networks, and dangling images   |
| `docker system prune -a`  | Remove unused containers, networks, build cache, and all unused images |


## Useful Workflows

### Build and run an application

```bash
docker build -t company-web-app .
docker run --name company-app company-web-app
docker logs company-app
docker rm company-app
```


### Run a web server

```bash
docker run -d --name company-nginx -p 8080:80 nginx
```


### Start the Company Server project

```bash
cd projects/company-server/web-app
docker compose config
docker compose up --build -d
docker compose ps
docker compose logs
```


### Test the application

```bash
curl http://localhost:8080/health
curl http://localhost:8080/api/info
```


### Stop the project

```bash
docker compose down
```


## Image Naming

```text
[REGISTRY]/[USERNAME]/[REPOSITORY]:[TAG]
```

Example:

```text
docker.io/rhanifrizal/company-web-app:v1.0
```


## Container Lifecycle

```text
Created
   ↓
Running
   ↓
Paused or Stopped
   ↓
Restarted or Removed
```

A container remains running only while its main process is active.


## Safety Notes

- Avoid using `latest` as the only production tag.
- Stop containers before removing them unless force removal is necessary.
- Back up important volume data before deleting volumes.
- Inspect containers and logs before restarting or deleting them.
- Use `docker system prune -a` carefully because it can remove images needed by inactive projects.
- Never store registry passwords or application secrets directly in Dockerfiles or Compose files.