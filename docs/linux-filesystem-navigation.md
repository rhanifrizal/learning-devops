# Linux Filesystem Navigation

## Objective

Learn how to navigate the Linux filesystem and understand the purpose of common system directories and navigation commands.

## Linux Filesystem Hierarchy

| Directory | Purpose                    |
|-----------|----------------------------|
| `/`       | Root directory             |
| `/home`   | User home directories      |
| `/etc`    | System configuration files |
| `/var`    | Logs and variable data     |
| `/usr`    | Installed applications     |
| `/opt`    | Optional software          |
| `/tmp`    | Temporary files            |
| `/root`   | Root user's home directory |
| `/dev`    | Hardware devices           |
| `/bin`    | Essential system commands  |

## Common Navigation Commands

### pwd

Print the current working directory.

Example:

```bash
pwd
```

**When to use:**
- Verify your current location before creating, moving, or deleting files.

### ls

List files and directories in the current directory.

Example:

```bash
ls
```

**When to use:**
- Check what files or directories are available in the current location.

### ls -la

List files and directories, including hidden files, with detailed information.

Example: 

```bash
ls -la
```

**When to use:**
- Check what hidden files or hidden directories are available in the current location.

### cd

Change the current working directory.

Example: 

```bash
cd ~
```

**When to use:**
- Navigate to another directory while exploring or managing the server.

### tree

Display the directory structure in a tree format.

Example: 

```bash
tree
```

**When to use:**
- Visualize the hierarchy of directories and files.

---

## Practical Scenario

First, I would use `tree` to understand the overall directory hierarchy. Once I know the structure, I can use `cd` to move between directories and `ls` or `ls -la` to inspect the files available in each location. I would also use `pwd` frequently to confirm my current location before making changes. This approach allows me to confidently locate and explore the application directory on an unfamiliar Linux server.

## Interview Questions

1. What is the root directory?

The root directory (`/`) is the top-level directory in Linux. Every file and directory on the system originates from this location.

2. What is the difference between `cd /` and `cd ~`?

`cd /`
Changes to the root directory.

`cd ~`
Changes to the current user's home directory.

3. What does `pwd` do?

`pwd` displays the absolute path of the current working directory.

4. Why is `ls -la` more useful than `ls`?

`ls -la` is more useful because it displays hidden files and directories, file permissions, ownership, and other detailed information that is not shown by the default `ls` command.

5. What is the purpose of `/etc`?

The purpose of '/etc' is to store system configuration files