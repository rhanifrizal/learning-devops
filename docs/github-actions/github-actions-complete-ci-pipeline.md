# GitHub Actions Complete CI Pipeline

## Objective

Build a complete Continuous Integration pipeline using GitHub Actions that validates documentation, tests a Python application across multiple versions, builds a Docker image, starts the application with Docker Compose, verifies application health, collects diagnostic information, and performs automatic cleanup.

---

## What Is a Complete CI Pipeline?

A complete Continuous Integration pipeline validates an application through multiple automated stages whenever code is pushed or a pull request is created.

Instead of checking only one part of the project, the pipeline verifies the complete application lifecycle:

1. Validate repository documentation.
2. Validate Python compatibility.
3. Install application dependencies.
4. Compile the application.
5. Generate build reports.
6. Build the Docker image.
7. Validate the Docker Compose configuration.
8. Start the containerized application.
9. Wait for the container to become healthy.
10. Verify the application health endpoint.
11. Display container status and logs.
12. Stop and remove temporary resources.

This provides stronger confidence that the application can be successfully built and started before deployment.

---

## Why Use a Complete CI Pipeline?

A complete CI pipeline provides several benefits:

1. **Early Error Detection:** Problems are discovered immediately after code changes are pushed.
2. **Consistent Validation:** Every change passes through the same automated process.
3. **Runtime Verification:** The application is started and tested instead of only checking syntax.
4. **Compatibility Testing:** The application is validated using multiple Python versions.
5. **Container Validation:** Docker and Docker Compose configurations are tested automatically.
6. **Faster Feedback:** Developers quickly receive information about failed builds or tests.
7. **Deployment Confidence:** Only validated application changes are considered ready for later deployment stages.

---

## Current Pipeline Architecture

```text
Push or Pull Request
        │
        ├─────────────────────────────┐
        │                             │
        ▼                             ▼
Documentation Check          Python Validation Matrix
                              ├── Python 3.10
                              ├── Python 3.11
                              └── Python 3.12
                                        │
                                        ▼
                               Docker Image Build
                                        │
                                        ▼
                                Integration Test
                              ├── Validate Compose
                              ├── Build Application
                              ├── Start Containers
                              ├── Wait for Health
                              ├── Verify /health
                              ├── Show Status
                              ├── Show Logs
                              └── Cleanup

GitHub Secrets Demo runs independently.
```

---

## Workflow Triggers

The workflow runs when:

- Code is pushed to the `main` branch.
- A pull request targets the `main` branch.

```yaml
on:
  push:
    branches:
      - main

  pull_request:
    branches:
      - main
```

This ensures that changes are validated both after direct pushes and before pull requests are merged.

---

## Documentation Check

The documentation job checks out the repository and searches for Markdown files.

```yaml
docs-check:
  name: Documentation Check
  runs-on: ubuntu-latest

  steps:
    - name: Checkout Repository
      uses: actions/checkout@v4

    - name: Verify Markdown Files
      run: find . -name "*.md"
```

### Purpose

- Confirms that repository documentation is available.
- Demonstrates an independent workflow job.
- Runs in parallel with Python validation.

> This command lists Markdown files but does not validate Markdown formatting or broken links. Dedicated linting can be added in a future improvement.

---

## Python Validation Matrix

The `python-check` job validates the Flask application using Python 3.10, 3.11, and 3.12.

```yaml
strategy:
  fail-fast: false
  matrix:
    python-version:
      - "3.10"
      - "3.11"
      - "3.12"
```

GitHub Actions expands this single job definition into three separate job executions:

```text
Python Validation (3.10)
Python Validation (3.11)
Python Validation (3.12)
```

### Fail-Fast Configuration

```yaml
fail-fast: false
```

This allows all Python versions to complete even when one matrix execution fails.

The result provides complete compatibility information rather than cancelling the remaining matrix jobs immediately.

---

## Python Setup and Dependency Caching

Each matrix job uses `actions/setup-python` to install the selected Python version.

```yaml
- name: Setup Python
  uses: actions/setup-python@v5
  with:
    python-version: ${{ matrix.python-version }}
    cache: "pip"
    cache-dependency-path: projects/company-server/web-app/requirements.txt
```

The pip cache reduces repeated package downloads across workflow runs.

Dependencies are installed using:

```yaml
- name: Install Dependencies
  run: pip install -r projects/company-server/web-app/requirements.txt
```

---

## Python Compilation

