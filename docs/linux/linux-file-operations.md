# Linux File Operations

## Objective

Learn how to create, manage, copy, move, rename, delete, and inspect files and directories in Linux using common file operation commands.

## Common Linux Commands

### mkdir

Create directories

Example
```bash
mkdir backup
```

**When to use:**
- Create a new directory

---

### touch

Create empty files

Example
```bash
touch temp.txt
```

**When to use:**
- Create a new empty file

---

### cp

Copy files to different locations

Example:

```bash
cp file.txt new_file.txt
```

**When to use:**
- Create a backup of a file
- Duplicate files or directories
- Copy files to another locations

---

### mv

Move or rename files

Example
```bash
mv old_name.txt new_name.txt
```

**When to use:**
- Relocate or rename files and directories

---

### rm

Remove files

Example
```bash
rm file.txt
```

**When to use:**
- Permanently delete files or directories that are no longer needed.
- Use with caution because deleted files cannot be easily recovered.

---

### cat

Display file contents

Example
```bash
cat file.txt
```

**When to use:**
- Read, combine, and display file contents

---

### head

Show first lines

Example
```bash
head filename.txt
```

**When to use:**
- Used to view the beginning portion of one or more text files

---

### tail

Show last lines

Example
```bash
tail filename.txt
```

**When to use:**
- Used to display the last part of one or more text files

---

### less

Read large files

Example
```bash
less filename.txt
```

**When to use:**
- Used to view the contents of a text file or command output one screen at a time


## Practical Scenario

A new configuration file has been provided by the application team.

Before making any changes, I first create a backup of the existing configuration file using the `cp` command. This ensures I can restore the previous configuration if something goes wrong.

After creating the backup, I rename the documentation file to follow the team's naming standard using `mv`. I also create a temporary file with `touch` to test the deployment process before removing it with `rm`.

Finally, I use `cat`, `head`, `tail`, and `less` to inspect the configuration file and verify its contents before deployment.


## Interview Questions

### 1. What is the difference between `cp` and `mv`?

`cp` creates a copy of a file or directory while keeping the original.

`mv` moves a file or directory to another location or renames it.

### 2. Why make backups before modifying files?

Backups are important because they allow the original file to be restored if something goes wrong after making changes. This helps reduce the risk of configuration errors and minimizes downtime.

### 3. What does touch do?

`touch` creates a new empty file if it does not already exist. It can also update the timestamp of an existing file.

### 4. Why use less instead of cat?

`less` is preferred for large files because it allows scrolling through the contents one screen at a time, while `cat` prints the entire file at once.

### 5. What is the purpose of head and tail?

`head` displays the first few lines of a file, while `tail` displays the last few lines. They are commonly used to quickly inspect large log or configuration files.