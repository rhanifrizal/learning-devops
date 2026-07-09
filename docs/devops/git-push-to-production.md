# From Git Push to Production


## Overview

When a developer runs `git push`, the source code is uploaded to the GitHub repository. GitHub detects the new commit and triggers a CI/CD pipeline through GitHub Actions. The pipeline automatically builds, tests, scans, packages, and prepares the application for deployment. If every stage succeeds, the application can be deployed to production, where monitoring tools continuously track its health and performance for end users.


## Pipeline Flow

```text
Developer
    │
git push
    ▼
GitHub Repository
    ▼
GitHub Actions
    ▼
Build
    ▼
Test
    ▼
Security Scan
    ▼
Package App
    ▼
Docker Image
    ▼
Container Registry
    ▼
Deploy to Cloud
    ▼
Production
    ▼
Monitoring
    ▼
Users
```


## Stage Explanation

### 1. Developer

The developer implements a new feature, fixes a bug, or improves the existing application before committing the changes to the local Git repository.

### 2. Git Push

After completing a new feature or bug fix, the developer commits the changes locally and pushes them to the remote GitHub repository using `git push`.

### 3. GitHub Repository

GitHub stores the latest version of the source code. Once a new commit is pushed, GitHub detects the event and triggers the configured GitHub Actions workflow.

### 4. GitHub Actions

GitHub Actions starts a workflow on a temporary runner (usually Ubuntu). The workflow executes every step defined in the YAML file, such as building the application, running tests, performing security scans, and preparing the application for deployment.

### 5. Build

The application is compiled into a deployable format. During this stage, dependencies are installed, source code is compiled, and build artifacts are generated.

### 6. Test

Automated tests verify that the application behaves as expected. This stage helps detect bugs, integration issues, and regressions before deployment.

### 7. Security Scan

Security tools can scan the source code, dependencies, and container images for known vulnerabilities before deployment.

### 8. Package App

Once all previous stages pass successfully, the application is packaged into a deployable artifact, such as a Docker image.

### 9. Docker Image

A Docker image is created from the packaged application. This image contains everything required to run the application consistently across different environments.

### 10. Container Registry

The Docker image is uploaded to a container registry such as Docker Hub, GitHub Container Registry (GHCR), or Amazon ECR, making it available for deployment.

### 11. Deploy to Cloud

The deployment process retrieves the Docker image from the container registry and deploys it to the target cloud environment, such as AWS, Azure, or Google Cloud.

### 12. Production

The application is now running in the production environment and is available for end users. Any successful deployment becomes accessible to users through the live system.

### 13. Monitoring

Monitoring tools such as Prometheus and Grafana continuously monitor application health, logs, and performance. Alerts notify engineers if issues occur.

### 14. Users

End users can now access the latest version of the application and use the newly deployed features.



## Reflection

### 1. Which stage do I understand best?
I understand stages 1 to 6 the best because they closely match the software development workflow I currently follow. Developing features, committing code, building applications, and testing are all part of my daily responsibilities. The later stages are still new to me and are the areas I want to learn throughout this DevOps journey.

### 2. Which stage is still unclear to me? 
Stage 7 and above is still unclear because it is a new process and I have no hands-on experience with these stages yet. While I understand their purpose conceptually, I still need practical experience to fully understand how they work and which tools are commonly used.

### 3. Which stage relates most to my current software development experience? 
Stages 1 to 6 relate the most to my current software development experience because I regularly develop features, push code, build applications, and perform testing manually before releasing updates.

### 4. Which stage relates most to my future DevSecOps goal? 
Stages 7 onwards relate the most to my future DevSecOps goal because they involve security scanning, containerization, cloud deployment, monitoring, and automation. These are the areas I want to master as I transition into DevSecOps.