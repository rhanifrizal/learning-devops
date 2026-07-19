# GitHub Actions Introduction

## Objective

Learn the fundamentals of GitHub Actions, understand how Continuous Integration (CI) automates software development workflows, and become familiar with the core components used to build automated pipelines.


## What is Continuous Integration (CI)?

Continuous Integration (CI) is a software development practice where developers frequently merge code changes into a shared repository. Every change automatically triggers build, testing, and validation processes to detect problems early and ensure the application remains in a deployable state.


## Why Continuous Integration?

Reason for Continuous Integration:
1. Early Bug Detection: Automated tests catch errors immediately after code commits.
2. Faster Feedback: Developers know within minutes if changes broke the build.
3. Reduced Merge Conflicts: Frequent small updates prevent painful, massive code merges.
4. Automated Builds: Eliminates manual compilation and human deployment mistakes.


## What is GitHub Actions?

GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform built directly into GitHub.


## Why GitHub Actions?

Reason for GitHub Actions:
1. Native Integration: Works seamlessly within your existing GitHub repositories.
2. Matrix Builds: Tests multiple operating systems and language versions simultaneously.
3. Huge Marketplace: Thousands of pre-built, reusable automation workflows are available.
4. Free Tier: Free minutes are provided for standard cloud-hosted runners.

## GitHub Actions Workflow Lifecycle

1. Trigger: An event occurs in the GitHub repository.
2. Initialization: GitHub detects the workflow YAML file inside `.github/workflows` and provisions a runner.
3. Execution: The runner downloads the repository code and executes jobs sequentially or in parallel.
4. Step Processing: The runner executes commands and predefined actions inside each job.
5. Reporting: Results, status badges, and execution logs are posted back to GitHub.


## Core Components

### Workflow

A workflow is an automated procedure added to your repository. It is configured via a YAML file inside the `.github/workflows` directory.


### Event (Trigger)

An event is a specific activity that starts a workflow execution. Common examples include a code push, a pull request creation, or a scheduled time.


### Runner

A runner is a server hosting the GitHub Actions runner application. It executes the steps defined in a workflow job and can be hosted by GitHub or self-hosted.


### Job

A job is a set of steps that execute on the same runner. By default, jobs run in parallel, but you can configure dependencies to make them run sequentially.


### Step

A step is an individual task that can run commands or actions. Steps within the same job execute sequentially and share data with one another.


### Action

An action is a reusable unit of automation that performs a specific task within a workflow. Actions eliminate repetitive scripting by providing pre-built functionality such as checking out source code, installing programming languages, building Docker images, or logging into cloud providers.


## Current Workflow in This Repository

Current workflow:

```text
.github/
└── workflows/
    └── markdown-check.yml
```

Workflow execution:

```text
Push to GitHub
│
▼
GitHub detects event
│
▼
Start Ubuntu Runner
│
▼
Checkout Repository
│
▼
List Repository Files
│
▼
Verify Markdown Files
│
▼
Workflow Complete
```

```yaml
name: Markdown Check

on:
  push:
  pull_request:

jobs:
  markdown-check:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - run: ls -la
      - run: find . -name "*.md"
```


## Common GitHub Actions Use Cases

Use cases:
1. Automated Testing: Runs software test suites automatically on every single code commit.
2. Code Quality Assurance: Enforces strict code formatting, linting rules, and syntax checks instantly.
3. Vulnerability Scanning: Proactively checks project source code and third-party packages for security flaws.
4. Container Build Automation: Packages source code directly into isolated Docker containers on changes.
5. Production Deployment: Ships verified code bundles straight to AWS, Microsoft Azure, or Google Cloud.
6. Release Orchestration: Drafts change logs and publishes production tags to the repository marketplace.


## GitHub Actions vs Jenkins

