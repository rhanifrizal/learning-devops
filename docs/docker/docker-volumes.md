# Docker Volumes

## Objective

Learn how Docker volumes provide persistent storage, understand the difference between named volumes and bind mounts, and share data between containers and the host filesystem.

## What are Docker Volumes?

Docker volumes are a native storage mechanism designed to persist data generated or used by Docker containers. By default, any data created inside a container is stored in its writable layer. If the container is deleted, that data is permanently lost. Volumes isolate data from the container lifecycle by storing it separately on the host filesystem.


## Why Volumes Matter

Volumes provide several important benefits:

1. Data Persistence
Data survives intact even when containers are stopped, removed, or replaced during software updates.

2. Host Performance
Standard container layers use copy-on-write storage drivers which degrade write speeds. Volumes bypass these drivers, writing directly to the host filesystem at native speed.

3. Safe Data Sharing
Multiple containers can safely mount and access the exact same volume concurrently, enabling simple data sharing.

4. Decoupled Backups
Because data is separated from application code, infrastructure teams can back up, restore, or migrate data without altering running container processes.


## Named Volumes

Named volumes are storage locations fully managed by Docker. You assign a volume a name, and Docker stores it in its managed storage area (typically `/var/lib/docker/volumes/` on Linux). Containers can mount the volume without needing to know its physical location.


## Bind Mounts

Bind mounts map a specific directory or file from the host machine directly into a container. Both the host and the container can read and modify the same files in real time.


## Named Volume vs Bind Mount

| Feature     | Named Volume               | Bind Mount               |
| ----------- | -------------------------- | ------------------------ |
| Managed by  | Docker                     | Host OS                  |
| Location    | Docker storage             | User-defined path        |
| Portability | High                       | Lower                    |
| Best for    | Databases, persistent data | Development, source code |
| Performance | Excellent                  | Excellent                |
| Backup      | Via Docker                 | Via OS tools             |


## Common Docker Commands

### docker volume ls

Displays a clean table listing every persistent named volume currently registered and managed on your local Docker daemon host.

Example:

```bash
docker volume ls
```

**When to use:**
- Audit your system storage to verify whether a specific persistent storage disk exists before deploying your application containers
- Identify old, dangling named volumes left behind by deleted containers that might be consuming valuable host disk space


### docker volume create

Manually provisions a new, isolated named volume within Docker's managed storage directory on the host filesystem before any container attaches to it.

Example:

```bash
docker volume create company-data
```

**When to use:**
- Pre-configure persistent data partitions with specific names before running database clusters or stateful microservices
- Ensure storage boundaries are established cleanly during automated infrastructure setup scripts or deployment pipelines


### docker volume inspect

Returns a details JSON metadata payload detailing the volume's internal host system path, creation date, active volume drivers, and user labels.

Example:

```bash
docker volume inspect company-data
```

**When to use:**
- Locate the exact absolute file path on your Linux host system where Docker is actively writing your container's persistent data
- Troubleshoot storage drive configurations or check custom label metadata assigned to your volume layers


### docker run -v

Mounts a managed name volume or an absolute host system path directly into a target directory inside a container during its initialization phase.

Example:

```bash
docker run --rm -it -v company-data:/data ubuntu bash
docker run --rm -it -v $(pwd)/volume-demo:/data ubuntu bash
```

**When to use:**
- Bind an app container directory to an external data volume so critical logs, assets, or database files survive container updates
- Link local source code folders directly into a development container to enable real-time application updates without rebuilding images


### docker volume rm

Permanently destroys a named volume from the host system filesystem, wiping out all files, configurations, and data contents stored inside it.

Example:

```bash
docker volume rm company-data
```

**When to use:**
- Wipe out database storage zones or old application cache volumes that are no longer needed by any system components
- Reclaim hard drive space by deleting deprecated project storage layers once data has been safely archived elsewhere


## Practical Scenario

During this lab, I created a named Docker volume and mounted it into an Ubuntu container. After creating a file inside the mounted volume, I removed the container and verified that the data still existed by mounting the same volume into a new container.

I also created a bind mount that mapped a folder from my host machine into a container. Changes made inside the container immediately appeared on the host, demonstrating how bind mounts are commonly used during application development.


## Interview Questions

### 1. Why do containers lose data when removed?

Containers lose data because of their underlying storage architecture, which relies on a temporary, ephemeral layout called the writable layer.


### 2. What is a Docker volume?

Docker volume is a native, dedicated storage mechanism designed to safely persist data generated or consumed by containerized applications, completely independent of the container's lifecycle.


### 3. What is the difference between a named volume and a bind mount?

Named volumes are fully managed by Docker and stored in Docker's managed storage location. They are portable across environments and are commonly used for persistent application data.

Bind mounts map a specific directory or file from the host machine directly into a container. They are commonly used during development because changes made on the host are immediately visible inside the container.


### 4. Why are volumes important for databases?

Volumes are absolutely critical for containerized databases (such as PostgreSQL, MySQL, or MongoDB) due to strict production requirements around data durability and performance.


### 5. What does `-v company-data:/data` mean?

The `-v company-data:/data` flag mounts a named volume into a specific directory inside a container using the structured format `-v VOLUME_NAME:CONTAINER_PATH`.


## Common Mistakes

- Assuming data inside a container survives after the container is removed.
- Confusing named volumes with bind mounts.
- Forgetting to mount the same volume when recreating containers.
- Deleting a volume before backing up important data.
- Using bind mounts in production when a named volume is more appropriate.


## Notes

This lab was completed using Docker Desktop with WSL integration on Ubuntu.

During the lab, I created a named volume, verified data persistence across multiple containers, explored bind mounts for sharing files with the host machine, and learned the differences between Docker-managed volumes and host-managed bind mounts.


## Commands Used

```bash
docker volume ls
docker volume create company-data
docker volume inspect company-data
docker run --rm -it -v company-data:/data ubuntu bash
docker run --rm -it -v $(pwd)/volume-demo:/data ubuntu bash
docker volume rm company-data
```