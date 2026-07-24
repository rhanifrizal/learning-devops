# GitHub Actions Environment Variables

## Objective

Learn how environment variables work in GitHub Actions, understand workflow-level, job-level, and step-level scope, use GitHub's default environment variables, and remove hardcoded configuration values from CI workflows.

---

## What Are Environment Variables?

Environment variables are named values used to store configuration that applications, scripts, and workflow steps can access during execution.

Example:

```text
PYTHON_VERSION=3.12
APP_NAME=Company Server
APP_ENVIRONMENT=Development
```

Instead of repeating the same value throughout a workflow, the value can be defined once and reused where needed.

---

## Why Use Environment Variables?

Reasons for using environment variables:

1. Avoid Hardcoded Values: Configuration is stored separately from commands.
2. Easier Maintenance: A value can be updated in one location.
3. Improved Readability: Variables give configuration values meaningful names.
4. Reusability: The same value can be used across multiple jobs and steps.
5. Environment Flexibility: Different values can be used for development, testing, staging, and production.

---

## Environment Variable Scope

GitHub Actions supports environment variables at three main levels:

1. Workflow level
2. Job level
3. Step level

The scope determines where a variable is available.

---

## Workflow-Level Variables

A workflow-level variable is available to every job and step in the workflow.

Example:

```yaml
name: CI Pipeline

env:
  PYTHON_VERSION: "3.12"

jobs:
  python-check:
    runs-on: ubuntu-latest

    steps:
      - name: Display Python Version
        run: echo "Python version is $PYTHON_VERSION"
```

In this example, `PYTHON_VERSION` can be accessed by all jobs in the workflow.

### When to Use

- Runtime versions
- Application names
- Shared file paths
- Common configuration values
- Values required by multiple jobs

---

## Job-Level Variables

A job-level variable is available only to the steps inside a specific job.

Example:

```yaml
jobs:
  python-check:
    runs-on: ubuntu-latest

    env:
      APP_NAME: "Company Server"

    steps:
      - name: Display Application Name
        run: echo "Application: $APP_NAME"
```

Other jobs cannot access `APP_NAME` unless it is defined again or moved to workflow scope.

### When to Use

- Configuration needed by only one job
- Job-specific paths
- Build configuration
- Testing configuration

---

## Step-Level Variables

A step-level variable is available only to one specific step.

Example:

```yaml
steps:
  - name: Display Message
    env:
      MESSAGE: "Environment variable test"
    run: echo "$MESSAGE"
```

After that step finishes, later steps cannot access `MESSAGE` unless it is defined again.

### When to Use

- Temporary values
- Command-specific configuration
- Values required by only one tool or script

---

## Variable Precedence

When the same variable name is defined at multiple levels, the most specific value is used.

Precedence order:

```text
Step Level
    │
    ▼
Job Level
    │
    ▼
Workflow Level
```

Example:

```yaml
env:
  APP_ENVIRONMENT: "Development"

jobs:
  test:
    env:
      APP_ENVIRONMENT: "Testing"

    steps:
      - name: Display Job Value
        run: echo "$APP_ENVIRONMENT"

      - name: Display Step Value
        env:
          APP_ENVIRONMENT: "Temporary"
        run: echo "$APP_ENVIRONMENT"
```

Output:

```text
Testing
Temporary
```

The job-level value overrides the workflow-level value, while the step-level value overrides both.

---

## Using the `env` Context

Custom environment variables can be referenced using the GitHub Actions `env` context.

Example:

```yaml
with:
  python-version: ${{ env.PYTHON_VERSION }}
```

The expression:

```text
${{ env.PYTHON_VERSION }}
```

is evaluated by GitHub Actions before the job step is sent to the runner.

---

## Using Shell Environment Variables

Inside a `run` command, environment variables can normally be accessed using shell syntax.

On Linux runners:

```bash
echo "$PYTHON_VERSION"
echo "$GITHUB_REPOSITORY"
echo "$RUNNER_OS"
```

On Windows PowerShell runners, the syntax is different:

```powershell
echo $env:PYTHON_VERSION
```

The correct syntax depends on the shell and operating system used by the runner.

---

## GitHub Expressions vs Shell Variables

GitHub Actions supports two common ways to access values.

### GitHub Expression Syntax

```yaml
${{ env.PYTHON_VERSION }}
```

GitHub evaluates this expression before the command executes on the runner.

Common uses include:

```yaml
with:
  python-version: ${{ env.PYTHON_VERSION }}
```

---

### Shell Variable Syntax

```bash
$PYTHON_VERSION
```

The shell expands this value while the command runs on the runner.

Example:

```yaml
run: echo "Python Version: $PYTHON_VERSION"
```

---

## Syntax Comparison

| Syntax | Evaluated By | Common Location |
|--------|--------------|-----------------|
| `${{ env.PYTHON_VERSION }}` | GitHub Actions expression engine | YAML configuration and action inputs |
| `$PYTHON_VERSION` | Linux shell on the runner | `run` commands |
| `$env:PYTHON_VERSION` | PowerShell | Windows `run` commands |

---

## Default GitHub Environment Variables

GitHub automatically provides environment variables containing information about the workflow run, repository, commit, and runner.

Common examples:

| Variable | Purpose |
|----------|---------|
| `GITHUB_WORKFLOW` | Name of the current workflow |
| `GITHUB_REPOSITORY` | Repository owner and repository name |
| `GITHUB_REF` | Branch or tag reference that triggered the workflow |
| `GITHUB_SHA` | Commit SHA that triggered the workflow |
| `GITHUB_ACTOR` | User or application that triggered the workflow |
| `GITHUB_RUN_NUMBER` | Sequential workflow run number |
| `GITHUB_JOB` | ID of the current job |
| `RUNNER_NAME` | Name assigned to the runner |
| `RUNNER_OS` | Operating system of the runner |
| `RUNNER_ARCH` | Processor architecture of the runner |

