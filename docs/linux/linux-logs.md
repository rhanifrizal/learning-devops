# Linux Logs

## Objective

Learn how to inspect, search, and monitor Linux logs for troubleshooting.

## What are Linux Logs?

Linux logs are chronological records of system activities, errors, system health metrics, and user actions captured by the operating system and its applications.

## Common Log Locations

| Directory/File      | Purpose                             |
| ------------------- | ----------------------------------- |
| `/var/log/`         | Main log directory                  |
| `/var/log/syslog`   | General system logs (Ubuntu/Debian) |
| `/var/log/auth.log` | Authentication and SSH logs         |
| `/var/log/kern.log` | Kernel messages                     |
| `/var/log/dpkg.log` | Package installation history        |
| `/var/log/apt/`     | APT package manager logs            |
| `journalctl`        | systemd journal logs                |


## Common Linux Commands

| Command      | Purpose                   |
| ------------ | ------------------------- |
| `journalctl` | View systemd logs         |
| `tail`       | Show last lines of a file |
| `tail -f`    | Follow logs in real time  |
| `head`       | Show first lines          |
| `less`       | Browse large log files    |
| `grep`       | Search logs               |
| `cat`        | Display small log files   |


### journalctl

To query, filter, and view system logs collected by systemd-journald.

Example:

```bash
journalctl
```

**When to use:**
- Debug broken services
- Investigate sudden reboots
- Security auditing
- Container and microservice tracking


### journalctl -u

To filter system logs and display messages generated exclusively by a specific systemd unit. The `-u` stands for "units"

Example:

```bash
journalctl -u nginx
```

**When to use:**
- Fix service failures
- Monitor live web traffic
- Security & access auditing
- Verify scheduled tasks


### journalctl -n

To view a specific number of the most recent lines in the system log. The `-n` stands for "number of lines".

Example:

```bash
journalctl -n 10
journalctl -u nginx -n 25
```

**When to use:**
- Quick post-crash inspections
- Scripting and automation
- Sanity checks after configuration
- Terminal resource efficiency


### tail

To view the final lines of a text file. By default, it reads and display the last 10 lines of any file you specify.

Example:

```bash
tail /var/log/syslog
tail -n 5 /var/log/syslog
```

**When to use:**
- Live debugging
- Quick log checks
- Piping output


### tail -f

To follow and stream the end of a text file in real-time. The `-f` stands for "follow".

Example:

```bash
tail -f /var/log/syslog
```

**When to use:**
- Live application debugging
- Monitor active server traffic
- Verify scheduled tasks
- Security event tracking


### grep

To search through text files or command outputs for lines that match a specific pattern or keyword. It operates as an instant text filter, scanning through millions of rows of data within milliseconds.

Example:

```bash
journalctl | grep cron
grep cron /var/log/syslog
```

**When to use:**
- Isolate log errors
- Audit running processes
- Find specific configurations
- Filter IP Addresses


### less

To view the contents of a file one screenful at a time.

Example:

```bash
less /var/log/syslog
```

**When to use:**
- Inspect massive log files
- Search for patterns contextually
- Piping long command outputs


### head

To view the very beginning lines of a text file. By default, it reads and displays the first 10 lines of any file you specify.

Example:

```bash
head /etc/passwd
head -n 5 /var/log/syslog
```

**When to use:**
- Inspect file headers
- Verify log rotation
- Piping and truncating data


## Practical Scenario

Explain how you inspected cron logs and searched logs using `journalctl`, `grep`, `tail`, and `/var/log`.

While troubleshooting a scheduled task, I first used `journalctl -u cron` to review recent cron service activity. I then searched for specific events using `grep`, monitored new log entries in real time with `tail -f /var/log/syslog`, and inspected historical logs stored under `/var/log` to verify that scheduled jobs executed successfully.


## Interview Questions

### 1. Why are logs important?

Logs are important because they serve as the black box flight recorder for your operating system and applications. They provide an undeniable, timestamped record of events that allows you to understand exactly what a system did when no human was watching.


### 2. What is the difference between `journalctl` and `/var/log`?

The primary difference is that `journalctl` is a tool used to query a centralized, binary log database, while `/var/log` is a physical directory on your hard drive that contains individual plain-text log files.


### 3. What does `tail -f` do?

The `tail -f` command streams the end of a plain-text file in real-time. The `-f` stands for "follow". Instead of reading a file and immediately closing it, `tail -f` keeps your terminal window open and actively prints out new lines of text the exact millisecond they are added to the bottom of the file.


### 4. Why use `grep` with logs?

Use `grep` with logs because it acts as an instant search filter, allowing you to isolate specific errors, IP addresses, or events out of log files that contain millions of lines of text.


### 5. What log file would you check for authentication events?

The exact log file you check for authentication events depends on which Linux distribution family your server is running. But for Debian and Ubuntu systems, it is `/var/log/auth.log`.



## Common Mistakes

- Not checking logs before restarting a service.
- Using `cat` on very large log files.
- Forgetting to use `--since` with `journalctl` to narrow down results.
- Searching the wrong log file for the issue.
- Ignoring timestamps when troubleshooting.



## Notes

This lab was completed in Ubuntu running on WSL. Logs such as `/var/log/syslog`, `/var/log/auth.log`, and `/var/log/dpkg.log` were available. I also observed cron activity through both `journalctl -u cron` and `/var/log/syslog`.

Some services and logs may differ between WSL and a full Linux server, but the log inspection commands remain the same.