# GitHub Actions Matrix Strategy

## Objective

Learn how GitHub Actions Matrix Strategy executes the same job multiple times with different configurations, understand the benefits of testing across multiple environments, and implement a matrix workflow for validating a Python application using multiple Python versions.

---

## What is Matrix Strategy?

Matrix Strategy is a GitHub Actions feature that automatically creates multiple workflow jobs from a single job definition.

Instead of duplicating workflow code, GitHub expands the job into multiple executions using different variable combinations.

This allows applications to be tested across multiple operating systems, language versions, or environments with minimal configuration.

---

## Why Use Matrix Strategy?

Reasons for using Matrix Strategy:

1. Test applications across multiple environments simultaneously.
2. Reduce duplicated workflow definitions.
3. Improve compatibility testing.
4. Execute jobs in parallel to reduce total build time.
5. Simplify maintenance of CI pipelines.

---

## How Matrix Strategy Works

A matrix defines one or more variables.

GitHub automatically creates one workflow job for every value inside the matrix.

Example:

```yaml
strategy:
  matrix:
    python-version:
      - "3.10"
      - "3.11"
      - "3.12"
```

GitHub automatically expands the workflow into:

```text
Python Validation (3.10)

Python Validation (3.11)

Python Validation (3.12)
```

Although only one job is written, three independent jobs are executed.

---

## Matrix Variables

Matrix values are accessed using the `matrix` context.

Example:

```yaml
python-version: ${{ matrix.python-version }}
```

This value can be reused anywhere inside the workflow.

Example:

```yaml
uses: actions/setup-python@v5

with:
  python-version: ${{ matrix.python-version }}
```

---

## Fail Fast

GitHub supports the `fail-fast` option.

Example:

```yaml
strategy:
  fail-fast: false

  matrix:
    python-version:
      - "3.10"
      - "3.11"
      - "3.12"
```

### fail-fast: true (default)

If one matrix job fails, GitHub immediately cancels the remaining matrix jobs.

Example:

```text
Python 3.10 ❌

Python 3.11 Cancelled

Python 3.12 Cancelled
```

---

### fail-fast: false

All matrix jobs continue executing even if one fails.

Example:

```text
Python 3.10 ❌

Python 3.11 ✅

Python 3.12 ✅
```

This provides complete compatibility information for every configured environment.

---

## Include and Exclude

Matrix Strategy also supports `include` and `exclude`.

### Include

Adds additional custom configurations.

Example:

```yaml
strategy:
  matrix:
    python-version: ["3.10", "3.11"]

    include:
      - python-version: "3.13-dev"
```

---

### Exclude

Removes specific combinations from the matrix.

Example:

```yaml
strategy:
  matrix:
    os:
      - ubuntu-latest
      - windows-latest

    python-version:
      - "3.10"
      - "3.11"

    exclude:
      - os: windows-latest
        python-version: "3.10"
```

---

## Current Workflow Implementation

This repository validates the Flask application using three Python versions.

Workflow configuration:

```yaml
strategy:
  fail-fast: false

  matrix:
    python-version:
      - "3.10"
      - "3.11"
      - "3.12"
```

Each matrix job performs:

1. Checkout repository
2. Display runner information
3. Setup Python
4. Install dependencies
5. Compile the Flask application
6. Generate a build report
7. Upload workflow artifacts

---

## Workflow Execution

Current workflow:

> The repository workflow continued to evolve after this lab. This section preserves the implementation used to demonstrate the topic at that stage of the learning journey.

```text
Push / Pull Request
│
├── Documentation Check
│
├── Python Validation (3.10)
│      │
│      └── Upload Artifact
│
├── Python Validation (3.11)
│      │
│      └── Upload Artifact
│
├── Python Validation (3.12)
│      │
│      └── Upload Artifact
│
├── Docker Compose Validation
│
└── GitHub Secrets Demo
```

The Docker Compose validation job only starts after every Python matrix job completes successfully.

Generated workflow artifacts:

```text
build-report-python-3.10
build-report-python-3.11
build-report-python-3.12
```

---

## Practical Scenario

During this lab, Matrix Strategy was implemented to validate the Flask application across three Python versions.

GitHub automatically executed three independent workflow jobs.

Generated artifacts:

```text
build-report-python-3.10

build-report-python-3.11

build-report-python-3.12
```

Each artifact contains information specific to the Python version that executed the workflow.

This demonstrates how Matrix Strategy improves compatibility testing while keeping workflow definitions concise and maintainable.

---

## Interview Questions

### What is Matrix Strategy?

Matrix Strategy allows GitHub Actions to execute the same workflow job multiple times using different configurations.

---

### Why use Matrix Strategy?

It enables testing across multiple environments while avoiding duplicate workflow definitions.

---

### What is the `matrix` context?

The `matrix` context provides access to the current matrix values during workflow execution.

Example:

```yaml
${{ matrix.python-version }}
```

---

### What does `fail-fast` do?

`fail-fast` controls whether remaining matrix jobs are cancelled after one job fails.

- `true` cancels remaining jobs.
- `false` continues executing all jobs.

---

### Can matrix jobs run in parallel?

Yes.

Each matrix job runs independently and can execute in parallel using separate GitHub-hosted runners.

---

### What happens when another job depends on a matrix job?

A dependent job waits until every matrix job completes successfully.

If any required matrix job fails, the dependent job is skipped.

---

## Common Mistakes

- Creating duplicate jobs instead of using Matrix Strategy.
- Forgetting to use `${{ matrix.variable }}` inside workflow steps.
- Assuming matrix jobs execute sequentially.
- Forgetting that dependent jobs wait for every matrix execution.
- Leaving `fail-fast` enabled when full compatibility testing is required.

---

## Notes

This repository uses Matrix Strategy to validate the Flask application using Python 3.10, 3.11, and 3.12.

Each matrix job executes independently, generates its own build report, and uploads a uniquely named workflow artifact.

The workflow also demonstrates the use of `fail-fast: false`, allowing every Python version to complete even if one version encounters an error.

This implementation closely resembles production Continuous Integration pipelines used to verify compatibility across multiple runtime environments.

---

## Commands Used

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add matrix strategy for Python validation"
git push
```