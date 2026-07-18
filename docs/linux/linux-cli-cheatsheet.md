# Linux CLI Cheatsheet

A quick-reference guide for common Linux commands used in system administration and DevOps workflows.


## Filesystem Navigation

| Command                       | Purpose                                  |
|-------------------------------|------------------------------------------|
| `pwd`                         | Display the current working directory    |
| `ls`                          | List files and directories               |
| `ls -la`                      | List all files with detailed information |
| `cd directory`                | Change into a directory                  |
| `cd ..`                       | Move to the parent directory             |
| `cd ~`                        | Move to the home directory               |
| `tree`                        | Display directories in a tree structure  |
| `find /path -name "file.txt"` | Search for a file by name                |


## File and Directory Operations

| Command                    | Purpose                              |
|----------------------------|--------------------------------------|
| `mkdir directory`          | Create a directory                   |
| `mkdir -p parent/child`    | Create nested directories            |
| `touch file.txt`           | Create an empty file                 |
| `cp source destination`    | Copy a file                          |
| `cp -r source destination` | Copy a directory recursively         |
| `mv source destination`    | Move or rename a file                |
| `rm file.txt`              | Delete a file                        |
| `rm -r directory`          | Delete a directory recursively       |
| `rm -rf directory`         | Force-delete a directory recursively |
| `file filename`            | Identify a file type                 |


## Viewing Files

| Command               | Purpose                            |
|-----------------------|------------------------------------|
| `cat file.txt`        | Display an entire file             |
| `less file.txt`       | Browse a file one screen at a time |
| `head file.txt`       | Show the first 10 lines            |
| `head -n 20 file.txt` | Show the first 20 lines            |
| `tail file.txt`       | Show the last 10 lines             |
| `tail -n 20 file.txt` | Show the last 20 lines             |
| `tail -f file.log`    | Follow new lines in real time      |


## Searching and Filtering

| Command                      | Purpose                         |
|------------------------------|---------------------------------|
| `grep "text" file.txt`       | Search for matching text        |
| `grep -i "error" file.log`   | Search without case sensitivity |
| `grep -r "text" directory`   | Search recursively              |
| `command \| grep "text"`     | Filter command output           |
| `sort file.txt`              | Sort lines                      |
| `uniq file.txt`              | Remove adjacent duplicate lines |
| `wc -l file.txt`             | Count lines                     |


## Permissions and Ownership

| Command                     | Purpose                                       |
|-----------------------------|-----------------------------------------------|
| `ls -l`                     | Display permissions and ownership             |
| `chmod +x script.sh`        | Add execute permission                        |
| `chmod 755 script.sh`       | Set owner to `rwx`, group and others to `r-x` |
| `chmod 644 file.txt`        | Set owner to `rw-`, group and others to `r--` |
| `chown user file.txt`       | Change file owner                             |
| `chown user:group file.txt` | Change owner and group                        |
| `sudo command`              | Run a command with elevated privileges        |


## Permission Values

| Value | Permission               |
|-------|--------------------------|
| `4`   | Read                     |
| `2`   | Write                    |
| `1`   | Execute                  |
| `7`   | Read, write, and execute |
| `6`   | Read and write           |
| `5`   | Read and execute         |


Example:

```text
-rwxr-xr-x
 │  │  │
 │  │  └── Others: read and execute
 │  └───── Group: read and execute
 └──────── Owner: read, write, and execute
```


## Process Management

| Command                 | Purpose                                         |
|-------------------------|-------------------------------------------------|
| `ps`                    | Show processes in the current terminal          |
| `ps -ef`                | Show all running processes                      |
| `ps aux`                | Show detailed process information               |
| `ps -ef \| grep python` | Find a process by name                          |
| `top`                   | Monitor processes and resource usage            |
| `kill PID`              | Request graceful process termination            |
| `kill -9 PID`           | Forcefully terminate a process                  |
| `jobs -l`               | List terminal jobs                              |
| `bg %1`                 | Resume job 1 in the background                  |
| `fg %1`                 | Bring job 1 into the foreground                 |
| `nohup command &`       | Keep a background command running after logout  |


## Service Management

| Command                           | Purpose                                |
|-----------------------------------|----------------------------------------|
| `systemctl status service`        | Check service status                   |
| `sudo systemctl start service`    | Start a service                        |
| `sudo systemctl stop service`     | Stop a service                         |
| `sudo systemctl restart service`  | Restart a service                      |
| `sudo systemctl enable service`   | Enable service at boot                 |
| `sudo systemctl disable service`  | Disable service at boot                |
| `systemctl is-active service`     | Check whether a service is active      |
| `systemctl is-enabled service`    | Check whether a service starts at boot |


## Logs

