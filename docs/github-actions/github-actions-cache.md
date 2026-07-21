# GitHub Actions Cache

## Objective

Learn how GitHub Actions caching improves Continuous Integration (CI) performance by storing reusable dependencies between workflow runs, reducing installation time and speeding up pipeline execution.

---

## What is Caching?

Caching is the process of storing frequently used files so they can be reused in future workflow runs instead of being downloaded or generated again.

In GitHub Actions, caching is commonly used to store:

- Programming language dependencies
- Build artifacts
- Package manager downloads
- Compiled libraries

Rather than downloading dependencies during every workflow execution, GitHub restores them from a previously saved cache whenever possible.

---

## Why Use Caching?

Reasons for using caching:

1. Faster Workflow Execution: Previously downloaded dependencies are restored instead of downloaded again.
2. Reduced Network Usage: Fewer package downloads reduce bandwidth consumption.
3. Lower CI Costs: Faster workflows consume fewer GitHub Actions minutes.
4. Improved Developer Productivity: Developers receive build results more quickly.

---

## How GitHub Actions Cache Works

Workflow execution:

```text
Workflow Starts
        │
        ▼
Restore Cache
        │
        ▼
Cache Found?
      ┌───────────────┐
      │               │
     Yes             No
      │               │
      ▼               ▼
Use Cached      Download Dependencies
Dependencies           │
      │               ▼
      └──────► Install Dependencies
                    │
                    ▼
              Execute Workflow
                    │
                    ▼
             Save Cache (if needed)
                    │
                    ▼
              Workflow Complete
```

---

## Cache Hit vs Cache Miss

### Cache Miss

A cache miss occurs when GitHub cannot find an existing cache that matches the generated cache key.

Result:

- Dependencies are downloaded normally.
- A new cache is created after the workflow completes.

Example:

```text
pip cache is not found
```

---

### Cache Hit

A cache hit occurs when GitHub finds a previously saved cache matching the cache key.

Result:

- Dependencies are restored immediately.
- Downloads are skipped where possible.
- Workflow executes faster.

Example:

```text
Cache hit for:
setup-python-Linux-x64...
```

---

## Cache Keys

GitHub uniquely identifies each cache using a cache key.

The key is automatically generated from:

- Operating System
- Python Version
- Package Manager
- Dependency File (`requirements.txt`)

If any of these change, GitHub generates a new cache.

Example:

```text
setup-python-Linux-x64-24.04-Ubuntu-python-3.12.13-pip-71193066...
```

---

## Enabling Pip Cache

GitHub Actions provides built-in caching support through the `actions/setup-python` action.

Current configuration:

```yaml
- name: Setup Python
  uses: actions/setup-python@v5
  with:
    python-version: "3.12"
    cache: "pip"
    cache-dependency-path: projects/company-server/web-app/requirements.txt
```

### Configuration Explanation

| Option | Purpose |
|---------|---------|
| `python-version` | Python version installed on the runner |
| `cache: pip` | Enables pip dependency caching |
| `cache-dependency-path` | Uses `requirements.txt` to determine when the cache should be refreshed |

---

## Current Workflow

The repository currently performs:

```text
Push / Pull Request
        │
        ├──────────────────────────────┐
        ▼                              ▼
Documentation Check             Python Validation
                                        │
                                        ▼
                           Restore Pip Cache
                                        │
                                        ▼
                           Install Dependencies
                                        │
                                        ▼
                               Compile Python
                                        │
                                        ▼
                          Docker Compose Validation
```

---

## Practical Scenario

This repository now uses pip dependency caching inside the GitHub Actions CI pipeline.

During testing:

### First Workflow Run

GitHub searched for an existing pip cache but none existed.

Output:

```text
pip cache is not found
```

After the workflow completed successfully, GitHub created and stored a new cache.

Output:

```text
Cache saved with the key:
setup-python-Linux-x64-24.04-Ubuntu-python-3.12.13-pip-...
```

---

### Second Workflow Run

GitHub successfully restored the previously created cache.

Output:

```text
Cache hit for:
setup-python-Linux-x64-24.04-Ubuntu-python-3.12.13-pip-...
```

```text
Cache restored successfully
```

This demonstrated how dependency caching speeds up future workflow executions without requiring packages to be downloaded again.

---

## Cache Invalidation

GitHub automatically creates a new cache whenever important inputs change.

Examples include:

- Updating `requirements.txt`
- Changing the Python version
- Switching to a different operating system
- Using a different package manager

This ensures outdated dependencies are never reused.

---

## Interview Questions

### What is GitHub Actions cache?

GitHub Actions cache stores reusable dependencies between workflow runs to improve CI performance.

---

### What is a cache hit?

A cache hit occurs when GitHub successfully finds and restores a previously saved cache.

---

### What is a cache miss?

A cache miss occurs when no matching cache exists, requiring dependencies to be downloaded again.

---

### What determines the cache key?

The cache key is generated from factors such as:

- Operating System
- Runtime version
- Package manager
- Dependency files

---

### Does caching replace `pip install`?

No.

The `pip install` command still executes, but pip can reuse cached packages instead of downloading them again.

---

### Why is caching useful?

Caching reduces workflow execution time, lowers bandwidth usage, saves CI minutes, and improves developer productivity.

---

## Common Mistakes

- Forgetting to enable caching in the setup action.
- Expecting the cache to exist during the first workflow run.
- Assuming cached dependencies never become outdated.
- Forgetting that changing `requirements.txt` creates a new cache.
- Confusing dependency caching with build artifacts.

---

## Notes

This repository uses GitHub Actions' built-in pip caching provided by `actions/setup-python`.

Testing confirmed both expected cache states:

- First execution: Cache Miss → Cache Saved
- Second execution: Cache Hit → Cache Restored

Future workflows will extend caching to Docker layers and other build dependencies where appropriate.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: enable pip dependency caching"
git push
```