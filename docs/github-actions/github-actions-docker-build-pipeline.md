# GitHub Actions Docker Build Pipeline

## Objective

Learn how GitHub Actions automatically builds Docker images during Continuous Integration (CI), understand why Docker image builds are important before deployment, and implement an automated Docker build pipeline for a Flask application.

---

## What is a Docker Build Pipeline?

A Docker Build Pipeline is a Continuous Integration process that automatically builds a Docker image whenever source code changes are pushed to the repository.

Instead of waiting until deployment to discover Dockerfile errors, the build process validates that the application can be successfully containerized during every workflow execution.

---

## Why Build Docker Images in CI?

Reasons for building Docker images during Continuous Integration:

1. Detect Dockerfile errors early.
2. Verify the application can be successfully containerized.
3. Ensure application dependencies install correctly.
4. Produce deployable container images.
5. Prevent broken images from reaching deployment environments.

---

## Docker Build Workflow

During Continuous Integration, GitHub Actions performs the following steps:

1. Checkout the repository.
2. Build the Docker image.
3. Tag the image.
4. Verify the image was created successfully.
5. Continue with the remaining pipeline stages.

---

## Docker Image Tagging

Docker images are identified using tags.

This repository assigns two tags during every build.

Example:

```yaml
docker build \
  -t company-server:${{ github.sha }} \
  -t company-server:latest \
  projects/company-server/web-app
```

### Latest Tag

```text
company-server:latest
```

Represents the most recently built image.

Useful for:

- Local development
- Quick testing
- Latest application version

---

### Commit SHA Tag

```text
company-server:<commit-sha>
```

Example:

```text
company-server:a92e8d669b0ab544762d79a22c06a84774a19f2a
```

Using the Git commit SHA provides traceability.

Benefits:

- Every image is uniquely identifiable.
- Images can be traced back to the exact source code commit.
- Simplifies debugging and rollback operations.

---

## Current Workflow Implementation

The Docker build job executes only after the Python validation job completes successfully.

Workflow configuration:

```yaml
docker-build:
  name: Docker Image Build
  needs: python-check
  runs-on: ubuntu-latest

  steps:
    - name: Checkout Repository
      uses: actions/checkout@v4

    - name: Build Docker Image
      run: |
        docker build \
          -t company-server:${{ github.sha }} \
          -t company-server:latest \
          projects/company-server/web-app

    - name: List Docker Images
      run: docker image ls
```

---

## Workflow Execution

Current pipeline:

```text
Push / Pull Request
│
├── Documentation Check
│
├── Python Validation (3.10)
│
├── Python Validation (3.11)
│
├── Python Validation (3.12)
│
├── Docker Image Build
│
├── Docker Compose Validation
│
└── GitHub Secrets Demo
```

The Docker image is successfully built before the Docker Compose configuration is validated.

---

## Practical Scenario

During this lab, GitHub Actions automatically built the Flask application into a Docker image.

The workflow:

1. Checked out the repository.
2. Built the Docker image.
3. Tagged the image using both the latest tag and the Git commit SHA.
4. Listed the available Docker images on the GitHub-hosted runner.
5. Continued the workflow after a successful build.

Example output:

```text
REPOSITORY        TAG

company-server    latest

company-server    a92e8d669b0ab544762d79a22c06a84774a19f2a
```

This confirms that the application can be successfully containerized before moving to the next stage of the CI pipeline.

---

## Interview Questions

### Why build Docker images during Continuous Integration?

Building Docker images during CI verifies that the Dockerfile is valid and ensures the application can be successfully containerized before deployment.

---

### What is the difference between `docker build` and `docker compose`?

`docker build` creates a Docker image from a Dockerfile.

`docker compose` manages one or more containers using a Compose configuration.

---

### Why tag Docker images with the Git commit SHA?

Using the commit SHA creates a unique image for every build, allowing images to be traced back to the exact source code version.

---

### Why is the Docker image built before deployment?

Building the image early detects Docker-related issues before deployment and guarantees that only valid images move through the pipeline.

---

### Why list Docker images after building?

Listing Docker images verifies that the image was successfully created and tagged during the workflow.

---

## Common Mistakes

- Building Docker images only during deployment.
- Using only the `latest` tag.
- Ignoring Docker build failures.
- Assuming Docker Compose validates Dockerfile syntax.
- Forgetting to verify that the image was successfully created.

---

## Notes

This repository uses GitHub Actions to automatically build the Flask application into a Docker image during every workflow execution.

The workflow tags each image using both the latest tag and the Git commit SHA, providing convenience for development and traceability for future deployments.

Although the image is not yet published to a container registry, this pipeline establishes the foundation for future deployment to Docker Hub, GitHub Container Registry (GHCR), AWS, or Kubernetes.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add Docker image build job"
git push
```