| Feature             | GitHub Actions                                                                  | Jenkins |
|---------------------|---------------------------------------------------------------------------------|---------|
| Hosting Model       | Fully cloud-managed infrastructure requiring zero internal maintenance overhead.| Dedicated self-hosted servers requiring active OS upgrades and patching.                  |     
| Configuration Style | Declarative configuration files written natively using clear YAML syntax.       | Programmatic build pipelines structured globally through custom Groovy script files.     |
| System Integration  | Embedded natively directly inside GitHub platforms for immediate operation.     | Dependent on explicit source control hooks and complex webhooks configuration.           |
| Extensibility Model | Ecosystem built around modular steps found inside the public GitHub Marketplace.| System extended through community plugins that require manual security audits.                |
| Operational Costs   | Free execution allocations for all public open-source software structures.      | Free open-source core application, but server infrastructure costs scale with use.|


## Practical Scenario

This repository already uses GitHub Actions to automatically validate Markdown documentation whenever code is pushed to the `main` branch or a pull request is created.

The workflow performs the following tasks:

1. Detects a push or pull request.
2. Starts an Ubuntu runner.
3. Checks out the repository.
4. Lists the repository contents.
5. Verifies that Markdown (`.md`) files exist.

Although this is a simple workflow, it demonstrates the complete GitHub Actions lifecycle and provides the foundation for more advanced CI pipelines later in this learning journey.

## Interview Questions

### What is Continuous Integration?

Continuous Integration (CI) is a DevOps software development practice.

1. Developers frequently merge code into a central repository.
2. Every merge triggers automated builds and test suites.
3. It catches bugs early in production.
4. It prevents complex downstream merge conflicts.


### What is GitHub Actions?

GitHub Actions is an automated workflow platform.

1. It handles continuous integration and delivery (CI/CD).
2. It is built natively directly into GitHub.
3. It automates testing, building, and deployments.
4. It triggers automatically based on repository events.


### What is a Workflow?

A workflow is an automated, configurable procedure.

1. It is defined in a YAML configuration file.
2. It is stored in the `.github/workflows` folder.
3. It contains one or more jobs.
4. It triggers when specific repository events occur.


### What is a Runner?

A runner is a virtual machine or physical server that executes workflow jobs.

1. It executes the tasks inside a workflow job.
2. It includes the GitHub Actions runner application.
3. It can be fully GitHub-hosted in the cloud.
4. It can be self-hosted on your own infrastructure.


### Difference between Job and Step?

A job is a collection of related steps that execute on the same runner.

A step is an individual command or action within a job.

Jobs run in parallel by default, while steps inside a job run sequentially.


### What is an Action?

An action is a reusable, modular automation block.

1. It is the smallest building block of a workflow.
2. It minimizes writing complex, repetitive shell scripts.
3. It performs common tasks like checking out repositories.
4. It is shared publicly via the GitHub Marketplace.


### Difference between GitHub Actions and Jenkins?

1. Hosting: GitHub Actions is cloud-managed by default, whereas Jenkins required dedicated self-hosted server maintenance.

2. Configuration: GitHub Actions uses standard YAML files. Jenkins relies on custom Groovy programmatic scripts.

3. Integration: GitHub Actions is built natively into repositories. Jenkins requires external plugins to connect.


## Common Mistakes

- Forgetting to place workflow files inside the `.github/workflows` directory.
- Incorrect YAML indentation causing workflow syntax errors.
- Assuming jobs execute sequentially by default.
- Forgetting to commit workflow changes before expecting them to run.
- Using repository secrets directly in workflow files instead of GitHub Secrets.


## Notes

This repository already contains a basic GitHub Actions workflow located in `.github/workflows`.

The workflow automatically runs whenever code is pushed to the `main` branch or when a pull request is opened. More advanced workflows, including testing, Docker image builds, and CI pipelines, will be implemented in later labs.

Future labs will extend this workflow to automatically build Docker images, validate Docker Compose configurations, and implement a complete Continuous Integration pipeline.


## Commands Used

```bash
git add .
git commit -m "docs: update GitHub Actions documentation"
git push
```