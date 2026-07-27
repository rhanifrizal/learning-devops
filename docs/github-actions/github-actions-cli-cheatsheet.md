# GitHub CLI Cheatsheet

## Objective

A quick reference for commonly used GitHub CLI (`gh`) commands to manage repositories, workflows, workflow runs, artifacts, caches, pull requests, issues, and releases directly from the terminal.

---

# Installation

## Ubuntu

```bash
sudo apt install gh
```

---

## Verify Installation

```bash
gh --version
```

Example:

```text
gh version 2.46.0
```

---

# Authentication

## Login

```bash
gh auth login
```

---

## Check Authentication Status

```bash
gh auth status
```

Example:

```text
✓ Logged in to github.com
```

---

# Repository Commands

## View Current Repository

```bash
gh repo view
```

---

## Open Repository in Browser

```bash
gh repo view --web
```

WSL Alternative:

```bash
explorer.exe "$(gh repo view --json url --jq '.url')"
```

---

## Clone Repository

```bash
gh repo clone owner/repository
```

Example:

```bash
gh repo clone rhanifrizal/learning-devops
```

---

# Workflow Commands

## List Workflows

```bash
gh workflow list
```

---

## View Workflow

```bash
gh workflow view ci.yml
```

---

## View Workflow YAML

```bash
gh workflow view ci.yml --yaml
```

---

## Trigger Workflow Manually

```bash
gh workflow run ci.yml
```

---

# Workflow Run Commands

## List Recent Runs

```bash
gh run list
```

---

## List Runs for a Specific Workflow

```bash
gh run list --workflow ci.yml
```

---

## Limit Results

```bash
gh run list --workflow ci.yml --limit 5
```

---

## Show Failed Runs

```bash
gh run list --workflow ci.yml --status failure
```

---

## Get Latest Run ID

```bash
RUN_ID=$(
gh run list \
  --workflow ci.yml \
  --limit 1 \
  --json databaseId \
  --jq '.[0].databaseId'
)
```

Display it:

```bash
echo "$RUN_ID"
```

---

## View Workflow Run

```bash
gh run view "$RUN_ID"
```

---

## Watch Workflow Execution

```bash
gh run watch "$RUN_ID"
```

Return a non-zero exit code if the workflow fails:

```bash
gh run watch "$RUN_ID" --exit-status
```

---

# Artifact Commands

## Download Workflow Artifacts

```bash
mkdir -p artifacts

gh run download "$RUN_ID" \
  --dir artifacts
```

---

## List Downloaded Files

```bash
find artifacts -type f
```

---

## Remove Downloaded Artifacts

```bash
rm -rf artifacts
```

---

# Cache Commands

## List Repository Caches

```bash
gh cache list
```

---

# Pull Request Commands

## List Pull Requests

```bash
gh pr list
```

---

## Create Pull Request

```bash
gh pr create
```

---

## Checkout Pull Request

```bash
gh pr checkout <number>
```

Example:

```bash
gh pr checkout 12
```

---

## Merge Pull Request

```bash
gh pr merge <number>
```

---

# Issue Commands

## List Issues

```bash
gh issue list
```

---

## Create Issue

```bash
gh issue create
```

---

## View Issue

```bash
gh issue view <number>
```

---

# Release Commands

## List Releases

```bash
gh release list
```

---

## Create Release

```bash
gh release create v1.0.0
```

---

## View Release

```bash
gh release view
```

---

# Useful JSON Commands

## Repository URL

```bash
gh repo view \
  --json url \
  --jq '.url'
```

---

## Repository Name

```bash
gh repo view \
  --json name \
  --jq '.name'
```

---

## Latest Workflow Run ID

```bash
gh run list \
  --workflow ci.yml \
  --limit 1 \
  --json databaseId \
  --jq '.[0].databaseId'
```

---

## Current User

```bash
gh api user \
  --jq '.login'
```

---

# Practical Commands Used in This Repository

Authentication

```bash
gh auth status
```

Repository

```bash
gh repo view
```

Workflow

```bash
gh workflow list
gh workflow view ci.yml
gh workflow run ci.yml
```

Workflow Runs

```bash
gh run list
gh run view "$RUN_ID"
gh run watch "$RUN_ID"
```

Artifacts

```bash
gh run download "$RUN_ID" --dir artifacts
```

Cache

```bash
gh cache list
```

---

# Best Practices

- Authenticate once using `gh auth login`.
- Prefer GitHub CLI over manual browser navigation for routine tasks.
- Use `gh workflow run` to manually trigger workflows during testing.
- Monitor workflow execution with `gh run watch`.
- Download artifacts for troubleshooting failed builds.
- Remove temporary downloaded artifacts after use.
- Keep GitHub CLI updated.

---

# Common Mistakes

- Forgetting to authenticate before running commands.
- Downloading artifacts into the repository and accidentally committing them.
- Watching an already completed workflow and expecting live updates.
- Assuming all GitHub CLI versions support the same flags.
- Forgetting to specify a workflow when multiple workflows exist.

---

# Interview Questions

### What is GitHub CLI?

GitHub CLI is an official command-line tool that allows developers to interact with GitHub repositories, pull requests, issues, workflows, releases, and other GitHub features directly from the terminal.

---

### Why use GitHub CLI?

It improves productivity by allowing repository management and CI/CD operations without leaving the terminal.

---

### How do you manually trigger a GitHub Actions workflow?

```bash
gh workflow run ci.yml
```

---

### How do you monitor a workflow run?

```bash
gh run watch <run-id>
```

---

### How do you download workflow artifacts?

```bash
gh run download <run-id> --dir artifacts
```

---

# Notes

During this sprint, GitHub CLI was used to:

- Authenticate with GitHub.
- Inspect repository information.
- View workflow configuration.
- Trigger workflows manually.
- Monitor workflow execution.
- Download workflow artifacts.
- Inspect dependency caches.

GitHub CLI complements GitHub Actions by enabling complete CI/CD workflow management directly from the terminal.