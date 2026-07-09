# Docker Networking

## Objective

Learn how Docker networking enables communication between containers, the host machine, and external networks, and how to publish containerized applications using custom networks and port mapping.


## What is Docker Networking?

Docker networking enables isolated containers to communicate with each other, with the Docker host, and with external networks such as the internet. It provides virtual networks, IP addressing, DNS resolution, and traffic routing for containerized applications.


## Docker Network Types

### bridge

Creates a private, isolated virtual network on the Docker host. It is the default network driver used by Docker and allows containers on the same bridge network to communicate with each other.


### host

Removes the network isolation between the container and the Docker host. The container does not get its own IP address, instead, it binds directly to the host's network interface.


### none

Disconnects the container entirely from any network stack. It receives a loopback interface (127.0.0.1) but lacks a virtual network interface card (NIC), a default gateway, or external routing.


## Port Mapping

*Port mapping* also known as port forwarding, is the mechanism used to expose applications running inside isolated Docker containers to the host machine, your local network, or the internet. By default, containers on a bridge network are completely inaccessible from the outside. Port mapping opens specific pathways through the host's firewall.


## Custom Docker Networks

A custom Docker network is a user-defined virtual network created using `docker network create`. Unlike the default bridge network, custom networks provide automatic DNS-based container name resolution, improved isolation, and easier communication between related containers.

For example, an Nginx container and a backend API container connected to the same custom network can communicate using container names instead of IP addresses.


## Common Docker Commands

### docker network ls

Lists all networks currently available on your local Docker host daemon. It displays the unique Network ID, network name, the underlying driver type, and its management scope.

Example:

```bash
docker network ls
```

**When to use:**
- Verify whether a specific custom network exists before spinning up dependent services or microservices
- Audit your system to identify dangling, unused virtual networks that might be consuming host network resources


### docker network create

Provisions a new, isolated virtual network space on your host machine to establish independent communications zones for your containerized applications.

Example:

```bash
docker network create company-network
```

**When to use:**
- Isolate sensitive multi-container workloads (like backend databases and caches) away from the default public-facing bridge network
- Enable automatic internal DNS resolution so your containers can communicate securely using predictable hostnames instead of volatile IP addresses


### docker network inspect

Returns a highly detailed JSON metadata payload exposing the exact configurations of a target network, including subnets, gateway rules, and a breakdown of all connected containers.

Example:

```bash
docker network inspect company-network
```

**When to use:**
- Troubleshoot connectivity issues by verifying the precise internal IP address dynamically assigned to a malfunctioning container
- Confirm exactly which containers are attached to a specific network segment to ensure proper infrastructure isolation


### docker run --network

Connects a newly created container to an existing Docker network during startup.

Example:

```bash
docker run -d --name nginx-server --network company-network nginx
```

**When to use:**
- Connect containers that need to communicate with each other
- Deploy applications into a predefined network with existing services


### docker run -p

Binds a specific network port on the host machine directly to an internal port inside the container, piercing the network isolation layer to expose your app to the outside world.

Example:

```bash
docker run -d --name nginx-server --network company-network -p 8080:80 nginx
```

**When to use:**
- Route public web traffic (like HTTP requests hitting host port 8080) directly into a private containerized web server running on port 80
- Make a locally hosted development database or administration dashboard accessible to your host operating system tools


### docker network rm

Destroys a custom network configuration from the host system completely, stripping out its virtual bridges, iptables routing configurations, and internal subnets.

Example:

```bash
docker network rm company-network
```

**When to use:**
- Tear down deprecated project architectures during automated CI/CD cleanup pipelines once testing environments are no longer needed
- Remove old, empty virtual networks that are conflicting with newly planned subnet IP ranges on your host machine


## Practical Scenario

During this lab, I created a custom bridge network named `devops-network` and deployed an Nginx container into it.

Using `-p 8081:80`, I mapped the container's internal web server port to port 8081 on my host machine, allowing the application to be accessed from a web browser.

I inspected the network using `docker network inspect`, which showed the attached container, its automatically assigned IP address, subnet, and gateway. Finally, I stopped, restarted, and removed the container before deleting the custom network.


## Interview Questions

### 1. What is Docker networking?

Docker networking allows isolated containers to communicate with each other, with the host operating system, and with external networks or the internet. It manages this communication by creating virtual network interfaces, bridges, and routing rules on the host machine using Linux network namespaces.


### 2. What is the default Docker network?

The default Docker network is a single-host virtual bridge network (usually named bridge on the CLI or docker0 on the host OS system interface). Unless you explicitly specify a network using the --network flag when launching a container, Docker automatically attaches the container to this default network.


### 3. What does `-p 8081:80` mean?

The `-p 8081:80` flag configures port mapping (port forwarding), which publishes a container's internal port to the outside world using the explicit syntax `-p HOST_PORT:CONTAINER_PORT`.


### 4. Why use a custom Docker network?

Production systems use custom (user-defined) Docker networks instead of the default bridge to gain production-grade architecture control, security, and stability.


### 5. What happened when inspecting `devops-network`?

When executing `docker network inspect devops-network`, the Docker daemon returns a detailed JSON metadata payload that reveals the exact real-time configuration and structural state of that specific network.


## Common Mistakes

- Forgetting to publish ports using `-p`.
- Assuming containers on different networks can communicate automatically.
- Removing a network while containers are still attached.
- Confusing the host port with the container port.
- Assuming every container receives the same IP address.


## Notes

This lab was completed using Docker Desktop with WSL integration on Ubuntu.

During the lab, I created a custom Docker bridge network, deployed an Nginx container into it, exposed the web server using port mapping, inspected the network configuration, and learned how Docker assigns IP addresses and manages communication between containers.


## Commands Used

```bash
docker network ls
docker network inspect bridge
docker network create devops-network
docker network inspect devops-network
docker run -d --name company-nginx --network devops-network -p 8081:80 nginx
docker ps
docker logs company-nginx
docker stop company-nginx
docker restart company-nginx
docker rm -f company-nginx
docker network rm devops-network
```