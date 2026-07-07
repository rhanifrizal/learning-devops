# Linux Networking

## Objective

Learn the fundamentals of Linux networking, including IP addressing, routing, DNS, network connectivity testing, and inspecting network services using common Linux networking commands.

## Networking Concepts

### IP Address

IP Address is an Internet Protocol Address which is a unique numerical label assigned to every device connected to a computer network. It is used to find, identify, and communicate with each other over a network or the internet.


### Hostname

A hostname is a unique name assigned to a Linux system to identify it on a network without referring to its IP address.


### DNS

Domain Name System (DNS) acts as the phonebook of the Internet, translating human-readable domain names such as `google.com` into computer-readable IP addresses such as `142.250.190.46`. Without DNS, you would need to remember IP addresses instead of easy-to-read domain names.


### Default Gateway

A default gateway is the router or network device your computer uses to send traffic outside its local network. Whenever your PC communicates with devices on another network or the Internet, the traffic is forwarded to the default gateway for routing.


## Common Linux Commands

| Command                 | Purpose              |
| ----------------------- | -------------------- |
| `ip addr`               | Show IP addresses    |
| `ip route`              | Show routing table   |
| `hostname`              | Show hostname        |
| `ping`                  | Test connectivity    |
| `ss -tuln`              | Show listening ports |
| `curl`                  | Test HTTP endpoints  |
| `wget`                  | Download/test URLs   |
| `nslookup` *(optional)* | DNS lookup           |
| `dig` *(optional)*      | Advanced DNS lookup  |


### ip addr

To view, configure, and manage IP addresses and network interfaces on a Linux system.

Example:

```bash
ip addr
```

**When to use:**
- Checking network connectivity
- Server setup and SSH
- Manual network configuration
- Docker/Container audit

### ip route


To view and manipulate the IP routing table in the Linux kernel. It determines the exact path network packets take to travel from your computer to another destination on your local network or the internet.

Example:

```bash
ip route
```

**When to use:**
- Find your default gateway
- VPN and multi-network environments
- Troubleshoot connectivity issues
- Server hardening

### hostname


To view, change, and manage the network identification name of a Linux system.

Example:

```bash
hostname
hostname -I
```

**When to use:**
- Set up new servers
- Network troubleshooting
- Automation and scripting
- Audit OS Specs


### ping

To test whether a specific device is online and reachable across a network or the internet. 

Example:

```bash
ping google.com
```

**When to use:**
- Test internet connectivity
- Check local gateway health
- Measure latency (lag)
- Verify hostnames


### ss

To inspect network sockets, network connections, and open ports on a Linux system.

Example:

```bash
ss -tulnp
```

**When to use:**
- Identify port conflicts
- Security audit
- Check established connections
- Verify service status


### curl

To transfer data to or from a network server using various protocols (including HTTP, HTTPS, FTP and more). It allows you to interact with websites, download files, and test web applications entirely from the Linux command line.

Example:

```bash
curl https://example.com
```

**When to use:**
- Test and debug APIs
- Automate software installations
- Check website status
- Fetch external IP addresses
- Test redirects


### wget

To download files from the internet. It supports protocols like HTTP, HTTPS, and FTP, and is uniquely designed for reliability over unstable network connections, featuring automated download retries and background execution.

Example:

```bash
wget https://example.com
```

**When to use:**
- Download large production files
- Scripted background downloads
- Archive or scrape web pages
- Automate server provisioning


### nslookup

To query the Domain Name System (DNS) to find the mapping between domain names and IP addresses.

Example:

```bash
nslookup google.com
```

**When to use:**
- Troubleshoot domain connectivity
- Verify mail configuration
- Test alternative DNS providers
- Security audit


### dig

To query the Domain Name System (DNS) servers. 

Example:

```bash
dig google.com
```

**When to use:**
- Deep DNS troubleshoot
- Verify TTL expirations
- Audit email and security records
- Test specific name servers


## Practical Scenario

Explain how you diagnosed a networking issue.

First, I use `ip addr` to verify that the network interface is up and has the correct IP address.

Next, I run `ip route` to identify the default gateway and confirm the routing configuration.

Then I test basic network connectivity using `ping 8.8.8.8`. If it succeeds, I know the server can reach external networks.

After that, I run `ping google.com` to verify that DNS resolution is functioning correctly.

Finally, I use `ss -tuln` to confirm that the application is listening on the expected network port.


## Interview Questions

### 1. What is the purpose of `ping`?

`ping` is used to verify network connectivity and measure latency between two devices.


### 2. Why test both `google.com` and `8.8.8.8`?

Testing both `google.com` and `8.8.8.8` allows you to completely isolate an Internet outage from a DNS configuration failure.


### 3. What does `ss -tuln` show?

`ss -tuln` displays listening TCP and UDP ports, active sockets, and their associated port numbers without resolving service names.


### 4. What is a default gateway?

The default gateway is the router or network device used to forward traffic outside the local network. It acts as the "exit door" from the local network to other networks or the Internet.


### 5. What is DNS?

DNS stands for Domain Name System. It acts as the phonebook of the internet, by translating human-readable website names `google.com` into computer-readable numerical IP addresses `142.250.190.46`.


## Common Mistakes

- Assuming `ping` tests DNS only.
- Forgetting that `ping 8.8.8.8` and `ping google.com` test different things.
- Confusing `ip addr` with `ip route`.
- Assuming a service is reachable simply because it is running.

## Notes

This lab was completed inside Ubuntu running on WSL. The Linux virtual machine received a private IP address (`172.28.x.x`) while my public IP address was different. This demonstrates the difference between private and public IP addressing and how WSL communicates through the Windows host using a virtual network.