The workflow compiles the Flask application without starting it.

```yaml
- name: Compile Python
  run: python -m py_compile projects/company-server/web-app/app.py
```

This detects Python syntax errors early in the pipeline.

Compilation confirms that the file contains valid Python syntax, but it does not replace unit tests or application runtime testing.

---

## Build Reports and Artifacts

Each Python matrix job creates a build report containing workflow metadata.

```yaml
- name: Create Build Report
  run: |
    echo "Python validation completed successfully." > build-report.txt
    echo "Workflow: $GITHUB_WORKFLOW" >> build-report.txt
    echo "Repository: $GITHUB_REPOSITORY" >> build-report.txt
    echo "Branch: $GITHUB_REF" >> build-report.txt
    echo "Commit: $GITHUB_SHA" >> build-report.txt
    echo "Actor: $GITHUB_ACTOR" >> build-report.txt
    echo "Run Number: $GITHUB_RUN_NUMBER" >> build-report.txt
    echo "Runner OS: $RUNNER_OS" >> build-report.txt
    echo "Python Version: ${{ matrix.python-version }}" >> build-report.txt
```

The reports are uploaded using unique artifact names:

```yaml
- name: Upload Build Report
  uses: actions/upload-artifact@v4
  with:
    name: build-report-python-${{ matrix.python-version }}
    path: build-report.txt
```

Generated artifacts:

```text
build-report-python-3.10
build-report-python-3.11
build-report-python-3.12
```

Unique names prevent matrix jobs from attempting to upload artifacts with the same name.

---

## Docker Image Build

The Docker build job starts only after every Python matrix execution completes successfully.

```yaml
docker-build:
  name: Docker Image Build
  needs: python-check
  runs-on: ubuntu-latest
```

The dependency is configured using:

```yaml
needs: python-check
```

If any required Python matrix job fails, the Docker build job is skipped.

---

## Resilient Docker Build

The Docker image build uses a retry loop to handle temporary failures such as network or registry timeouts.

```yaml
- name: Build Docker Image
  timeout-minutes: 10
  run: |
    for attempt in {1..3}; do
      echo "Docker build attempt $attempt/3"

      if docker build \
        -t company-server:${{ github.sha }} \
        -t company-server:latest \
        projects/company-server/web-app; then
        echo "Docker image built successfully."
        exit 0
      fi

      if [ "$attempt" -lt 3 ]; then
        echo "Docker build failed. Retrying in 15 seconds..."
        sleep 15
      fi
    done

    echo "Docker build failed after 3 attempts."
    exit 1
```

### Retry Behavior

```text
Build Attempt 1
      │
      ├── Success → Continue Pipeline
      │
      └── Failure
              │
              ▼
        Wait 15 Seconds
              │
              ▼
        Build Attempt 2
              │
              ├── Success → Continue Pipeline
              │
              └── Failure
                      │
                      ▼
                Build Attempt 3
                      │
                      ├── Success → Continue Pipeline
                      └── Failure → Job Fails
```

The job-level timeout prevents the build from running indefinitely:

```yaml
timeout-minutes: 10
```

---

## Docker Image Tags

The image receives two tags:

```yaml
-t company-server:${{ github.sha }}
-t company-server:latest
```

### Commit SHA Tag

```text
company-server:<commit-sha>
```

This tag connects the image to the exact source-code commit used to build it.

### Latest Tag

```text
company-server:latest
```

This provides a convenient name for the most recently built local image.

Example result:

```text
REPOSITORY       TAG                                        IMAGE ID
company-server   b8901c8b92c1ee9cf4f471f6fdcfd78c0ca508f1   b5b2b3b951f3
company-server   latest                                     b5b2b3b951f3
```

Both tags point to the same image ID because they identify the same image produced during the workflow run.

---

## Integration Test Job

The integration test begins only after the Docker image build job passes.

```yaml
integration-test:
  name: Docker Compose Integration Test
  needs: docker-build
  runs-on: ubuntu-latest
```

The integration test performs the following stages:

```text
Checkout Repository
        │
        ▼
Validate Compose File
        │
        ▼
Build and Start Application
        │
        ▼
Wait for Healthy Container
        │
        ▼
Verify Health Endpoint
        │
        ▼
Show Status and Logs
        │
        ▼
Stop and Remove Resources
```

---

## Runner Isolation Between Jobs

Every GitHub-hosted job runs on a separate runner.

Therefore:

