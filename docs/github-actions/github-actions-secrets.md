# GitHub Actions Secrets

## Objective

Learn how GitHub Secrets securely store sensitive information, understand the different types of secrets available, safely access secrets within GitHub Actions workflows, and follow security best practices for protecting credentials in CI/CD pipelines.

---

## What are GitHub Secrets?

GitHub Secrets provide a secure way to store sensitive information such as passwords, API keys, access tokens, cloud credentials, and private keys.

Secrets are encrypted by GitHub and can be accessed securely within GitHub Actions workflows without exposing their actual values in source code or workflow logs.

---

## Why Use GitHub Secrets?

Reasons for using GitHub Secrets:

1. Protect sensitive information from being committed into Git repositories.
2. Encrypt credentials stored within the repository.
3. Automatically mask secret values in workflow logs.
4. Centralize sensitive configuration outside workflow files.
5. Safely authenticate with external services during CI/CD.

---

## Common Examples

GitHub Secrets are commonly used to store:

- Docker Hub Username
- Docker Hub Password
- AWS Access Keys
- Azure Credentials
- Google Cloud Service Account Keys
- API Tokens
- SSH Private Keys
- Database Passwords
- Telegram Bot Tokens
- GitHub Personal Access Tokens

---

## Types of GitHub Secrets

GitHub supports three levels of secrets.

### Repository Secrets

Available to workflows within a single repository.

Best suited for:

- Personal projects
- Small teams
- Repository-specific credentials

---

### Environment Secrets

Available only to a specific deployment environment.

Best suited for:

- Development
- Staging
- Production

Each environment can have different credentials.

---

### Organization Secrets

Shared across multiple repositories within a GitHub organization.

Best suited for:

- Enterprise teams
- Shared cloud credentials
- Common deployment infrastructure

---

## Creating Repository Secrets

Repository secrets can be created from:

```text
Repository
│
▼
Settings
│
▼
Secrets and variables
│
▼
Actions
│
▼
New repository secret
```

Each secret contains:

- Secret Name
- Secret Value

After saving, GitHub encrypts the value and it cannot be viewed again.

---

## Accessing Secrets

Secrets are accessed using the `secrets` context.

Example:

```yaml
env:
  DEMO_USERNAME: ${{ secrets.DEMO_USERNAME }}
  DEMO_MESSAGE: ${{ secrets.DEMO_MESSAGE }}
```

These values become available as environment variables inside the workflow step.

---

## Using Secrets in a Workflow

Example:

```yaml
- name: Display Secret Usage
  env:
    DEMO_USERNAME: ${{ secrets.DEMO_USERNAME }}
    DEMO_MESSAGE: ${{ secrets.DEMO_MESSAGE }}

  run: |
    echo "Successfully loaded repository secrets."
    echo "Username length: ${#DEMO_USERNAME}"
    echo "Message length: ${#DEMO_MESSAGE}"
```

Instead of displaying the secret values, this workflow only displays the length of each value to confirm they were loaded successfully.

---

## Secret Masking

GitHub automatically masks secret values whenever they appear in workflow logs.

For example, running:

```bash
echo "$DEMO_USERNAME"
```

produces:

```text
***
```

instead of displaying the real value.

This helps prevent accidental credential exposure during workflow execution.

---

## Current Workflow Demonstration

This repository contains a dedicated demonstration of GitHub Secrets.

The workflow:

1. Loads repository secrets.
2. Stores them as environment variables.
3. Confirms the secrets were loaded successfully.
4. Demonstrates GitHub's automatic secret masking.

Example:

```yaml
env:
  DEMO_USERNAME: ${{ secrets.DEMO_USERNAME }}
  DEMO_MESSAGE: ${{ secrets.DEMO_MESSAGE }}
```

---

## Practical Scenario

During this lab, two repository secrets were created:

```text
DEMO_USERNAME
DEMO_MESSAGE
```

The workflow successfully accessed both secrets and confirmed they were available by displaying their character lengths.

Example output:

```text
Successfully loaded repository secrets.
Username length: 11
Message length: 25
```

To verify GitHub's masking behavior, the workflow temporarily printed both secret values. GitHub automatically replaced each value with:

```text
***
```

After confirming the behavior, the secret output commands were removed from the workflow to follow security best practices.

---

## Best Practices

- Never commit passwords or tokens into a Git repository.
- Store sensitive values using GitHub Secrets.
- Avoid printing secret values in workflow logs.
- Use descriptive secret names.
- Rotate credentials regularly.
- Grant secrets only the permissions they require.
- Use Environment Secrets for production deployments.

---

## GitHub Secrets vs Environment Variables

| Environment Variables | GitHub Secrets |
|-----------------------|----------------|
| Store general configuration | Store sensitive information |
| Visible in workflow YAML | Stored securely in GitHub |
| Safe for non-sensitive values | Used for passwords, API keys, and tokens |
| Example: Python version | Example: Docker password |

---

## Secret Lifecycle

```text
Create Secret
        │
        ▼
Stored Encrypted by GitHub
        │
        ▼
Workflow Requests Secret
        │
        ▼
Secret Injected into Runner
        │
        ▼
Workflow Uses Secret
        │
        ▼
Secret Automatically Masked in Logs
```

---

## Interview Questions

### What are GitHub Secrets?

GitHub Secrets are encrypted values used to securely store sensitive information such as passwords, API keys, access tokens, and cloud credentials for GitHub Actions workflows.

---

### Why should credentials not be stored directly in workflow files?

Workflow files are committed into source control and may expose sensitive information.

Credentials should instead be stored using GitHub Secrets.

---

### How are GitHub Secrets accessed?

Secrets are accessed using the `secrets` context.

Example:

```yaml
${{ secrets.DEMO_USERNAME }}
```

---

### Can you view a GitHub Secret after creating it?

No.

GitHub encrypts the value and does not allow it to be viewed again after it has been saved.

---

### What happens if a workflow prints a secret?

GitHub automatically masks the value by replacing it with:

```text
***
```

This helps prevent accidental exposure in workflow logs.

---

### What types of secrets does GitHub support?

GitHub supports:

- Repository Secrets
- Environment Secrets
- Organization Secrets

---

### What is the difference between GitHub Secrets and Environment Variables?

Environment variables store general configuration values.

GitHub Secrets store sensitive values such as passwords, API keys, and cloud credentials.

---

## Common Mistakes

- Committing passwords into source control.
- Printing secret values into workflow logs.
- Using hardcoded credentials instead of GitHub Secrets.
- Reusing the same credentials across multiple projects.
- Giving secrets broader permissions than necessary.
- Forgetting to rotate long-lived credentials.
- Confusing Environment Variables with GitHub Secrets.

---

## Notes

This repository demonstrates GitHub Secrets using two sample repository secrets:

- `DEMO_USERNAME`
- `DEMO_MESSAGE`

The workflow successfully loads both secrets, verifies they are available during execution, and demonstrates GitHub's automatic secret masking feature.

Although the masking behavior was verified during testing, the workflow was updated to remove the commands that printed the secret values, following recommended CI/CD security practices.

Future labs will replace these demonstration secrets with real credentials for services such as Docker Hub, AWS, Terraform, Kubernetes, and other deployment platforms.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: demonstrate GitHub Actions secrets"
git push
```