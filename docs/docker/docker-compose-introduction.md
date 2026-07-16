# Docker Compose

## Objective

Learn how Docker Compose simplifies multi-container application management, understand the structure of a `compose.yaml` file, and deploy multiple services using a single command.


## What is Docker Compose?

Docker Compose is a native orchestration tool designed for defining, configuring, and running multi-container Docker applications using a single, centralized configuration file. Instead of typing long, complex `docker run` commands into the terminal for every single microservice, you define your entire application stack, including containers, networks, volumes, and environment variables in a plain text file named `compose.yaml`.


## Why Docker Compose?

Docker Compose is used because it solves the complexity of managing multi-container applications. Running an application with a frontend, a backend, a database, and a cache using raw Docker commands requires typing multiple long, error-prone terminal strings. Docker Compose replaces that manual process with a single configuration file and one command.


## compose.yaml

`compose.yaml` is the standard configuration file used by Docker Compose to define an application's services, networks, volumes, and other settings. Docker Compose V2 recommends using `compose.yaml`, although the older `docker-compose.yml` filename is still supported for backward compatibility.


## Services

In Docker Compose, a service is the core configuration block within a `compose.yaml` file where you define the individual containers that make up your multi-container application. Each service represents a distinct component of your application architecture, such as a frontend web server, a backend API, a database, or a caching layer, and contains the configuration rules for how that specific container should be built, run, and isolated.

## Build vs Image

| build                                   | image                                  |
|-----------------------------------------|----------------------------------------|
| Builds an image from a local Dockerfile | Uses an existing image from a registry |
| Requires source code                    | Does not require source code           |
| Used for applications you develop       | Used for third-party software          |
| Executes `docker build` automatically   | Executes `docker pull` if needed       |

### `build`

```yaml
services:
  app:
    build: .
```

### `image`

```yaml
services:
  nginx:
    image: nginx:latest
```

## Common Docker Compose Commands

### docker compose up

Reads your configuration file, pulls required images, builds local application images, provisions networks and volumes, and fires up the defined application stack inside your active terminal window.

Example:

```bash
docker compose up
```

**When to use:**
- Launch your application stack during active development when you want to view real-time log outputs streams from all services directly inside your terminal panel
- Debug boot order sequences or catch early runtime crashes immediately, as closing or interrupting the terminal process via `Ctrl + C` gracefully halts the containers.


### docker compose up -d

Launches your multi-container environment exactly like the standard boot command, but runs the processes silently inside the background (detached mode), freeing up your terminal for immediate input.

Example:

```bash
docker compose up -d
```

**When to use:**
- Initialize production or staging workloads on server machines where you require the application infrastructure to remain up and running independently of your active SSH shell session.
- Resume work on local software projects without letting container log streams fill up your terminal interface canvas.


### docker compose down

Gracefully shuts down running application containers, detaches virtual network paths, and tears down the infrastructure stack created by the startup process.

Example:

```bash
docker compose down
```

**When to use:**
- Stop a development session cleanly to free up system hardware resources, RAM, and network ports on your local laptop.
- Clear out stale network routes or runtime container configurations before initiating a clean application redeployment.


### docker compose ps

Generates a clean tabular overview tracking the real-time execution health, container names, exposed port pathways, and running process states across your active project scope.

Example:

```bash
docker compose ps
docker compose ps -a
```

**When to use:**
- Verify if a service has crashed or failed its boot cycle by examining the execution state column for errors or unusual exit codes.
- Audit exactly which host machine ports are dynamically mapped to container internal environments across the active orchestration file.


### docker compose logs

Aggregates and formats stdout and stderr output log records from every container inside the environment stack into a synchronized, color-coded stream.

Example:

```bash
docker compose logs -f api-service
```

**When to use:**
- Inspect system stack traces or incoming runtime request payloads when debugging functional communication bugs between separate internal components.
- Track dynamic live event notifications from a single targeted service container by appending the precise service identifier along with the follow (-f) flag.


## Practical Scenario

During this lab, I created a simple Python application together with a `compose.yaml` file. Docker Compose automatically built the application image from the Dockerfile, created the container, and started the service using a single command.

I also learned how Docker Compose manages container names, networks, and application lifecycle, allowing the entire environment to be started and stopped consistently.


## Interview Questions

### What is Docker Compose?

Docker Compose is a native orchestration tool designed for defining, configuring, and running multi-container Docker applications using a single, centralized configuration file. Instead of typing long, complex `docker run` commands into the terminal for every single microservice, you define your entire application stack, including containers, networks, volumes, and environment variables in a plain text file named `compose.yaml`.


### Why use Docker Compose?

Docker Compose is used because it solves the complexity of managing multi-container applications. Running an application with a frontend, a backend, a database, and a cache using raw Docker commands requires typing multiple long, error-prone terminal strings. Docker Compose replaces that manual process with a single configuration file and one command.


### What is compose.yaml?

`compose.yaml` is the standard configuration file used by Docker Compose to define an application's services, networks, volumes, and other settings. Although `compose.yaml` is the recommended filename in Docker Compose V2, the older `docker-compose.yml` filename is still supported for backward compatibility.

### Difference between build and image?

build creates an image locally from a Dockerfile and application source code.

image pulls an existing image from a container registry such as Docker Hub.

### Difference between docker run and docker compose up?

While `docker run` is an imperative command used to manually spin up and configure a single container from the command line with complex, individual parameter flags, `docker compose up` is a declarative orchestrator that launches an entire multi-container ecosystem by reading pre-configured service, network, and volume rules directly from a single `compose.yaml` file. Consequently, `docker run` is best suited for quick one-off testing tasks, whereas `docker compose up` is the standard for managing complex, interconnected microservice applications with a single, reproducible command.


## Common Mistakes

- Forgetting to run `docker compose` from the directory containing `compose.yaml`.
- Mixing up `build` and `image`.
- Assuming `docker compose down` removes Docker volumes automatically.
- Editing a Dockerfile without rebuilding the image.
- Using the deprecated `docker-compose` command on newer Docker installations.


## Notes

This lab was completed using Docker Desktop with WSL integration on Ubuntu.

During the lab, Docker Compose built the application image, created the `compose-demo_default` network, and started the `company-compose-app` container from a single `compose.yaml` file.

The Python application printed its message and exited with code `0` because its main process completed immediately. Running the stack in detached mode did not keep the container active because containers only remain running while their main process is alive.

I also briefly encountered a WSL integration issue where the `docker` command was unavailable until Docker Desktop became active.

## Commands Used

```bash
docker compose config
docker compose up
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```