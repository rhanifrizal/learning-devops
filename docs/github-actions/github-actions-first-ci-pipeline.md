# GitHub Actions First CI Pipeline

## Objective

Build a practical Continuous Integration (CI) pipeline using GitHub Actions that automatically validates the repository whenever code is pushed or a pull request is created.

Learn how multiple jobs work together to perform documentation validation, Python syntax checking, and Docker Compose configuration validation.

---

## CI Pipeline Overview

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├──────────────┬───────────────────┬────────────────────┐
    ▼              ▼                   ▼
Documentation   Python             Docker Compose
Validation      Validation         Validation
    │              │                   │
    └──────────────┴───────────────────┘
                   │
                   ▼
            Workflow Passed ✅
```

---

## Why Continuous Integration?

Continuous Integration automatically validates software every time developers push new code.

Instead of waiting until deployment to discover problems, CI immediately verifies that the project still builds correctly and basic quality checks pass.

Benefits include:

- Early bug detection
- Faster developer feedback
- Consistent build process
- Reduced deployment risk
- Higher software quality
- Better team collaboration

---

## CI Pipeline Used in This Repository

This repository currently performs three independent validation jobs.

```text
Push / Pull Request
        │
        ▼
Checkout Repository
        │
        ▼
┌────────────────────────────────────────────┐
│ Documentation Check                        │
│ └── Verify Markdown files                  │
└────────────────────────────────────────────┘

┌────────────────────────────────────────────┐
│ Python Validation                          │
│ ├── Setup Python                           │
│ ├── Install Dependencies                   │
│ └── Compile Flask Application              │
└────────────────────────────────────────────┘

┌────────────────────────────────────────────┐
│ Docker Compose Validation                  │
│ └── Validate compose.yaml                  │
└────────────────────────────────────────────┘

                │
                ▼
          Pipeline Complete
```

---

## Workflow File Location

GitHub automatically detects workflow files stored inside:

```text
.github/
└── workflows/
    └── ci.yml
```

Whenever a configured event occurs, GitHub starts executing the workflow.

---

## Current Workflow

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
      - uses: actions/checkout@v4

      - run: find . -name "*.md"

  python-check:
    name: Python Validation
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - run: pip install -r projects/company-server/web-app/requirements.txt

      - run: python -m py_compile projects/company-server/web-app/app.py

  docker-check:
    name: Docker Compose Validation
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - run: docker compose -f projects/company-server/web-app/compose.yaml config
```

---

## Workflow Breakdown

### Documentation Check

Purpose:

- Checks out the repository.
- Searches for Markdown files.
- Confirms documentation exists.

---

### Python Validation

Purpose:

- Installs Python.
- Installs project dependencies.
- Compiles the Flask application.
- Detects syntax errors before deployment.

Command executed:

```bash
python -m py_compile projects/company-server/web-app/app.py
```

---

### Docker Compose Validation

Purpose:

- Validates the Docker Compose configuration.
- Ensures the compose file has valid syntax.
- Does not start any containers.

Command executed:

```bash
docker compose -f projects/company-server/web-app/compose.yaml config
```

---

## Practical Scenario

During this lab, I upgraded my existing GitHub Actions workflow into a multi-job Continuous Integration pipeline.

The workflow automatically runs whenever code is pushed to the `main` branch or when a pull request is created.

The pipeline now performs three independent validation jobs:

- Documentation validation
- Python syntax validation
- Docker Compose validation

To understand how CI behaves during failures, I intentionally introduced a Python syntax error into the Flask application.

The Python Validation job immediately failed while the Documentation Check and Docker Compose Validation jobs continued to pass independently.

After fixing the syntax error and pushing another commit, the workflow executed successfully and all jobs passed.

This exercise demonstrated how Continuous Integration detects problems early and prevents broken code from reaching production.

---

## Successful Pipeline

```text
CI Pipeline

✔ Documentation Check

✔ Python Validation

✔ Docker Compose Validation

Workflow Passed
```

---

## Failed Pipeline

```text
CI Pipeline

✔ Documentation Check

✖ Python Validation

✔ Docker Compose Validation

Workflow Failed
```

---

## What I Learned

- GitHub automatically provisions a fresh runner for every job.
- Jobs execute independently.
- Steps execute sequentially inside each job.
- Python syntax can be validated without running the application.
- Docker Compose files can be validated without starting containers.
- CI provides immediate feedback whenever new code is pushed.

---

## Interview Questions

### What is a CI pipeline?

A CI pipeline is an automated workflow that validates source code after every commit by running builds, tests, and quality checks before code is merged or deployed.

---

### Why is CI important?

CI detects problems early, reduces integration issues, provides rapid feedback, and improves software quality.

---

### Why did only one job fail while the others succeeded?

Each GitHub Actions job runs independently on its own runner.

A failure in one job does not automatically stop unrelated jobs unless dependencies are explicitly configured.

---

### Why use `python -m py_compile`?

It validates Python syntax without executing the application, allowing CI to detect syntax errors quickly.

---

### Does `docker compose config` start containers?

No.

It only validates the Docker Compose configuration file.

---

### Why does every job perform `actions/checkout`?

Each job runs on a brand-new runner.

The repository must be downloaded separately for every job.

---

## Common Mistakes

- Forgetting to checkout the repository.
- Incorrect YAML indentation.
- Installing dependencies from the wrong directory.
- Assuming jobs share the same runner.
- Forgetting that every job starts with a clean environment.
- Confusing syntax validation with application testing.

---

## Notes

This repository now contains a production-style Continuous Integration pipeline built with GitHub Actions.

Although the current pipeline performs only validation tasks, it establishes the foundation for future CI/CD workflows.

Upcoming labs will extend this pipeline to automatically build Docker images, execute application tests, cache dependencies, publish artifacts, and deploy applications to cloud environments.

---

## Commands Used

```bash
git add .
git commit -m "ci: add multi-job validation pipeline"
git push

git switch -c test/ci-python-failure

python3 -m py_compile projects/company-server/web-app/app.py

git push

git switch main

git branch -d test/ci-python-failure

git push origin --delete test/ci-python-failure
```