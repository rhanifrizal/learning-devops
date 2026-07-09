# Docker Images and Dockerfile

## Objective

Learn how Docker images are built from Dockerfiles, understand the purpose of common Dockerfile instructions, and build a custom Docker image that can be used to create containers.

## What is a Docker Image?

A Docker image is a read-only, immutable template that contains the application code, runtime, libraries, dependencies, and configuration required to create a Docker container.


## What is a Dockerfile?

A Dockerfile is a plain-text configuration file that contains a sequential list of commands and instructions used by the Docker engine to automatically build a Docker image.


## Dockerfile Instructions

### FROM

A foundational base image that your build will start from. Every valid Dockerfile must begin with this instruction to set up the initial operating system and language runtime environment.

Example:

```bash
FROM python:3.12-slim
```

**When to use:**
- Initialize a clean environment using a verified template (like Ubuntu, Node.js, or Python) instead of building an operating system from scratch


### WORKDIR

Sets the active working directory inside the container's virtual file system.

Example:

```bash
WORKDIR /app
```

**When to use:**
- Organize your container files cleanly and prevent files from being dumped randomly into the root (/) directory


### COPY

Copies files or directories from the build context (typically your project folder) into the Docker image during the build process.

Example:

```bash
COPY app.py .
```

**When to use:**
- Transfer your application source code, configuration assets, or script files from your development machine into the container


### CMD

Specifies the default command that will execute automatically only when the container launches live. There can only be one `CMD` instruction per Dockerfile.

Example:

```bash
CMD ["python", "app.py"]
```

**When to use:**
- Define the main process or startup execution string that keeps your container running once it wakes up


## Practical Scenario

A developer has completed a Python application and wants it to run consistently across development, testing, and production environments.

Instead of asking every team member to install Python and all required dependencies manually, the developer creates a Dockerfile describing the application's runtime environment.

Using `docker build`, Docker reads the Dockerfile and builds a reusable Docker image. The image can then be distributed and executed using `docker run`, ensuring the application behaves consistently regardless of the host operating system.

## Interview Questions

### 1. What is a Docker image?

A Docker image is a read-only, immutable snapshot template containing the exact application code, libraries, dependencies, and configuration settings required to run software. It sits statically on your hard drive as a locked-in blueprint and does not consume live CPU or RAM resources.


### 2. What is a Dockerfile?

A Dockerfile is a plain-text configuration file containing a sequential list of commands and instructions that the Docker engine reads to automatically build a Docker image.


### 3. What does `FROM` do?

A `FROM` instruction initializes the build process and sets the foundational base image for your application. Every valid Dockerfile must begin with a `FROM` line, which pulls a pre-configured template (like an OS or language runtime) from a registry so you do not have to build an environment from scratch.


### 4. What is the difference between image and container?

An image is a dormant, read-only architectural blueprint stored on your disk.

A container is a live, active instance built from that image template. It isolates the process using host resources and adds a temporary, thin writable layer on top to handle active application data modifications.


### 5. Why use `python:3.12-slim` instead of full Python image?

A `slim` version drastically reduces your image size by stripping out hundreds of unnecessary development packages, compilers, and debugging tools. This architectural optimization results in:

1. Faster deployment
2. Lower storage costs
3. Enhanced security


## Common Mistakes

- Forgetting to include a `FROM` instruction.
- Using the wrong build context when running `docker build`.
- Forgetting to copy application files with `COPY`.
- Confusing `COPY` with `ADD`.
- Assuming changes made inside a running container automatically update the Docker image.


## Notes

This lab was completed using Docker Desktop with WSL integration on Ubuntu.

During the lab, I created my first custom Docker image from a Dockerfile, built it using `docker build`, and successfully ran it using `docker run`. This demonstrated how Docker builds an image from a Dockerfile and how that image is used to create a container.


## Commands Used

```bash
docker build -t company-web-app .
docker images
docker run company-web-app
docker ps
docker ps -a
docker image inspect company-web-app
```
