# Docker Installation and First Container

## Objective

Learn how to verify a Docker installation, understand the Docker engine, run your first container, inspect images and containers, and perform basic cleanup operations.

## Docker Version Check

To verify the installed Docker version on your system, use the standard `docker --version` command.

## What Happened When Running hello-world?

When running `docker run hello-world`, the Docker engine executed a multi-step verification process to ensure your environment was configured correctly.

1. Local cache check
To check whether your machine's local storage already has the image downloaded

2. Pulling from Docker Hub
If the image is missing locally, the daemon will automatically connect over the internet to Docker Hub, locate the official hello-world image, and download (pull) it onto your machine.

3. Creating and running the Container
Once the image had been downloaded, the daemon used the immutable image as a blueprint to create and start a new container.

4. Executing the internal program
Inside the isolated environment, Docker executed the container's default startup command. This triggered a tiny, pre-compiled C program whose sole job was to stream the famous informational text block directly out to our terminal screen.

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

5. Instant lifecycle shutdown
Because container lifecycles are tied directly to the application process running inside them, the moment the program finished printing those lines of text, the process ended. The hello-world container automatically shifted into a Stopped/Inactive state, leaving its static footprint on your disk until you run `docker rm` to clear it out.


## Common Docker Commands

### docker --version

Prints a quick, single-line summary of the installed Docker client version

Example:

```bash
docker --version
```

**When to use:**
- Quick sanity check to verify Docker is installed on a machine


### docker version

Displays a detailed technical breakdown of both the Client and Server (Daemon) engines, including API versions, Go runtime specs, and OS architecture

Example:

```bash
docker version
```

**When to use:**
- Troubleshoot compatibility issues between your CLI client and a remote server engine


### docker info

Displays a system-wide statistics and configuration details of the entire Docker engine, including the number of running/paused/stopped containers, storage driver types, memory limits, and security profile configurations.

Example:

```bash
docker info
```

**When to use:**
- Audit host server resource limits and checking if your background engine is running correctly


### docker run

Creates and starts a live container from a specified image. If the image is not found locally, it automatically downloads (pulls) it from Docker Hub before running.

Example:

```bash
docker run hello-world
```

**When to use:**
- Create and start a container from an image.


### docker images

Lists all Docker images that have been downloaded or built locally on your machine's hard drive.

Example:

```bash
docker images
```

**When to use:**
- Check what templates are ready to use and monitoring how much disk space you cached images are consuming


### docker ps

Lists all currently active and running containers on the system

Example:

```bash
docker ps
```

**When to use:**
- Check the health of your live applications, finding their active uptime, and identifying which network ports they are using


### docker ps -a

Lists all containers on your system, including active, paused, crashed, or completely stopped ones (the `-a` stands for "all").

Example:

```bash
docker ps -a
```

**When to use:**
- Track down why a container abruptly exited or finding old container IDs to clean up disk space


### docker rm

Permanently deletes one or more stopped containers from your local system.

Example:

```bash
docker rm c0914f485151
```

**When to use:**
- Remove leftover container footprints after they finish executing to keep you workspace clean


### docker rmi

Permanently deletes one or more local images from your host storage disk.

Example:

```bash
docker rmi hello-world
```

**When to use:**
- Free up gigabytes of hard drive space by deleting old application versions or unused base templates


## Practical Scenario

A new developer joins the team and needs to verify that Docker is installed correctly.

First, they check the Docker installation using `docker --version` and `docker info`.

Next, they run the `hello-world` image to verify that the Docker Client, Docker Daemon, and Docker Hub can communicate successfully.

Finally, they inspect the created container using `docker ps -a` and remove unused containers and images using `docker rm` and `docker rmi` to keep the local environment clean.


## Interview Questions

### 1. What is the difference between an image and a container?

An image is a read-only, immutable snapshot template containing the application code, libraries, and environment blueprints stored statically on your disk.

A container is a live, isolated, and runnable execution instance of that image that adds a thin writable layer on top to handle active application processes.


### 2. Why does `docker ps` show nothing after running `hello-world`?

The `docker ps` command only display currently active and running containers. Because the `hello-world` container only executes a short script to print text and then immediately terminates, its internal process ends, causing the container to instantly shut down and shift into a stopped state.


### 3. Why did `docker rmi hello-world` fail at first?

It failed because Docker protects system data by preventing the deletion of an image if a container (even a completely stopped or inactive one) is still attached to it. You must always use `docker rm` to delete the referencing container footprint first before you can permanently remove the parent image.


### 4. What does `Exited (0)` mean?

`Exited (0)` means the primary process running inside the container has stopped executing and the container is now dormant. The number inside the parentheses `(0)` represent a successful Linux exit code, confirming that the application completed its task perfectly without encountering any runtime errors or system crashes.


### 5. What is Docker Desktop doing in this WSL setup?

In WSL integration, Docker Desktop acts as the core backend virtualization engine. It runs a lightweight Linux utility VM utility behind the scenes to host the actual Docker Daemon `dockerd`, while cleanly exposing a socket bridge into your WSL terminal so your Linux commands can control Docker containers natively.


## Common Mistakes

- Confusing Docker images with Docker containers.
- Assuming `docker ps` shows stopped containers.
- Forgetting to remove containers before deleting an image.
- Thinking containers continue running after the main process exits.
- Assuming Docker automatically deletes stopped containers.


## Notes

This lab was completed using Docker Desktop with WSL integration on Ubuntu.

During the lab, I verified the Docker installation, ran the `hello-world` container, inspected images and containers, and learned that Docker prevents an image from being removed while it is still referenced by an existing container. After deleting the stopped containers with `docker rm`, I successfully removed the image using `docker rmi`.