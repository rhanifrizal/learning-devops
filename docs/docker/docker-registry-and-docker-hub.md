# Docker Registry and Docker Hub

## Objective

Learn how Docker images are stored and shared using Docker registries, understand image tagging and versioning, and publish and retrieve images from Docker Hub.


## Docker Image Lifecycle

```text
Local Docker Host
        │
        │ docker build
        ▼
Docker Image
        │
        │ docker tag
        ▼
username/company-web-app:v1.0
        │
        │ docker push
        ▼
Docker Hub
        │
        │ docker pull
        ▼
Another Machine
        │
        │ docker run
        ▼
Running Container
```


## What is a Docker Registry?

Docker Registry is a centralized server system or cloud service used to store, secure, and distribute container images (e.g., Docker Hub, Amazon ECR, Github Packages).


## What is Docker Hub?

Docker Hub is the default, pre-configured public cloud registry hosted by Docker. It hosts official Docker images, verified publisher images, and public or private repositories created by users.


## Docker Registry vs Docker Repository

The Registry is the entire hosting platform (the store), while a Repository is a specific folder inside that registry containing different historical versions of the exact same image (the shelf).


## Image Naming Convention

Docker image names follow this structure:

```text
[REGISTRY]/[USERNAME]/[REPOSITORY]:[TAG]

docker.io/rhanifrizal/company-web-app:v1.0
│        │           │              │
Registry Username  Repository     Tag
```

## Image Tags

Image tags are custom labels or aliases attached to an image build (using a `:` delimiter) to differentiate software versions, variants, or environments (e.g., `:v1.0` or `:latest`)


## latest vs Version Tags

The `latest` tag is the default tag Docker uses when no tag is specified. It is a mutable label and does not automatically represent the newest or most stable release. Version tags such as `v1.0.0` identify a specific release and provide more predictable, reproducible deployments.


## Tag Examples

| Tag       | Purpose                   |
|-----------|---------------------------|
| `latest`  | Most recent default image |
| `v1.0`    | Initial stable release    |
| `v1.1`    | Minor update              |
| `v2.0`    | Major release             |
| `dev`     | Development build         |     
| `staging` | Pre-production testing    |


## Common Docker Commands

### docker login

Authenticates your local Docker engine client with a remote Docker registry using your account credentials, generating a secure local authentication token.

Example:

```bash
docker login
```

**When to use:**
- Authenticate with a secure private registry before attempting to pull corporate base images or push internal application builds.
- Grant your local terminal permission to publish software artifacts to commercial container registries or GitHub Packages.


### docker logout

Purges active session authentication tokens and credentials from your local host machine's Docker configuration directory, severing connection permissions to remote systems.

Example:

```bash
docker logout
```

**When to use:**
- Secure public, shared, or automated runner server machines after deployment scripts finish running to prevent unauthorized registry access.
- Clear out cached credentials when switching between separate corporate or personal developer organization accounts.


### docker images

Generates a clean tabular summary tracking all container images currently downloaded, cached, and stored locally on your host machine's hard drive.

Example:

```bash
docker images
```

**When to use:**
- Audit your local disk storage allocation to check version tags, image identification numbers, and exact virtual disk space usage.
- Verify if a fresh compilation run or remote registry image download successfully registered on your local development computer.


### docker tag

Creates a distinct alias label or version pointer linking directly to an existing local target image, allowing you to properly format the image for alternative registries.

Example:

```bash
docker tag company-web-app rhanifrizal/company-web-app:v1.0
```

**When to use:**
- Rebrand an existing local test build with explicit version codes, environment names, or target repository host paths before publishing.
- Version control a stable compiled image layer snapshot by mapping a shifting development image to a locked semantic release tag.


### docker push

Uploads your locally compiled and tagged container image layers across the internet directly into a remote Docker registry repository.

Example:

```bash
docker push rhanifrizal/company-web-app:v1.0
```

**When to use:**
- Distribute ready-made software builds from your local machine or an automated CI/CD engine so deployment environments can access them.
- Share updated microservice image changes with remote team members using a centralized project development workspace.


### docker pull

Downloads a targeted container image and all of its associated filesystem layers from a remote distribution registry down onto your local machine's storage cache.

Example:

```bash
docker pull rhanifrizal/company-web-app:v1.0
```

**When to use:**
- Pre-cache official database, proxy, or backend framework base images on your system before launching dependencies or running code offline.
- Manually fetch the most recent cloud release build variant of an upstream dependency to update your running local environments.


### docker search

Queries the public Docker Hub registry directory straight from your terminal command line to find available open-source repositories matching specific keywords.

Example:

```bash
docker search mysql --filter "is-official=true"
```

**When to use:**
- Discover valid open-source technology image names and verify vendor verification statuses without opening a web browser.
- Check community star ratings and popularity levels for open-source utility tools when selecting a foundational architecture stack base.


## Practical Scenario

During this lab, I logged in to Docker Hub, tagged my local `company-web-app` image using my Docker Hub username, and pushed it to my public repository.

After publishing the image, I removed the tagged image locally, pulled it back from Docker Hub, and verified that it executed successfully.

I also tagged the same image with both `latest` and `v1.0`, then observed that Docker skipped uploading existing layers because they were already stored in the registry.


## Interview Questions

### What is a Docker Registry?

Docker Registry is a centralized server system or cloud service used to store, secure, and distribute container images (e.g., Docker Hub, Amazon ECR, Github Packages).


### What is Docker Hub?

Docker Hub is the default, pre-configured public cloud registry hosted by Docker.


### What is the difference between a Registry and a Repository?

Registry is the entire hosting platform (the store), while a Repository is a specific folder inside that registry containing different historical versions of the exact same image (the shelf).


### What does `docker tag` do?

It creates a target alias or pointer to an existing image ID without duplicating data. This is used to properly format the image name with a version code or registry URL before uploading.


### Why did Docker display Layer already exists during `docker push`?

Docker images are built out of independent, read-only layers. The registry checks the cryptographic hash of each layer. If that exact layer was already uploaded previously, it skips the network transfer to save time and bandwidth.


### Why shouldn't production systems always use latest?

The `:latest` tag is a shifting, mutable pointer, not a locked version snapshot. Using it risks pulling untried, breaking updates or creating mismatched environments whenever a container scales up or restarts. Always lock your production to explicit version tags (e.g., `:1.4.2`).


## Common Mistakes

- Forgetting to log in before pushing an image.
- Tagging an image with an incorrect repository name.
- Assuming tags create duplicate images.
- Using only the `latest` tag for production deployments.
- Forgetting that a repository must include your Docker Hub username.


## Notes

This lab was completed using Docker Desktop with WSL integration on Ubuntu.

During the lab, I successfully published my first custom Docker image to Docker Hub using the `docker tag` and `docker push` commands. After removing the tagged image locally, I pulled it back from Docker Hub and verified that it executed successfully.

I also learned that Docker images are composed of immutable layers. When I pushed the same image using multiple tags (`v1.0` and `latest`), Docker reused the existing layers and uploaded only the new tag reference, which significantly reduced upload time.


## Commands Used

```bash
docker login
docker images
docker tag company-web-app rhanifrizal/company-web-app:v1.0
docker push rhanifrizal/company-web-app:v1.0
docker rmi rhanifrizal/company-web-app:v1.0
docker pull rhanifrizal/company-web-app:v1.0
docker run rhanifrizal/company-web-app:v1.0
docker tag company-web-app rhanifrizal/company-web-app:latest
docker push rhanifrizal/company-web-app:latest
docker search nginx
docker logout
```