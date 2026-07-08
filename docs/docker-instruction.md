# Docker Introduction

## Objective

Learn the fundamentals of Docker, understand why containers are used, how Docker architecture works, and the differences between containers and virtual machines.

## What is Docker?

Docker is an open-source platform used to build, ship, and run applications inside lightweight, isolated containers.


## Why Docker?

We use Docker for several key reasons which is consistency, isolation, and efficiency.
* Eliminates "It works on my machine" syndrome
* Instant deployment
* Resource efficiency
* Simplified scaling


## Containers vs Virtual Machines

The primary difference is that virtual machines copy an entire operating system, while containers share the host computer's operating system kernel. This architectural shift makes containers significantly lighter, faster, and cheaper to run than traditional virtual machines.

Visual Concept:

* Virtual Machines: Think of a VM like a complete house. It has its own infrastructure, plumbing, security, and frame. If you want three applications, you have to build three separate houses on your land.

* Containers: Think of containers like apartments inside a single building. They share the same core foundation, infrastructure, and main plumbing lines (the host OS kernel), but every apartment has its own locked front door and private internal space.


## Docker Architecture

Docker consists of three main components:

1. The Client
This is the command line where you type commands (like `docker run`). It takes your order and passes it to the daemon

2. The Daemon
This is the engine running in the background. It does all the heavy lifting like building, running, and managing your containers.

3. The Registry
This is a storage vault (like Docker Hub) that holds and distributes Docker images. When daemon needs an application template that is not stored locally on your machine, it reaches out to the registry to download (pull) that specific image.


## Docker Components

### Docker Engine

The core software responsible for building and running containers.


### Docker Client

The command-line interface (CLI) used to interact with Docker.


### Docker Daemon

A background service that builds, runs, and manages Docker containers.


### Docker Hub

A cloud-based registry used to store and share Docker images.


### Images

Read-only templates used to create containers.


### Containers

Running instances of Docker images.


## Docker Workflow

Standard Docker workflow follows a simple three-step cycle: Build -> Ship -> Run.

BUILD (Code → Image)
You write your software code and define its environment requirements inside a plain text configuration file called a `Dockerfile`.
↓
SHIP (Image → Registry)
Once your image is built locally on your machine, you need to make it accessible to your team, production servers, or CI/CD automated pipeline engines.
↓
RUN (Registry → Container)
When it is time to deploy your application to a test server or a live cloud environment, you execute the deployment on the target host.


## Practical Scenario

A developer builds a Python application on their laptop.

Instead of asking everyone to install Python, dependencies, and libraries manually, the developer packages everything into a Docker image.

The same image runs consistently on development, testing, and production servers, eliminating "it works on my machine" issues.

## Interview Questions

### 1. What is Docker?

Docker is an open-source platform used to build, ship, and run applications inside lightweight, isolated environments called containers.


### 2. Why use Docker?

Docker delivers four primary operational benefits:
1. Environment consistency: Applications run identically across development laptops, testing environments, and production cloud servers.
2. Rapid deployment: Containers launch instantly in milliseconds because they share the host OS kernel instead of booting a full operating system.
3. High resource density: You can pack dozens of isolated containers onto a single server, maximizing hardware usage and cutting cloud hosting costs.
4. Horizontal scaling: Lightweight container images allow automation systems to instantly spin up duplicate instances to handle heavy traffic spikes.


### 3. What is the difference between an Image and a Container?

Docker image is a read-only, immutable snapshot template containing the application code, libraries, runtime, and configuration settings. It is a dormant blueprint stored on a disk.

Docker container is a live, active execution instance of a Docker image. It adds a thin, writable layer on top of the read-only image and uses host system resources to execute the application process.


### 4. What is Docker Hub?

Docker Hub is a cloud-based public registry service used to store, manage, and distribute Docker images. It acts as a global warehouse where developers can download standardized software templates (such as verified images for Ubuntu, Python, Nginx, or MySQL) and share their own custom application builds with the world.


### 5. What problem does Docker solve?

Docker solves dependency hell and the "it works on my machine" syndrome. It eliminates the environment friction by bundling the entire software environment together, ensuring that if it runs in a container locally, it will run exactly the same way in production.


## Common Mistakes

- Confusing Docker Images with Docker Containers.
- Thinking Docker is the same as a Virtual Machine.
- Assuming containers include a full operating system.
- Forgetting that containers are ephemeral unless data is stored in volumes.
- Pulling images from untrusted registries.


## Notes

Docker was created to provide consistent application deployment across different environments. By packaging an application together with its dependencies into a container, the same image can run reliably in development, testing, and production.