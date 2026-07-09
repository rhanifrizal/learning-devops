1. What is Linux?

Linux is an open-source operating system kernel created by Linus Torvalds in 1991. The kernel is the core component of an operating system that manages communication between software and computer hardware.

2. What is a Linux Kernel?

Linux kernel is the bridge between software and hardware. This kernel manages CPU scheduling, memory, files, network, devices, and processes.

3. What is a Linux Distribution?

Linux Distribution is a combination of Linux Kernel, Package Manager, Desktop GUI (optional), Utilities and Applications. Example of Linux Distribution is Ubuntu, Debian, Fedora, Kali Linux, etc.

4. Why is Linux important in DevOps?

- Most production servers run Linux.
- Docker containers rely on Linux kernel features.
- Most Kubernetes clusters run on Linux nodes.
- Most cloud virtual machines use Linux.
- Linux is designed for automation and scripting.

5. Common Linux Distributions

| Distribution                    | Purpose                      |
| ------------------------------- | ---------------------------- |
| Ubuntu                          | Beginners, servers, cloud    |
| Debian                          | Stability                    |
| Fedora                          | Latest features              |
| Arch                            | Advanced users               |
| Alpine                          | Docker containers            |
| Kali Linux                      | Penetration testing          |
| Red Hat Enterprise Linux (RHEL) | Enterprise servers           |
| Rocky Linux                     | Enterprise (RHEL-compatible) |


6. Windows vs Linux Comparison

| Windows           | Linux            |
| ----------------- | ---------------- |
| GUI-first         | Terminal-first   |
| Mostly commercial | Open source      |
| PowerShell        | Bash             |
| `.exe`            | Binary / Scripts |
| C:\               | `/`              |



## Reflection

### 1. Before this lab, what did I think Linux was?

Before this lab, I knew Linux was an operating system and that it was primarily operated through the command line using Bash. I did not realize that Linux itself is actually just the kernel.

### 2. What surprised me the most?

What surprised me the most is realizing how much of modern software infrastructure runs on Linux. Almost every technology in the DevOps ecosystem, from Docker and Kubernetes to cloud servers, is built on top of Linux.

### 3. Why do almost all DevOps tools run on Linux?

Because it is efficient, also the operating system is open-source and powers the vast majority of cloud infrastructure and containerized environments. It was designed for servers and automation, whereas operating systems like Windows were historically built for interactive desktop use.

### 4. Which Linux distribution have I used before?

I have used Ubuntu, Debian, and Kali Linux before.

### 5. Why are we learning Linux before Docker and Kubernetes?

We are learning Linux before Docker and Kubernetes because both technologies rely heavily on Linux. Understanding the Linux filesystem, processes, networking, and permissions provides a strong foundation before learning containerization and orchestration.