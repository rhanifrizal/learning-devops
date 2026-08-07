# AWS Global Infrastructure

## Objective

Understand the architecture of AWS Global Infrastructure, including Regions, Availability Zones, Edge Locations, Local Zones, and Wavelength Zones. Learn how these components work together to provide high availability, fault tolerance, and low-latency services.

---

## What is AWS Global Infrastructure?

AWS Global Infrastructure is the worldwide network of physical data centers and networking resources that power AWS cloud services.

It consists of:

- Regions
- Availability Zones (AZs)
- Edge Locations
- Local Zones
- Wavelength Zones

Together, these components enable AWS to deliver scalable, reliable, and highly available cloud services across the world.

---

## AWS Global Infrastructure Hierarchy

```text
AWS Global Infrastructure
│
├── Regions
│     ├── Availability Zone A
│     ├── Availability Zone B
│     └── Availability Zone C
│
├── Edge Locations
│
├── Local Zones
│
└── Wavelength Zones
```

---

## AWS Region

An AWS Region is a separate geographic area where AWS operates cloud infrastructure.

Each Region is completely isolated from other Regions.

Examples:

- Asia Pacific (Singapore)
- Asia Pacific (Tokyo)
- Europe (Paris)
- Europe (Ireland)
- Canada (Central)
- US East (Ohio)

Reasons to choose a Region:

- Low latency
- Service availability
- Compliance requirements
- Disaster recovery planning
- Pricing

For this learning journey, the **Asia Pacific (Singapore)** Region (`ap-southeast-1`) is used because it is geographically close to Malaysia and provides low network latency.

---

## Availability Zone (AZ)

An Availability Zone is one or more physically separate data centers within an AWS Region.

Each Availability Zone has independent:

- Power
- Cooling
- Networking

This isolation helps applications remain available even if one Availability Zone experiences an outage.

Example:

```text
Singapore Region
│
├── ap-southeast-1a
├── ap-southeast-1b
└── ap-southeast-1c
```

Production applications are commonly deployed across multiple Availability Zones to improve resilience.

---

## Edge Location

Edge Locations are smaller AWS sites located close to end users.

They are primarily used by services such as:

- Amazon CloudFront
- Amazon Route 53
- AWS Global Accelerator

Instead of running customer workloads, Edge Locations cache content and route traffic closer to users to reduce latency.

---

## Local Zone

A Local Zone extends an AWS Region by placing selected AWS services closer to major cities.

Unlike Edge Locations, Local Zones allow customers to launch supported compute, storage, and networking resources closer to users while remaining connected to the parent Region.

Typical use cases include:

- Video rendering
- Gaming
- Virtual desktops
- Machine learning inference

---

## Wavelength Zone

Wavelength Zones place AWS infrastructure inside telecommunications providers' 5G networks.

They are designed for applications requiring ultra-low latency, such as:

- Autonomous vehicles
- AR/VR
- Live video streaming
- IoT
- Real-time analytics

---

## High Availability

High Availability means designing applications so they continue operating even if one component fails.

A common approach is deploying resources across multiple Availability Zones.

Example:

```text
Singapore Region
│
├── AZ-A
│    └── EC2 Instance
│
└── AZ-B
     └── EC2 Instance
```

If one Availability Zone becomes unavailable, the application can continue serving users from another Availability Zone.

---

## Fault Tolerance

Fault Tolerance is the ability of a system to continue functioning despite failures.

Failures may include:

- Server failure
- Disk failure
- Network failure
- Availability Zone outage

AWS provides the infrastructure required to build fault-tolerant applications, but application architecture must also be designed to support failover.

---

## Global vs Regional Services

| Global Services | Regional Services |
|-----------------|-------------------|
| IAM | EC2 |
| Route 53 | RDS |
| CloudFront | VPC |
| Organizations | S3 (Region-specific buckets) |

Global services operate across AWS Regions, while Regional services are deployed within a specific Region.

---

## Hands-on Lab

Completed activities:

- Selected **Asia Pacific (Singapore)** as the working Region.
- Explored the AWS Management Console.
- Observed available Availability Zones.
- Explored the AWS Global Infrastructure.
- Identified Regions inside and outside Asia.

---

## Interview Questions

### What is an AWS Region?

An AWS Region is a separate geographic location containing multiple Availability Zones.

---

### What is an Availability Zone?

An Availability Zone is one or more isolated data centers within an AWS Region that provide independent power, networking, and cooling.

---

### Why deploy across multiple Availability Zones?

Deploying across multiple Availability Zones improves high availability and reduces the impact of infrastructure failures.

---

### What is an Edge Location?

An Edge Location is an AWS site that caches content and routes traffic closer to end users to reduce latency.

---

### What is the difference between an Edge Location and a Local Zone?

Edge Locations deliver cached content closer to users.

Local Zones allow supported AWS services, such as EC2, to run closer to users.

---

### What is a Wavelength Zone?

A Wavelength Zone extends AWS infrastructure into a telecommunications provider's 5G network to support ultra-low-latency applications.

---

## Common Mistakes

- Assuming a Region contains only one data center.
- Confusing Availability Zones with Regions.
- Thinking Edge Locations and Local Zones are the same.
- Deploying production workloads into a single Availability Zone.
- Selecting a Region without considering latency, compliance, or service availability.

---

## Notes

For this learning project:

- Working Region: **Asia Pacific (Singapore)**
- Region Code: **ap-southeast-1**

This Region was selected because it offers low latency for users in Malaysia and supports the AWS services used throughout this learning journey.

---

## Commands Used

No AWS CLI commands were required during this sprint.

The AWS Management Console was used to explore the global infrastructure.