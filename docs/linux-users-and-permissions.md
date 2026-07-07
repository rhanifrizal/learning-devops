# Linux Users and Permissions

## Objective

Learn how Linux users, groups, and file permissions work, and how to manage access to files and directories using common permission-related commands.

## Linux Permission Basics

| Permission | Meaning                                                 |
|------------|---------------------------------------------------------|
| `r`        | Read the contents of a file or list a directory         |
| `w`        | Modify a file or create/delete files within a directory |
| `x`        | Execute a file or access a directory                    |

## Permission Structure

```text
-rwxr-xr-x
```

- `-` : File type (`d` would indicate a directory)
- `rwx` : Owner permissions (read, write, execute)
- `r-x` : Group permissions (read, execute)
- `r-x` : Others permissions (read, execute)


## Common Linux Commands

### chmod

Short for **change mode**. It is used to modify the permissions of files and directories by controlling who can read, write, or execute them.

Example:

```bash
chmod 755 script.sh
chmod +x script.sh
```

**When to use:**
- Grant or remove read, write, or execute permissions.
- Allow scripts to become executable.
- Restrict unauthorized access to files and directories.


### chown

Short for change owner. It is used to modify the user and/or group ownership of a file or directory.

Example:

```bash
sudo chown ubuntu:developers app.py
```

**When to use
- Transfer ownership of files to another user.
- Assign a directory to a specific Linux group.
- Ensure services such as web servers have the correct ownership to access application files.


### sudo

Short for **superuser do**. It allows an authorized user to execute commands with elevated privileges, usually as the root user.

Example:

```bash
sudo apt update && sudo apt install curl
```

**When to use:**
- Installing, removing, or updating core applications and libraries.
- Changing system behaviors via files inside protected directories like /etc/ or /var/.
- Starting, stopping, or restarting background processes (daemons) such as a web server.


## Practical Scenario

The deployment script could not be executed because it did not have execute permission. By running `chmod +x deploy.sh`, I granted execute permission to the file, allowing it to be run directly from the terminal. This is a common task when preparing deployment or automation scripts in Linux.

## Interview Questions

### 1. What does `chmod +x` do?

`chmod +x` adds execute permission to a file, allowing it to be run as a program or script.

### 2. What does 755 mean?

`755` is a numeric permission setting:

- `7` (Owner): Read, write, and execute.
- `5` (Group): Read and execute.
- `5` (Others): Read and execute.

### 3. Why is 777 dangerous?

`777` is dangerous because it grants full read, write, and execute permissions to everyone. This increases the risk of accidental modifications or unauthorized access, especially on production systems.

### 4. What is the difference between owner, group, and others?

Owner: Typically the user who created the file, it has the highest level of control

Group: A collection of users (development team, staff, etc). It allows sharing files within a team without opening them to the public

Others: "Everyone else" or the "world", users who do not own the file and are not part of its assigned group

### 5. What is sudo used for?

`sudo` allows an authorized user to execute commands with administrative (root) privileges without logging in as the root user.