```text
docker-build
└── Runner A

integration-test
└── Runner B
```

The Docker image built in `docker-build` is not automatically available inside `integration-test`.

The `needs` keyword controls execution order, but it does not share:

- Docker images
- Files
- Running containers
- Filesystem state
- Installed software

Because the Compose service contains:

```yaml
build: .
```

the integration test builds the application image again on its own runner before starting the container.

This is acceptable for the current learning pipeline. A future production-oriented pipeline could publish the image to a container registry or transfer it between jobs so the exact same image is tested and deployed.

---

## Docker Compose Validation

Before starting the application, the workflow validates the Compose configuration.

```yaml
- name: Validate Compose File
  run: |
    docker compose \
      -f projects/company-server/web-app/compose.yaml \
      config
```

This command:

- Parses the Compose file.
- Resolves the configuration.
- Detects invalid Compose syntax.
- Displays the final normalized configuration.
- Does not start containers.

---

## Application Health Check

The Compose service defines a health check using Python's standard library.

```yaml
healthcheck:
  test:
    - CMD
    - python
    - -c
    - |
      import urllib.request

      response = urllib.request.urlopen(
          "http://localhost:5000/health",
          timeout=3,
      )

      assert response.status == 200
  interval: 5s
  timeout: 3s
  retries: 12
  start_period: 5s
```

### Health-Check Configuration

| Option | Purpose |
|---|---|
| `test` | Command used to determine application health |
| `interval: 5s` | Runs the health check every five seconds |
| `timeout: 3s` | Fails an individual check after three seconds |
| `retries: 12` | Allows multiple failed checks before marking the container unhealthy |
| `start_period: 5s` | Gives the application initial startup time |

Python is used instead of `curl` inside the container because Python is already included in the application image.

---

## Start Application and Wait for Health

The integration test builds and starts the Compose service:

```yaml
- name: Start Application
  timeout-minutes: 10
  run: |
    docker compose \
      -f projects/company-server/web-app/compose.yaml \
      up --build --wait --wait-timeout 90
```

### Option Explanation

| Option | Purpose |
|---|---|
| `up` | Creates and starts the services |
| `--build` | Builds service images before starting containers |
| `--wait` | Waits until services are running or healthy |
| `--wait-timeout 90` | Stops waiting after 90 seconds |

This is more reliable than using a fixed command such as:

```bash
sleep 10
```

A fixed delay does not know whether the application is actually ready. The Compose health check waits for the real application state.

---

## Verify Health Endpoint

After Docker reports that the container is healthy, the workflow sends a request through the published host port:

```yaml
- name: Verify Health Endpoint
  run: |
    response="$(
      curl \
        --fail \
        --silent \
        --show-error \
        http://localhost:8080/health
    )"

    echo "$response"
    echo "$response" | grep -Eq '"status"[[:space:]]*:[[:space:]]*"healthy"'
    echo "Health endpoint validation passed."
```

The Compose port mapping is:

```yaml
ports:
  - "8080:5000"
```

This means:

```text
GitHub Runner Port 8080
          │
          ▼
Container Port 5000
          │
          ▼
Flask Application
```

Expected response:

```json
{
  "application": "Company Server",
  "status": "healthy",
  "version": "1.0.0"
}
```

The test checks two conditions:

1. The endpoint returns a successful HTTP response.
2. The response body contains a healthy status.

---

## Container Diagnostics

The workflow displays container status after the integration test.

```yaml
- name: Show Container Status
  if: always()
  run: |
    docker compose \
      -f projects/company-server/web-app/compose.yaml \
      ps
```

Example:

```text
NAME                 IMAGE         SERVICE   STATUS       PORTS
company-server-web   web-app-web   web       Up (healthy) 0.0.0.0:8080->5000/tcp
```

The workflow also collects application logs:

```yaml
- name: Show Container Logs
  if: always()
  run: |
    docker compose \
      -f projects/company-server/web-app/compose.yaml \
      logs
```

Example:

```text
Starting gunicorn 23.0.0
Listening at: http://0.0.0.0:5000
Using worker: sync
Booting worker
```

Status and logs help diagnose startup or health-check failures.

---

## Automatic Cleanup

The final step stops and removes temporary Compose resources.

```yaml
- name: Stop Containers
  if: always()
  run: |
    docker compose \
      -f projects/company-server/web-app/compose.yaml \
      down --volumes --remove-orphans
```

### Cleanup Options

