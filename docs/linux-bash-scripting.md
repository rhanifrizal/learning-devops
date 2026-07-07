# Linux Bash Scripting

## Objective

Learn how to automate repetitive Linux tasks by writing Bash scripts using variables, user input, conditional statements, loops, functions, command-line arguments, and exit codes.


## What is Bash?

Bash, short for **Bourne Again Shell**, is a command-line interpreter and scripting language used on Linux and macOS operating systems.


## Common Bash Concepts

### Shebang

The Shebang is the absolute first line of a Bash script. It tells the Linux kernel exactly which interpreter to use to execute the code below it.

Standard Format: `#!/bin/bash`


### Variables

Variables are used to store data or command outputs for reuse throughout your script.

```bash
NAME="Hanif"
ROLE="Junior DevOps Engineer"

echo "Name: $NAME"
echo "Target Role: $ROLE"
```


### User Input

You can pause a script and wait for a human user to type information using the read command

```bash
echo "What is your name?"

read NAME

echo "Hello $NAME!"
```


### If Statements

If statements allow your script to make decisions based on conditions. They require strict spacing inside the square brackets [ ].

```bash
if [ "$USAGE" -gt 80 ]; then
    echo "Disk usage is high!"
else
    echo "Disk usage is healthy."
fi
```


### Loops

Loops allow you to repeat a block of code multiple times. A `for` loop iterates through a fixed list, while a `while` loop runs as long as a condition remains true.

```bash
FILES="config.yml app.py README.txt"

for FILE in $FILES
do
    echo "Backing up $FILE"
done
```


### Functions

Functions allow you to group a block of code together under a single name so you can reuse it throughout your script without rewriting it.

```bash
check_service() {
    echo "Checking Cron Service..."
    systemctl status cron --no-pager
}

check_service
```


### Arguments

Arguments (or positional parameters) are values you pass into a script or function when you launch it from the terminal.

```bash
echo "Hello $1"

./greet.sh Hanif
```


### Exit Codes

Exit codes return a number between 0 and 255 when a command finishes executing. This number is known as the exit status. A value of `0` indicates success, while any value from `1` to `255` indicates that an error or specific condition occurred.

```bash
ls /etc

echo "Exit Code: $?"
```


## Practical Scenario

The `server-health.sh` script automates a basic server health check.

It displays the current date, hostname, logged-in user, and working directory to provide execution context. It then reports disk usage using `df -h` and memory usage using `free -h`, giving administrators a quick overview of the server's health.

This type of script can be scheduled using cron or integrated into monitoring and deployment workflows to automate routine system checks.


## Interview Questions

### 1. What is Bash?

Bash is a command-line interpreter and scripting language for Unix-based operating systems. It serves as the default interface text window in most Linux distributions, translating user-typed text commands into instructions that the Linux kernel can understand and execute.


### 2. What is `#!/bin/bash`?

This line is called a Shebang. It must be placed at the absolute beginning (Line 1) of a script file to tell the Linux operating system exactly which shell interpreter to load to read and execute the code written below it.


### 3. Why use variables in scripts?

Variables allow you to store data, strings, or command outputs under a single reusable name. This increases script efficiency by eliminating repetitive typing, making it easy to update value metrics globally in one place, and allowing scripts to capture dynamic data like timestamps or varying server hostnames.


### 4. What does `$?` mean?

`$?` is a special built-in Bash variable that holds the exit status code of the most recently executed foreground command. A value of 0 indicates the previous command completed successfully with no errors, while any number between 1 and 255 indicates a specific failure or crash occurred.


### 5. Why are Bash scripts useful in DevOps?

Bash scripts are crucial in DevOps for automation, speed, and repeatability. They allow engineers to automate infrastructure provisioning, stitch together CI/CD pipeline steps, deploy applications instantly across hundreds of cloud servers, schedule routine server updates, and create self-healing log rotations without requiring manual human oversight.


## Common Mistakes

- Forgetting the shebang (`#!/bin/bash`) at the beginning of the script.
- Forgetting to make scripts executable using `chmod +x`.
- Missing spaces inside `[ ]` when writing `if` statements.
- Not checking exit codes (`$?`) after important commands.
- Hardcoding values instead of using variables.

## Notes

All Bash scripts in this lab were created and tested in Ubuntu running on WSL. The scripts demonstrate common automation techniques that are widely used in Linux system administration and DevOps workflows.