# Linux Process Management

## Objective

Learn how Linux processes work, how to monitor running processes, and how to manage them using common process management commands.

## What is a Process?

A process is an active, running instance of a program. While a program stored on disk is passive, executing it loads it into memory, creating a process with its own resources, a unique Process ID (PID), and an owner.

## Common Linux Commands

### ps

`ps` (process status) displays information about the currently running processes on the system.

Example:

```bash
ps
ps -ef
ps -ef | grep python
ps aux | grep python
```

**When to use:**
- Hunt and kill stuck processes
- Identify resource hogs
- Audit background services and daemons
- Debug multi-threaded applications


### top

A built-in, real-time system monitoring utility that provides a dynamic, continuously updated view of running processes, CPU load, memory usage, and system uptime.

Example:

```bash
top
```

**When to use:**
- Diagnose performance drops
- Identify resource-heavy apps
- Monitor system load
- Identify misbehaving processes before terminating them


### kill

`kill` sends a signal to a running process. By default, it sends the `SIGTERM` signal, requesting the process to terminate gracefully.

Example:

```bash
kill 1234
kill -9 1234
```

**When to use:**
- Close a program safely
- Reload a service without restarting
- Interrupt a foreground script
- Pause a heavy process temporarily
- Resume a paused process
- Force close a completely frozen app


### jobs

Displays the jobs currently running or suspended in the current terminal session.

Example:

```bash
jobs -l
```

**When to use:**
- Check on long-running tasks
- Find a job ID
- Recover a frozen terminal


### bg

To resume a paused or suspended process and run it in the background.

Example:

```bash
bg %1
```

**When to use:**
- Terminal lockup
- Single terminal multitasking
- Script auditing


### fg

Brings a background or suspended job into the foreground of the current terminal session.

Example:

```bash
fg %1
```

**When to use:**
- Resume text editors
- Interact with paused tools
- Check on hidden downloads/compilations


### nohup

Short for **"no hangup"**. It allows a command or script to continue running even after the terminal is closed or the user logs out.

Example:

```bash
nohup ./monitor.sh 
```

**When to use:**
- Remote SSH work
- Long-running tasks
- Non-interactive backgrounding
- Quick daemon overrides


## Practical Scenario

I first identified the running application using `ps -ef | grep monitor` to locate its Process ID (PID). After verifying it was the correct process, I used `kill <PID>` to terminate it gracefully and confirmed that it was no longer running.


## Interview Questions

### 1. What is a PID?

A PID (Process ID) is a unique number assigned by the Linux operating system to every running process.


### 2. What is the difference between `kill` and `kill -9`?

`kill` sends the `SIGTERM` signal, allowing the process to terminate gracefully.

`kill -9` sends the `SIGKILL` signal, forcing the process to terminate immediately. It should only be used when the process does not respond to a normal `kill`.


### 3. Why use `top`?

`top` provides a real-time view of running processes, CPU usage, memory consumption, and overall system performance. It is commonly used to identify processes that consume excessive system resources.


### 4. What does `nohup` do?

`nohup` allows a Linux command to continue running in the background even after you close your terminal or disconnect from a remote server.


### 5. What is the difference between foreground and background processes?

The primary difference is terminal control. A foreground process takes over your terminal window and blocks you from entering new commands, while a background process runs silently in the hidden layers of the system, leaving your terminal free for immediate use.