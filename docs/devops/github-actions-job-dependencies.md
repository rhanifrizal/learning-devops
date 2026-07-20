# GitHub Actions Job Dependencies

## Objective

Learn how to control the execution order of GitHub Actions jobs using the `needs` keyword and understand how job dependencies prevent downstream jobs from running when required validation jobs fail.

## What Are Job Dependencies?

Job dependencies define the order in which jobs execute inside a GitHub Actions workflow.

By default, jobs run independently and usually start in parallel. The `needs` keyword creates a dependency between jobs and forces one job to wait for another job to complete successfully.

Example:

```yaml
docker-check:
  needs: python-check
```

This means the `docker-check` job will only start after the `python-check` job completes successfully.

## Why Job Dependencies Matter

Job dependencies are important because many CI/CD tasks must happen in a specific order.

For example:

```text
Build Application
        │
        ▼
Run Tests
        │
        ▼
Build Docker Image
        │
        ▼
Push Docker Image
        │
        ▼
Deploy Application
```

A deployment should not begin if the application build or tests fail.

Using job dependencies helps to:

1. Prevent invalid downstream tasks from running.
2. Reduce unnecessary runner usage.
3. Save CI execution time.
4. Protect deployment environments.
5. Create predictable pipeline execution order.

## Parallel Jobs vs Dependent Jobs

### Parallel Jobs

Without `needs`, jobs execute independently.

```text
Push / Pull Request
        │
        ├──────────────┬──────────────────┐
        ▼              ▼                  ▼
Documentation      Python             Docker Compose
Check              Validation         Validation
```

A failure in the Python job does not stop the Docker Compose job because they are unrelated.

### Dependent Jobs

With `needs: python-check`, Docker Compose validation waits for Python validation.

```text
Push / Pull Request
        │
        ├───────────────────────┐
        ▼                       ▼
Documentation Check       Python Validation
                                  │
                                  ▼
                         Docker Compose Validation
```

If Python validation fails, Docker Compose validation is skipped.

## The `needs` Keyword

The `needs` keyword is added at the job level.

Example:

```yaml
jobs:
  python-check:
    runs-on: ubuntu-latest

    steps:
      - run: python -m py_compile app.py

  docker-check:
    needs: python-check
    runs-on: ubuntu-latest

    steps:
      - run: docker compose config
```

In this workflow:

1. `python-check` starts first.
2. `docker-check` waits.
3. If `python-check` passes, `docker-check` starts.
4. If `python-check` fails, `docker-check` is skipped.

## Multiple Job Dependencies

A job can depend on more than one previous job.

Example:

```yaml
deploy:
  needs:
    - python-check
    - docker-check
```

The `deploy` job will only run after both required jobs complete successfully.

```text
Python Validation ───────┐
                         ├──► Deploy
Docker Validation ───────┘
```

This is useful when deployment requires several checks to pass.

## Workflow Used in This Repository

The repository CI workflow is stored at:

```text
.github/
└── workflows/
    └── ci.yml
```

The current job structure is:

```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main

  pull_request:
    branches:
      - main

jobs:
  docs-check:
    name: Documentation Check
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Verify Markdown Files
        run: find . -name "*.md"

  python-check:
    name: Python Validation
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Install Dependencies
        run: pip install -r projects/company-server/web-app/requirements.txt

      - name: Compile Python
        run: python -m py_compile projects/company-server/web-app/app.py

  docker-check:
    name: Docker Compose Validation
    needs: python-check
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Validate Compose File
        run: docker compose -f projects/company-server/web-app/compose.yaml config
```

## Current Execution Flow

```text
Push / Pull Request
        │
        ├──────────────────────────────┐
        ▼                              ▼
Documentation Check             Python Validation
                                        │
                                        ▼
                               Docker Compose Validation
```

The documentation job remains independent and starts immediately.

The Docker Compose job waits for Python validation because of:

```yaml
needs: python-check
```

## Successful Pipeline

When Python validation passes:

```text
Documentation Check         ✅ Passed

Python Validation           ✅ Passed
        │
        ▼
Docker Compose Validation   ✅ Passed
```

## Failed Pipeline

When Python validation fails:

```text
Documentation Check         ✅ Passed

Python Validation           ❌ Failed
        │
        ▼
Docker Compose Validation   ⏭ Skipped
```

The Docker Compose job is skipped because its required dependency did not complete successfully.

## Practical Scenario

During this lab, I updated the repository's GitHub Actions CI pipeline by adding a dependency between the Python Validation job and the Docker Compose Validation job.

Before the change, all three jobs started independently. This meant Docker Compose validation still ran even when the Python application contained a syntax error.

After adding:

```yaml
needs: python-check
```

the Docker Compose job waited for Python validation to complete.

I tested the workflow by introducing a Python syntax error in a temporary branch. The Python Validation job failed, and GitHub Actions automatically skipped the Docker Compose Validation job.

After fixing the syntax error, both jobs completed successfully.

This demonstrated how job dependencies can enforce pipeline order and prevent unnecessary downstream work.

## Interview Questions

### What does `needs` do in GitHub Actions?

The `needs` keyword creates a dependency between jobs.

It prevents a job from starting until its required job or jobs complete successfully.

### Do jobs run sequentially by default?

No.

Jobs run independently and usually execute in parallel unless dependencies are configured using `needs`.

### What happens when a required job fails?

A dependent job is skipped by default when one of its required jobs fails.

### Can one job depend on multiple jobs?

Yes.

A job can define multiple dependencies:

```yaml
needs:
  - build
  - test
```

The dependent job starts only after all required jobs succeed.

### What is the difference between job dependencies and steps?

Jobs can run on separate runners and are independent by default.

Steps run sequentially inside the same job and share the same runner environment.

### Why use job dependencies in CI/CD?

Job dependencies ensure that later pipeline stages only run after required validation, testing, or build stages succeed.

This reduces wasted resources and prevents invalid code from being built or deployed.

## Common Mistakes

- Assuming jobs execute sequentially by default.
- Adding `needs` under `steps` instead of at the job level.
- Using the display name of a job instead of its job ID.
- Creating unnecessary dependencies that slow down the pipeline.
- Forgetting that a dependent job is skipped when its required job fails.
- Building a circular dependency between jobs.

## Notes

This lab demonstrated how GitHub Actions builds a dependency graph from the `needs` configuration.

The repository now runs Documentation Check and Python Validation in parallel, while Docker Compose Validation waits for Python Validation to pass.

Future workflows will use job dependencies to control Docker image builds, artifact handling, publishing, and deployment tasks.

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add job dependency to workflow"
git push
```