| Option | Purpose |
|---|---|
| `down` | Stops and removes Compose containers and networks |
| `--volumes` | Removes volumes created by the Compose project |
| `--remove-orphans` | Removes containers no longer defined in the Compose file |

The condition:

```yaml
if: always()
```

ensures that cleanup runs even when an earlier step fails.

Without automatic cleanup, failed workflow steps could leave temporary containers, networks, or volumes active until the hosted runner is destroyed.

---

## Secrets Demonstration

The workflow contains an independent job demonstrating secure access to repository secrets.

```yaml
secret-demo:
  name: GitHub Secrets Demo
  runs-on: ubuntu-latest
```

The values are loaded as step-level environment variables:

```yaml
env:
  DEMO_USERNAME: ${{ secrets.DEMO_USERNAME }}
  DEMO_MESSAGE: ${{ secrets.DEMO_MESSAGE }}
```

The workflow confirms that they were loaded by displaying their lengths instead of their actual values.

This avoids intentionally exposing credentials in workflow logs.

---

## Job Dependency Flow

The main validation chain is:

```text
python-check
      │
      ▼
docker-build
      │
      ▼
integration-test
```

The dependency configuration is:

```yaml
docker-build:
  needs: python-check

integration-test:
  needs: docker-build
```

### Failure Behavior

If Python validation fails:

```text
Python Validation       ❌ Failed
Docker Image Build      ⏭ Skipped
Integration Test        ⏭ Skipped
```

If the Docker build fails:

```text
Python Validation       ✅ Passed
Docker Image Build      ❌ Failed
Integration Test        ⏭ Skipped
```

If the application does not become healthy:

```text
Python Validation       ✅ Passed
Docker Image Build      ✅ Passed
Integration Test        ❌ Failed
Status, Logs, Cleanup   ✅ Executed
```

---

## Practical Scenario

During this lab, the repository workflow was upgraded from separate validation tasks into a complete container integration pipeline.

The workflow successfully:

1. Validated Markdown documentation.
2. Tested the application using Python 3.10, 3.11, and 3.12.
3. Restored pip dependency caches.
4. Compiled the Flask application.
5. Generated three build-report artifacts.
6. Built and tagged the Docker image.
7. Validated the Docker Compose configuration.
8. Built and started the Compose service.
9. Waited for the container to become healthy.
10. Requested the `/health` endpoint through port `8080`.
11. Confirmed that the response contained `"status": "healthy"`.
12. Displayed the container status and Gunicorn logs.
13. Removed the container and Compose network.

A temporary Docker Hub connection timeout caused the first Docker image build to fail.

The failed job was rerun, and the build completed successfully. A retry loop was then added to make the Docker build more resilient to temporary network or registry failures.

Successful health response:

```json
{"application":"Company Server","status":"healthy","version":"1.0.0"}
```

Successful container status:

```text
company-server-web   web-app-web   Up   0.0.0.0:8080->5000/tcp
```

Successful application logs:

```text
Starting gunicorn 23.0.0
Listening at: http://0.0.0.0:5000
Using worker: sync
Booting worker
```

Successful cleanup:

```text
Container company-server-web Removed
Network web-app_default Removed
```

This demonstrated that the application could be validated, built, started, tested, inspected, and cleaned up automatically by GitHub Actions.

---

## What This Pipeline Validates

| Pipeline Stage | Validation Performed |
|---|---|
| Documentation Check | Confirms Markdown documentation exists |
| Python Matrix | Tests Python syntax and dependencies across three versions |
| Pip Cache | Reuses downloaded packages between workflow runs |
| Build Reports | Preserves workflow metadata as artifacts |
| Docker Build | Confirms that the Dockerfile can build successfully |
| Compose Validation | Confirms that `compose.yaml` is valid |
| Container Health Check | Confirms that the application starts inside the container |
| Endpoint Test | Confirms that the `/health` endpoint returns a healthy response |
| Container Status | Displays runtime state and port mapping |
| Container Logs | Provides startup and error diagnostics |
| Cleanup | Removes temporary containers, networks, and volumes |

---

## Interview Questions

### What is a complete CI pipeline?

A complete CI pipeline automatically validates an application through multiple stages, including source validation, dependency installation, builds, tests, runtime verification, and artifact generation.

---

### What is the difference between syntax validation and integration testing?

Syntax validation confirms that source code can be parsed or compiled.

