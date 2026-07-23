# GitHub Marketplace Actions

## Objective

Learn what GitHub Marketplace Actions are, how they simplify workflow automation, the different types of Actions available, and how to safely integrate reusable Actions into GitHub Actions workflows.

---

## What is a GitHub Action?

A GitHub Action is a reusable unit of automation that performs a specific task inside a GitHub Actions workflow.

Instead of writing complex shell scripts for common tasks, developers can use pre-built Actions published on the GitHub Marketplace.

Actions can perform tasks such as:

- Checking out source code
- Setting up programming languages
- Uploading workflow artifacts
- Building Docker images
- Deploying applications
- Running security scans

---

## Why Use GitHub Marketplace Actions?

Reasons for using Marketplace Actions:

1. Reduce repetitive scripting.
2. Reuse well-tested automation components.
3. Simplify workflow development.
4. Accelerate CI/CD pipeline creation.
5. Integrate with popular cloud providers and development tools.

---

## What is GitHub Marketplace?

GitHub Marketplace is an online catalog containing thousands of reusable GitHub Actions published by GitHub and the community.

Marketplace Actions can be discovered, reviewed, and integrated directly into workflow files.

GitHub Marketplace:

https://github.com/marketplace?type=actions

---

## Types of GitHub Actions

### JavaScript Action

A JavaScript Action executes JavaScript code directly on the runner.

Example:

```yaml
uses: actions/checkout@v4
```

Common uses:

- Repository checkout
- Environment setup
- Utility automation

---

### Docker Action

A Docker Action packages automation inside a Docker container.

The container includes all required dependencies, ensuring consistent execution regardless of the runner environment.

Common uses:

- Security scanning
- Code analysis
- Containerized tooling

---

### Composite Action

A Composite Action combines multiple workflow steps into a reusable Action.

It allows frequently used sequences of commands to be shared across multiple repositories.

Common uses:

- Internal automation
- Organization standards
- Reusable deployment processes

---

## Official vs Community Actions

Marketplace Actions can be published by GitHub or third-party developers.

| Official GitHub Actions | Community Actions |
|--------------------------|-------------------|
| Published by GitHub | Published by individuals or organizations |
| Well-maintained | Maintenance varies |
| Highly trusted | Should be reviewed before use |
| Recommended for core workflows | Useful for specialized integrations |

---

## Version Pinning

Actions are referenced using the `uses` keyword.

Example:

```yaml
uses: actions/checkout@v4
```

For maximum security, organizations may pin Actions to a specific commit SHA instead of a version tag.

Example:

```yaml
uses: actions/checkout@4c2...
```

Pinning prevents unexpected behavior caused by future Action updates.

---

## Marketplace Best Practices

- Prefer official GitHub Actions whenever possible.
- Review the documentation before using an Action.
- Verify that the Action is actively maintained.
- Pin critical Actions to specific commit SHAs in production.
- Grant only the minimum permissions required by an Action.
- Avoid using unknown or untrusted Marketplace Actions.

---

## Marketplace Actions Used in This Repository

This repository currently uses three official GitHub Marketplace Actions.

### Checkout Repository

```yaml
uses: actions/checkout@v4
```

Purpose:

- Downloads the repository source code onto the runner.
- Makes project files available to subsequent workflow steps.

---

### Setup Python

```yaml
uses: actions/setup-python@v5
```

Purpose:

- Installs Python 3.12.
- Configures the Python runtime.
- Restores and saves pip dependency cache.

---

### Upload Build Report

```yaml
uses: actions/upload-artifact@v4
```

Purpose:

- Uploads files generated during the workflow.
- Makes workflow outputs downloadable after execution.

---

## Current Workflow

The Python validation job currently uses the following Marketplace Actions.

```text
Checkout Repository
        │
        ▼
Runner Information
        │
        ▼
Setup Python
        │
        ▼
Compile Python
        │
        ▼
Create Build Report
        │
        ▼
Upload Build Report
```

---

## Practical Scenario

This repository uses GitHub Marketplace Actions to simplify the Continuous Integration pipeline.

During workflow execution:

1. `actions/checkout` downloads the repository.
2. `actions/setup-python` configures Python 3.12.
3. The Flask application is validated.
4. A build report is generated.
5. `actions/upload-artifact` uploads the build report.

Generated artifact:

```text
Python validation completed successfully.
Workflow: CI Pipeline
Commit: 24f631757ea33ea5a8b9f973347fb3ffa096c47b
```

This demonstrates how Marketplace Actions eliminate repetitive scripting while keeping workflows modular and reusable.

---

## Interview Questions

### What is a GitHub Action?

A GitHub Action is a reusable automation component that performs a specific task inside a GitHub Actions workflow.

---

### What is GitHub Marketplace?

GitHub Marketplace is a repository of reusable Actions published by GitHub and the community that can be integrated into workflows.

---

### What does the `uses` keyword do?

The `uses` keyword imports and executes an existing GitHub Action inside a workflow.

---

### What is the difference between an official Action and a community Action?

Official Actions are maintained by GitHub and are generally recommended for core workflow tasks.

Community Actions are developed by third parties and should be evaluated before use.

---

### Why should Actions be pinned to a specific version or commit?

Pinning prevents unexpected changes caused by future updates and improves workflow security and reproducibility.

---

## Common Mistakes

- Using Marketplace Actions without reviewing their documentation.
- Blindly trusting unverified third-party Actions.
- Forgetting to pin critical Actions in production environments.
- Assuming every Marketplace Action is maintained by GitHub.
- Granting unnecessary permissions to Actions.

---

## Notes

This repository currently uses three official GitHub Marketplace Actions:

- `actions/checkout`
- `actions/setup-python`
- `actions/upload-artifact`

These Actions simplify repository checkout, Python environment configuration, dependency caching, and artifact publishing while keeping the CI pipeline modular and easy to maintain.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: upload workflow build report artifact"
git push
```