These variables are provided automatically and do not need to be manually defined.

---

## Current Workflow Configuration

This repository defines the Python version at workflow level:

```yaml
env:
  PYTHON_VERSION: "3.12"
```

The value is then passed to `actions/setup-python`:

```yaml
- name: Setup Python
  uses: actions/setup-python@v5
  with:
    python-version: ${{ env.PYTHON_VERSION }}
    cache: "pip"
    cache-dependency-path: projects/company-server/web-app/requirements.txt
```

This removes the need to hardcode the Python version directly inside the setup step.

---

## Displaying Environment Variables

The workflow includes a step that displays both a custom environment variable and default GitHub variables:

```yaml
- name: Display Environment Variables
  run: |
    echo "Configured Python Version: ${{ env.PYTHON_VERSION }}"
    echo "Runner OS: $RUNNER_OS"
    echo "Repository: $GITHUB_REPOSITORY"
```

This demonstrates two methods:

```text
Custom Workflow Variable
${{ env.PYTHON_VERSION }}

Default Runner Variable
$RUNNER_OS

Default GitHub Variable
$GITHUB_REPOSITORY
```

---

## Build Report

The workflow generates a build report containing metadata from the workflow execution:

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
    echo "Python Version: ${{ env.PYTHON_VERSION }}" >> build-report.txt
```

The report is then uploaded using:

```yaml
- name: Upload Build Report
  uses: actions/upload-artifact@v4
  with:
    name: build-report
    path: build-report.txt
```

---

## Practical Scenario

During this lab, I replaced the hardcoded Python version in the CI workflow with a workflow-level environment variable.

The variable was defined using:

```yaml
env:
  PYTHON_VERSION: "3.12"
```

The Python setup step accessed it using:

```yaml
python-version: ${{ env.PYTHON_VERSION }}
```

The workflow also used several default GitHub and runner variables to create a detailed build report.

Generated report:

```text
Python validation completed successfully.
Workflow: CI Pipeline
Repository: rhanifrizal/learning-devops
Branch: refs/heads/main
Commit: 9879122318ee74b0bf23ecc279a31010995344ff
Actor: rhanifrizal
Run Number: 18
Runner OS: Linux
Python Version: 3.12
```

This confirmed that custom environment variables and GitHub-provided variables were available during workflow execution.

---

## Environment Variables vs Configuration Variables

Environment variables defined with `env` exist within the workflow configuration.

Example:

```yaml
env:
  PYTHON_VERSION: "3.12"
```

GitHub also supports repository, organization, and environment configuration variables.

These are accessed through the `vars` context:

```yaml
${{ vars.PYTHON_VERSION }}
```

Configuration variables are useful when values need to be managed through GitHub settings rather than stored directly in the workflow file.

---

## Environment Variables vs Secrets

Environment variables are suitable for non-sensitive configuration such as:

```text
PYTHON_VERSION
APP_NAME
BUILD_ENVIRONMENT
LOG_LEVEL
```

Sensitive values should not be stored directly in workflow files.

Examples of sensitive values include:

```text
API tokens
Passwords
Cloud credentials
Docker registry tokens
Private keys
```

Sensitive values should be stored using GitHub Secrets and accessed through:

```yaml
${{ secrets.SECRET_NAME }}
```

GitHub Secrets will be covered in the next lab.

---

## Interview Questions

### What is an environment variable?

An environment variable is a named configuration value available to a process, application, or workflow during execution.

---

### What environment variable scopes are available in GitHub Actions?

Environment variables can be defined at:

1. Workflow level
2. Job level
3. Step level

---

### What happens when the same variable is defined at multiple levels?

The most specific definition takes precedence.

A step-level value overrides a job-level value, and a job-level value overrides a workflow-level value.

---

### What is the difference between `${{ env.VARIABLE }}` and `$VARIABLE`?

`${{ env.VARIABLE }}` is evaluated by the GitHub Actions expression engine.

`$VARIABLE` is expanded by the shell while a command executes on the runner.

---

### What is `GITHUB_SHA`?

`GITHUB_SHA` contains the commit SHA associated with the workflow run.

---

### What is `GITHUB_REF`?

`GITHUB_REF` contains the full Git reference for the branch or tag that triggered the workflow.

Example:

```text
refs/heads/main
```

---

### Why use environment variables instead of hardcoded values?

Environment variables improve maintainability, reuse, readability, and configuration flexibility.

---

### Should passwords be stored in environment variables inside the workflow file?

No.

Sensitive values should be stored as GitHub Secrets and referenced through the `secrets` context.

---

## Common Mistakes

- Hardcoding repeated configuration values throughout a workflow.
- Confusing GitHub expression syntax with shell variable syntax.
- Using Linux shell syntax in Windows PowerShell jobs.
- Defining a variable at step level and expecting other steps to access it.
- Assuming GitHub's default variables exist inside the `env` context.
- Storing passwords or tokens directly in workflow YAML.
- Forgetting that variable names are case-sensitive.
- Accidentally printing sensitive values into workflow logs.

---

## Notes

This repository now uses a workflow-level environment variable to configure Python 3.12.

The CI workflow also uses GitHub-provided variables to record:

- Workflow name
- Repository
- Branch reference
- Commit SHA
- Actor
- Run number
- Runner operating system
- Configured Python version

The generated information is stored in a build report and uploaded as a workflow artifact.

This lab prepares the workflow for the next topic: securely managing sensitive configuration using GitHub Secrets.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: demonstrate GitHub Actions environment variables"
git push
```