| Command                            | Purpose                              |
|------------------------------------|--------------------------------------|
| `journalctl`                       | View systemd journal logs            |
| `journalctl -n 20`                 | Show the latest 20 journal entries   |
| `journalctl -u cron`               | Show logs for the cron service       |
| `journalctl -u cron --since today` | Show today's cron logs               |
| `journalctl -f`                    | Follow journal logs in real time     |
| `tail -f /var/log/syslog`          | Follow the system log                |
| `grep -i "error" /var/log/syslog`  | Search for errors                    |
| `less /var/log/auth.log`           | Inspect authentication logs          |


## Networking

| Command               | Purpose                                       |
|-----------------------|-----------------------------------------------|
| `ip addr`             | Display network interfaces and IP addresses   |
| `ip route`            | Display the routing table and default gateway |
| `hostname`            | Display the system hostname                   |
| `hostname -I`         | Display assigned IP addresses                 |
| `ping 8.8.8.8`        | Test IP connectivity                          |
| `ping google.com`     | Test connectivity and DNS resolution          |
| `ss -tuln`            | Show listening TCP and UDP ports              |
| `ss -tulnp`           | Show listening ports and associated processes |
| `curl URL`            | Send a request to an endpoint                 |
| `curl -I URL`         | Display HTTP response headers                 |
| `wget URL`            | Download a file                               |
| `nslookup domain.com` | Perform a DNS lookup                          |
| `dig domain.com`      | Perform a detailed DNS query                  |


## Disk and Memory

| Command            | Purpose                              |
|--------------------|--------------------------------------|
| `df -h`            | Show filesystem disk usage           |
| `du -sh directory` | Show the size of a directory         |
| `du -sh *`         | Show sizes of files and directories  |
| `free -h`          | Show memory and swap usage           |
| `uptime`           | Show uptime and load average         |


## Users and Groups

| Command                       | Purpose                           |
|-------------------------------|-----------------------------------|
| `whoami`                      | Display the current user          |
| `id`                          | Show user and group IDs           |
| `who`                         | Show logged-in users              |
| `groups`                      | Show the current user's groups    |
| `sudo useradd username`       | Create a user                     |
| `sudo usermod -aG group user` | Add a user to a group             |
| `sudo passwd username`        | Set or change a password          |


## Package Management — Ubuntu/Debian

| Command                       | Purpose                           |
|-------------------------------|-----------------------------------|
| `sudo apt update`             | Refresh package indexes           |
| `sudo apt upgrade`            | Upgrade installed packages        |
| `sudo apt install package`    | Install a package                 |
| `sudo apt remove package`     | Remove a package                  |
| `apt list --installed`        | List installed packages           |
| `dpkg -l`                     | Display installed Debian packages |


## Archives and Compression

| Command                               | Purpose                           |
|---------------------------------------|-----------------------------------|
| `tar -czf archive.tar.gz directory`   | Create a gzip-compressed archive  |
| `tar -xzf archive.tar.gz`             | Extract a gzip-compressed archive |
| `tar -tf archive.tar.gz`              | List archive contents             |
| `gzip file.txt`                       | Compress a file                   |
| `gunzip file.txt.gz`                  | Decompress a gzip file            |


## Bash Scripting

| Syntax                | Purpose                               |
|-----------------------|---------------------------------------|
| `#!/bin/bash`         | Define Bash as the script interpreter |
| `VARIABLE="value"`    | Create a variable                     |
| `$VARIABLE`           | Read a variable                       |
| `$(command)`          | Capture command output                |
| `$1`, `$2`            | Access script arguments               |
| `$?`                  | Read the previous command's exit code |
| `read NAME`           | Read user input                       |
| `chmod +x script.sh`  | Make a script executable              |
| `./script.sh`         | Run a script                          |


Example condition:

```bash
if [ "$USAGE" -gt 80 ]; then
    echo "Disk usage is high"
else
    echo "Disk usage is healthy"
fi
```


Example loop:

```bash
for FILE in config.yml app.py README.md
do
    echo "Processing $FILE"
done
```


Example function:

```bash
check_service() {
    systemctl status cron --no-pager
}

check_service
```


## Useful Keyboard Shortcuts

| Shortcut   | Purpose                              |
|------------|--------------------------------------|
| `Ctrl + C` | Stop the current foreground process  |
| `Ctrl + Z` | Suspend the current process          |
| `Ctrl + D` | Exit the current shell or send EOF   |
| `Ctrl + L` | Clear the terminal                   |
| `Ctrl + R` | Search command history               |
| `Tab`      | Auto-complete commands and paths     |
| `Up Arrow` | View previous commands               |


## Safety Notes

- Check the current directory with `pwd` before deleting files.
- Use `rm -rf` carefully because deletion is immediate.
- Try `kill PID` before using `kill -9 PID`.
- Inspect logs before restarting a failing service.
- Avoid granting `777` permissions unless there is a specific, justified reason.
- Back up important files before editing production configurations.