Integration testing starts the application and verifies that its components work together correctly in a realistic runtime environment.

---

### Why use a matrix strategy?

A matrix strategy validates the same application using multiple runtime versions or environments without duplicating the entire job definition.

---

### What does `needs` do?

The `needs` keyword creates a dependency between jobs.

A dependent job waits for its required job to complete successfully before it starts.

---

### Does `needs` share files or Docker images between jobs?

No.

It controls job order but does not share runner state, files, Docker images, or containers.

Artifacts, caches, or external registries are required when data must be transferred between jobs.

---

### Why does the integration test build the Docker image again?

The integration test runs on a separate runner from the Docker build job.

Because the image created on the first runner is not available on the second runner, Docker Compose builds the service image again using the Compose `build` configuration.

---

### Why use a container health check?

A health check determines whether the application inside a running container is ready to serve requests.

A running container is not necessarily a healthy application.

---

### Why use `docker compose up --wait`?

It waits for services to reach their running or healthy state instead of relying on an arbitrary fixed delay.

---

### Why verify the endpoint after Docker reports the container as healthy?

The endpoint test validates the complete path from the GitHub runner through the published host port to the application inside the container.

It also confirms that the response body contains the expected application status.

---

### Why use `if: always()`?

It ensures diagnostic and cleanup steps run even when an earlier step fails.

This is especially useful for displaying logs and removing temporary resources.

---

### Why retry a Docker build?

Temporary network or registry failures can interrupt a valid build.

A limited retry loop allows transient failures to recover while still failing the job after the configured number of attempts.

---

### Why tag an image with the commit SHA?

The commit SHA provides traceability between a Docker image and the exact source-code version used to build it.

---

### Does this workflow deploy the application?

No.

It is a Continuous Integration pipeline. It validates the application but does not publish the image or deploy it to a permanent environment.

Deployment will be introduced in a later Continuous Delivery or Continuous Deployment stage.

---

## Common Mistakes

- Assuming jobs share the same runner.
- Assuming `needs` transfers Docker images between jobs.
- Using only `sleep` to wait for application readiness.
- Checking only whether a container is running instead of whether the application is healthy.
- Forgetting to expose the correct host port.
- Testing container port `5000` from the runner instead of published port `8080`.
- Forgetting `--build` when Compose must build the service image.
- Omitting a timeout and allowing a job to run indefinitely.
- Forgetting to collect logs after a failed test.
- Forgetting `if: always()` on cleanup steps.
- Printing secret values into workflow logs.
- Using the same artifact name across every matrix job.
- Assuming successful Python compilation replaces unit and integration tests.

---

## Current Limitations

The pipeline is complete for the current learning stage, but several future improvements are possible:

- Add real Python unit tests using `pytest`.
- Add Markdown linting instead of only listing Markdown files.
- Add YAML linting for workflow and Compose files.
- Add Dockerfile linting.
- Add dependency vulnerability scanning.
- Add container image security scanning.
- Avoid building the Docker image twice.
- Push the image to GitHub Container Registry or Docker Hub.
- Pin third-party Actions to full commit SHAs.
- Define explicit workflow permissions.
- Add deployment environments and approval rules.
- Deploy the validated image to a cloud platform.

---

## What I Learned

- How multiple CI jobs form a dependency chain.
- How Matrix Strategy validates multiple Python versions.
- How dependency caching improves workflow efficiency.
- How artifacts preserve generated workflow outputs.
- How Docker images are built and tagged in CI.
- How temporary registry failures can be handled with retries.
- How Docker Compose validates and starts an application.
- How container health checks determine application readiness.
- How to test a containerized endpoint from a GitHub-hosted runner.
- How container status and logs help diagnose failures.
- How `if: always()` ensures diagnostics and cleanup execute.
- How GitHub-hosted jobs remain isolated from one another.
- How CI differs from deployment.

---

## Notes

This lab completes the main Continuous Integration pipeline for the GitHub Actions module.

The workflow now validates both the source code and the running containerized application.

Although the workflow builds the application image in both the Docker build and integration-test jobs, this behavior demonstrates an important GitHub Actions concept: separate jobs use separate runners and do not automatically share Docker images.

Future pipeline improvements can publish the image to a registry and reuse the exact same image across testing and deployment stages.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git add projects/company-server/web-app/compose.yaml
git add docs/github-actions/github-actions-complete-ci-pipeline.md

git commit -m "ci: complete container integration pipeline"

git push
```