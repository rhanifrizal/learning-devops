# AWS Introduction

## Objective

Understand the fundamentals of Cloud Computing, why organizations migrate from traditional on-premises infrastructure to the cloud, the different cloud deployment and service models, and why Amazon Web Services (AWS) has become the leading cloud platform used by companies around the world.

---

## What is Cloud Computing?

Cloud Computing is the delivery of computing services such as servers, storage, networking, databases, and software over the internet instead of running everything on local hardware.

Instead of purchasing and maintaining physical servers, organizations rent the resources they need and pay only for what they use.

Cloud computing allows applications to be deployed quickly, scale automatically, and be accessed from anywhere with an internet connection.

---

## Traditional On-Premises Infrastructure

Before cloud computing became popular, companies hosted applications inside their own data centers.

A typical architecture looked like this:

```text
Users
   │
Internet
   │
Company Office
   │
Server Room
```

The company was responsible for purchasing, installing, maintaining, securing, and replacing every server and networking device.

---

## Challenges of On-Premises Infrastructure

Traditional infrastructure comes with several disadvantages:

- High upfront hardware costs
- Long deployment times
- Limited scalability
- Hardware failures
- Ongoing maintenance
- Electricity and cooling costs
- Physical security requirements
- Disaster recovery complexity

As businesses grow, expanding infrastructure often requires purchasing additional hardware, which can take days or even months.

---

## Cloud Computing Architecture

With cloud computing, physical infrastructure is managed by cloud providers.

```text
Users
   │
Internet
   │
AWS Cloud
   │
├── EC2
├── S3
├── RDS
└── CloudWatch
```

Developers and system administrators simply provision the services they need through the cloud provider without managing the underlying hardware.

---

## Benefits of Cloud Computing

Cloud computing provides many advantages over traditional infrastructure.

### Pay-as-you-go

Only pay for the resources you consume.

### Scalability

Resources can be increased or decreased within minutes.

### High Availability

Applications can run across multiple Availability Zones to improve reliability.

### Global Infrastructure

Applications can be deployed closer to users around the world.

### Faster Deployment

New servers can be created in minutes instead of weeks.

### Reliability

Cloud providers operate highly redundant infrastructure with built-in fault tolerance.

### Security

Major cloud providers invest heavily in physical and digital security while offering many security services to customers.

---

## Cloud Deployment Models

### Public Cloud

Infrastructure is owned and operated by a cloud provider.

Examples:

- Amazon Web Services (AWS)
- Microsoft Azure
- Google Cloud Platform (GCP)

---

### Private Cloud

Infrastructure is dedicated to a single organization and managed internally or by a third party.

Often used by organizations with strict compliance or regulatory requirements.

---

### Hybrid Cloud

A combination of on-premises infrastructure and public cloud services.

Example:

```text
Company Datacenter
        │
      VPN
        │
        ▼
 AWS Cloud
```

This allows organizations to gradually migrate workloads to the cloud.

---

## Cloud Service Models

### Infrastructure as a Service (IaaS)

The cloud provider manages the physical infrastructure while customers manage the operating system, applications, and data.

Examples:

- Amazon EC2
- Amazon EBS

---

### Platform as a Service (PaaS)

The cloud provider manages both the infrastructure and operating system, allowing developers to focus only on building applications.

Examples:

- AWS Elastic Beanstalk
- AWS App Runner

---

### Software as a Service (SaaS)

Complete software applications delivered over the internet.

Examples:

- Gmail
- GitHub
- Microsoft 365
- Slack

---

## Why AWS?

Amazon Web Services (AWS) is the world's leading cloud platform.

Reasons for its popularity include:

- Large portfolio of cloud services
- Global infrastructure
- High reliability
- Excellent scalability
- Strong security features
- Pay-as-you-go pricing
- Wide industry adoption
- Strong DevOps ecosystem

Many organizations use AWS to host web applications, APIs, databases, storage, monitoring, machine learning, and serverless applications.

---

## Hands-on Lab

During this lab, I:

- Created and logged into my AWS account
- Switched the AWS Region to **Asia Pacific (Singapore) - ap-southeast-1**
- Explored the AWS Management Console
- Opened AWS CloudShell
- Explored the Services menu
- Familiarized myself with the AWS Console interface

---

## Interview Questions

### What is Cloud Computing?

Cloud Computing is the delivery of computing services over the internet on a pay-as-you-go basis.

---

### What are the benefits of Cloud Computing?

- Scalability
- Cost efficiency
- High availability
- Faster deployment
- Global infrastructure
- Reliability

---

### What is the difference between On-Premises and Cloud?

On-premises infrastructure is owned and maintained by the organization, while cloud infrastructure is managed by a cloud provider.

---

### What is the difference between Public, Private, and Hybrid Cloud?

- Public Cloud → Shared infrastructure provided by cloud providers.
- Private Cloud → Dedicated infrastructure for one organization.
- Hybrid Cloud → Combination of on-premises and public cloud.

---

### What are IaaS, PaaS, and SaaS?

- IaaS → Infrastructure only.
- PaaS → Infrastructure + platform.
- SaaS → Complete software application.

---

### Why is AWS popular?

Because it offers a wide range of cloud services, global infrastructure, scalability, security, and flexible pricing.

---

## Common Mistakes

- Thinking cloud computing is always cheaper than on-premises.
- Confusing IaaS with SaaS.
- Assuming cloud providers manage all security responsibilities.
- Forgetting to choose the correct AWS Region.
- Believing cloud resources are unlimited without cost.

---

## Summary

Cloud Computing allows organizations to rent computing resources instead of purchasing and maintaining physical infrastructure.

AWS is the leading cloud provider because of its global infrastructure, extensive service offerings, scalability, reliability, and security.

Understanding cloud concepts, deployment models, and service models provides the foundation for learning the rest of the AWS ecosystem and modern DevOps practices.