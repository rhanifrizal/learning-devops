# Linux Services

## Objective

Learn how Linux services are managed using `systemd` and `systemctl`, including how to start, stop, restart, enable, disable, and troubleshoot services.

## What is a Linux Service?

A Linux service, often called a daemon, is a background process that runs continuously to perform specific system tasks without user interaction. Unlike regular background processes tied to a terminal session, a service starts automatically when the system boots and runs independently of who is logged in.

## What is systemd?

`systemd` is the primary system and service manager for modern Linux operating systems. It is the first process that starts when a Linux machine boots (PID 1) and acts as the parent process responsible for managing system services throughout the system's lifecycle.

## Common Linux Commands

| Command             | Purpose                        |
| ------------------- | ------------------------------ |
| `systemctl status`  | Check service status           |
| `systemctl start`   | Start a service                |
| `systemctl stop`    | Stop a service                 |
| `systemctl restart` | Restart a service              |
| `systemctl enable`  | Start automatically after boot |
| `systemctl disable` | Disable auto-start             |
| `journalctl`        | View service logs              |


### systemctl status

To inspect the current state, runtime configuration, and recent logs of a Linux system service. It acts as a diagnostic health check for any system component managed by systemd.

Example:

```bash
systemctl status nginx
```

**When to use:**
- Troubleshoot failures
- Verify changes
- Resource audit
- Boot diagnostics


### systemctl start

To launch a stopped or inactive Linux system service immediately. It triggers systemd to allocate resources, spawn the necessary background processes, and run the service in the background.

Example:

```bash
sudo systemctl start nginx
```

**When to use:**
- Initial setup
- Manual recovery
- On-demand utility


### systemctl stop

To immediately shut down a running Linux system service. It instructs systemd to send a graceful termination signal (SIGTERM) to the service and all of its associated child processes, allowing them to clean up before closing.

Example:

```bash
sudo systemctl stop nginx
```

**When to use:**
- Maintenance
- Resource management
- Security isolation
- Troubleshoot


### systemctl restart

Stops a running Linux service and immediately starts it again.

Example:

```bash
sudo systemctl restart nginx
```

**When to use:**
- Apply configuration changes
- Clear memory leaks
- Fix frozen applications
- Network recovery


### systemctl enable

To configure a Linux system service to start automatically whenever the machine boots up.

Example:

```bash
sudo systemctl enable nginx
```

**When to use:**
- Production server deployment
- Essential background tools
- Custom automation scripts


### systemctl disable

To prevent a Linux system service from starting automatically when the machine boots up.

Example:

```bash
sudo systemctl disable nginx
```

**When to use:**
- Speeding up boot times
- Conserving system resources
- Security hardening
- Decommissioning applications


### journalctl

`journalctl` queries and displays logs collected by the systemd journal.

Example:

```bash
journalctl -u nginx
journalctl -u nginx --since today
```

**When to use:**
- Debug broken services
- Investigate system crashes
- Security audit


## Practical Scenario

During routine maintenance, I verified that the cron service was running correctly using `systemctl status cron`. I then restarted the service using `sudo systemctl restart cron` and confirmed that it returned to the `active (running)` state. Finally, I reviewed the service logs with `journalctl -u cron` to ensure there were no errors.


## Interview Questions

### 1. What is systemd?

`systemd` is the default system and service manager in most modern Linux distributions. It is responsible for starting, stopping, and managing services throughout the system.


### 2. What does `systemctl restart` do?

`systemctl restart` stops a running service and immediately starts it again. It is commonly used after configuration changes or when recovering from service issues.


### 3. Why use `journalctl`?

`journalctl` provides a single, centralized command to search and filter all system logs.


### 4. What is the difference between `start` and `enable`?

`systemctl start` starts the service immediately for the current session. It will not start automatically after the machine reboots.

`systemctl enable` configures the service to start automatically at boot. It does not start the service immediately for the current session.


### 5. Why do production applications usually run as services?

Production applications usually run as services because they require unattended reliability, automation, and security. In a production environment, an application cannot depend on a human user being logged into a terminal window to keep it running.


## Common Mistakes

- Confusing `start` with `enable`.
- Restarting a service without checking its status first.
- Forgetting to inspect logs with `journalctl` when troubleshooting.
- Assuming a service starts automatically after installation.


## Notes

In my WSL environment, services such as `docker` and `ssh` were not available because they were not installed as Linux services. Instead, I used the `cron` service to learn and practice `systemctl` and `journalctl` commands.