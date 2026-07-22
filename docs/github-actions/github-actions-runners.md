# GitHub Actions Runners

## Objective

Learn what GitHub Actions runners are, how GitHub-hosted runners execute workflows, the different runner operating systems available, and when to use GitHub-hosted or self-hosted runners.

---

## What is a Runner?

A runner is a machine that executes the jobs defined in a GitHub Actions workflow.

When a workflow is triggered, GitHub assigns a runner to execute every step inside a job.

A runner can be:

- GitHub-hosted
- Self-hosted

---

## Why Do We Need Runners?

Reasons for using runners:

1. Execute workflow jobs in an isolated environment.
2. Provide a consistent operating system and toolchain.
3. Allow workflows to run automatically without developer intervention.
4. Ensure each workflow starts from a clean environment.

---

## GitHub-Hosted Runner

A GitHub-hosted runner is a temporary virtual machine managed entirely by GitHub.

Each workflow execution receives a fresh runner that already includes many common development tools such as Git, Docker, Python, Java, Node.js, and more.

Once the workflow completes, the runner is automatically destroyed.

---

## Runner Lifecycle

```text
Workflow Trigger
        │
        ▼
Provision Runner
        │
        ▼
Checkout Repository
        │
        ▼
Execute Workflow Jobs
        │
        ▼
Upload Logs & Results
        │
        ▼
Destroy Runner
```

Every workflow starts with a brand-new runner.

No files, installed packages, or temporary data remain after the workflow finishes unless explicitly cached or uploaded as artifacts.

---

## Available GitHub-Hosted Runners

GitHub currently provides several managed runner images.

| Runner | Typical Use Case |
|----------|------------------|
| `ubuntu-latest` | Linux applications, Docker, CI pipelines |
| `windows-latest` | Windows desktop applications, .NET |
| `macos-latest` | iOS and macOS application development |

The runner is selected using:

```yaml
runs-on: ubuntu-latest
```

---

## GitHub-Hosted vs Self-Hosted Runners

| Feature | GitHub-Hosted | Self-Hosted |
|----------|---------------|-------------|
| Managed by | GitHub | Organization |
| Setup | None | Manual |
| Environment | Temporary | Persistent |
| Maintenance | None | Required |
| Scalability | Automatic | User-managed |
| Best For | CI/CD pipelines | Specialized hardware, internal networks |

---

## Current Workflow

The current repository uses the following runner configuration:

```yaml
runs-on: ubuntu-latest
```

During the Python validation job, the workflow prints information about the runner before performing application validation.

Workflow execution:

```text
Push / Pull Request
        │
        ▼
Documentation Check
        │
        ▼
Python Validation
        │
        ├── Runner Information
        ├── System Information
        ├── Setup Python
        ├── Verify Python Version
        ├── Install Dependencies
        └── Compile Python
        │
        ▼
Docker Compose Validation
```

---

## Practical Scenario

This repository uses a GitHub-hosted Ubuntu runner for every workflow execution.

The workflow prints information about the runner before validating the Flask application.

Runner Information:

```text
Runner Name: GitHub Actions 1000000082
Runner OS: Linux
Runner Architecture: X64
```

System Information:

```text
Linux runnervm3jd5f 6.17.0-1020-azure ...
Docker version 28.0.4
```

Python Version:

```text
Python 3.12.13
```

These results confirm that GitHub automatically provisioned a temporary Ubuntu virtual machine, executed the workflow, configured Python 3.12 using `actions/setup-python`, and provided Docker as part of the hosted runner environment.

---

## GitHub-Hosted Runner Characteristics

GitHub-hosted runners provide:

- Fresh virtual machine for every workflow
- Pre-installed development tools
- Automatic cleanup after execution
- Consistent execution environment
- No infrastructure maintenance

---

## Interview Questions

### What is a GitHub Actions runner?

A runner is a machine that executes jobs defined in a GitHub Actions workflow.

---

### What is the difference between a GitHub-hosted runner and a self-hosted runner?

GitHub-hosted runners are temporary virtual machines managed by GitHub, while self-hosted runners are managed by the organization and run on its own infrastructure.

---

### What does `runs-on: ubuntu-latest` mean?

It instructs GitHub Actions to execute the workflow on the latest supported Ubuntu runner image provided by GitHub.

---

### Why is each workflow executed on a fresh runner?

A fresh runner ensures workflows execute in a clean, isolated environment and prevents leftover files or configurations from previous runs affecting future executions.

---

### Why do we use caching if runners are temporary?

Because every runner starts empty.

Caching restores previously downloaded dependencies, reducing installation time during future workflow executions.

---

## Common Mistakes

- Assuming runners persist after workflow completion.
- Confusing GitHub-hosted runners with Docker containers.
- Forgetting that installed packages are lost after each workflow.
- Assuming `ubuntu-latest` always refers to the same Ubuntu version.
- Forgetting that caches and artifacts are required to preserve data between workflow runs.

---

## Notes

This repository currently uses GitHub-hosted Ubuntu runners.

During testing, the workflow successfully displayed:

- Runner name
- Operating system
- CPU architecture
- Docker version
- Python version

This verified that GitHub automatically provisions a temporary runner for every workflow execution and configures the requested Python runtime before application validation.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: display GitHub-hosted runner information"
git push
```