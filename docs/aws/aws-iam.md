# AWS Identity and Access Management (IAM)

## Overview

AWS Identity and Access Management (IAM) is a service used to control authentication and authorization within an AWS account.

IAM determines:

- **Who** can access AWS resources
- **What** actions they are allowed to perform
- **Which** resources they can access
- **Under what conditions** access is allowed

IAM is a global AWS service, meaning IAM resources such as users, groups, roles, and policies are not tied to a specific AWS Region.

---

## Why IAM Matters

Without proper access control, users or applications could potentially have more permissions than they actually need.

IAM allows administrators to implement:

- Authentication
- Authorization
- Role-based access
- Least privilege
- Temporary access
- Centralized access management

A fundamental security principle when working with IAM is:

> Grant only the permissions required to perform a task and nothing more.

This is known as the **Principle of Least Privilege**.

---

## IAM Core Components

The main IAM components are:

```text
IAM
│
├── Users
├── User Groups
├── Roles
└── Policies
```

Each component serves a different purpose.

---

## IAM Users

An IAM user represents an identity that can interact with AWS.

Examples include:

- Developers
- Administrators
- Operations engineers
- Service accounts

An IAM user can potentially have:

- AWS Management Console access
- Programmatic credentials
- Permissions through policies
- Permissions inherited from groups

During this lab, I created:

```text
devops-learner
```

The user was created specifically for learning and testing IAM permissions.

---

## IAM User Groups

An IAM user group is a collection of IAM users.

Instead of assigning the same permissions individually to many users, permissions can be assigned to a group.

During the lab, I created:

```text
DevOpsLearners
└── devops-learner
```

This demonstrated how permissions can be managed through groups instead of individually assigning every permission to every user.

---

## IAM Policies

IAM policies define permissions.

A policy is normally represented using JSON.

A basic policy contains elements such as:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "service:Action",
            "Resource": "*"
        }
    ]
}
```

Important elements include:

| Element | Purpose |
|---|---|
| Version | Defines the policy language version |
| Statement | Contains one or more permission rules |
| Effect | Determines whether the rule allows or denies access |
| Action | Defines which AWS API actions are affected |
| Resource | Defines which AWS resources the rule applies to |

---

## Understanding Effect

The `Effect` field commonly contains:

```text
Allow
```

or:

```text
Deny
```

For example:

```json
"Effect": "Allow"
```

means the actions defined by the statement are allowed, assuming another applicable policy does not explicitly deny them.

An explicit `Deny` means those actions are explicitly denied.

---

## Understanding Action

`Action` specifies which AWS operations the policy controls.

For example:

```json
"Action": [
    "s3:GetObject",
    "s3:ListBucket"
]
```

These permissions allow specific S3 operations.

- `s3:GetObject` allows reading objects.
- `s3:ListBucket` allows listing objects inside a bucket.

---

## Understanding Resource

`Resource` determines which AWS resources the permission applies to.

Example:

```json
"Resource": "*"
```

This means the statement can apply to all resources supported by those actions.

A more restrictive example is:

```json
"Resource": "arn:aws:s3:::devops-iam-lab"
```

This limits the statement to a specific S3 bucket.

Restricting resources is an important part of implementing least privilege.

---

## AWS-Managed Policies

AWS provides predefined policies called **AWS-managed policies**.

During this lab, I used:

```text
AmazonS3ReadOnlyAccess
```

This policy provides read-only permissions for Amazon S3.

The policy contained actions similar to:

```json
{
    "Effect": "Allow",
    "Action": [
        "s3:Get*",
        "s3:List*",
        "s3:Describe*",
        "s3-object-lambda:Get*",
        "s3-object-lambda:List*"
    ],
    "Resource": "*"
}
```

The important observations were:

```text
Effect   → Allow
Action   → Read/list-related S3 operations
Resource → Broad resource scope
```

---

## Lab: Testing AmazonS3ReadOnlyAccess

After attaching `AmazonS3ReadOnlyAccess`, I logged into AWS using the `devops-learner` IAM user.

I tested several operations.

### Read Existing S3 Resources

The user could:

```text
View S3 bucket       ✅
View iam-test.txt    ✅
Read the object      ✅
```

This was expected because the user had read-only S3 permissions.

### Attempting to Create an S3 Bucket

I then attempted to create another S3 bucket using `devops-learner`.

AWS denied the request.

The important permission involved was:

```text
s3:CreateBucket
```

The read-only policy did not grant this permission.

Therefore:

```text
AmazonS3ReadOnlyAccess
        │
        ├── Read S3 resources     ✅
        │
        └── Create S3 bucket      ❌
```

This demonstrated an important IAM concept:

> If an action is not explicitly allowed by an applicable permission, AWS denies it by default.

This is known as **implicit deny**.

---

## Implicit Deny

AWS authorization starts from a default-deny position.

Conceptually:

```text
Request
   │
   ▼
Is there an applicable Allow?
   │
   ├── No ──────────────> DENY
   │
   └── Yes ─────────────> Continue evaluation
```

Therefore, we do not need to explicitly write a `Deny` statement for every operation a user should not perform.

For example:

```text
s3:CreateBucket
       │
       ▼
No Allow exists
       │
       ▼
Implicit Deny
       │
       ▼
Access Denied
```

---

## Explicit Deny

The next experiment demonstrated **explicit deny**.

I created a customer-managed policy called:

```text
DenyS3LabObjectRead
```

The purpose was to explicitly deny reading objects from the lab bucket.

The user still had read permissions from another policy.

Conceptually:

```text
Policy A
Allow s3:GetObject

        +

Policy B
Deny s3:GetObject

        ↓

Final Result
DENY
```

After applying the explicit deny:

```text
View bucket             ✅
See iam-test.txt         ✅
Open iam-test.txt        ❌
Download iam-test.txt    ❌
```

When attempting to access the object, AWS reported that access was denied because there was an:

```text
explicit deny in an identity-based policy
```

This demonstrated one of the most important IAM authorization rules:

> An applicable explicit Deny overrides an Allow.

---

## IAM Authorization Simplified

A useful simplified model is:

```text
Default
   │
   ▼
Implicit Deny
   │
   ▼
Explicit Allow?
   │
   ├── No ──────────────> DENY
   │
   └── Yes
          │
          ▼
   Explicit Deny?
          │
          ├── Yes ──────> DENY
          │
          └── No ───────> ALLOW
```

Therefore:

```text
No Allow
= DENY

Allow
= ALLOW

Allow + Explicit Deny
= DENY
```

---

## IAM Roles

IAM roles are another type of AWS identity.

Unlike an IAM user, a role is generally intended to be **assumed** by an authorized principal or AWS service.

Examples include:

- EC2 instances
- Lambda functions
- AWS services
- Another AWS account
- Federated identities

During this lab, I created:

```text
EC2-S3-ReadOnly-Role
```

The role used:

```text
AmazonS3ReadOnlyAccess
```

and trusted:

```text
ec2.amazonaws.com
```

---

## Trust Policy vs Permission Policy

IAM roles involve two important concepts:

```text
IAM Role
│
├── Trust Policy
└── Permission Policy
```

### Trust Policy

The trust policy determines:

> **WHO can assume the role?**

For the EC2 role created during the lab:

```json
"Service": "ec2.amazonaws.com"
```

This means EC2 is trusted to assume the role.

### Permission Policy

The permission policy determines:

> **WHAT can the role do after it has been assumed?**

For example:

```text
AmazonS3ReadOnlyAccess
```

allows the role to perform read-related S3 operations.

An easy way to remember this is:

```text
Trust Policy
     ↓
WHO can use the role?

Permission Policy
     ↓
WHAT can the role do?
```

---

## Why Roles Are Important

Suppose an EC2 application needs to read data from S3.

A poor approach would be storing long-lived AWS access keys directly inside:

- Source code
- Environment files
- Docker images
- Configuration files
- Git repositories

Instead:

```text
EC2 Instance
      │
      ▼
Assumes IAM Role
      │
      ▼
Receives temporary credentials
      │
      ▼
Accesses AWS resources
```

This reduces the need to manage long-lived credentials manually.

---

## Principle of Least Privilege

The AWS-managed `AmazonS3ReadOnlyAccess` policy was useful for learning, but it provided broader access than our lab actually required.

Instead of granting read access across S3 generally, I created a customer-managed policy:

```text
S3LabReadOnlyPolicy
```

The goal was to allow access only to:

```text
devops-iam-lab
```

---

## Custom Least-Privilege Policy

The policy created during the lab was:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListLabBucket",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::devops-iam-lab"
        },
        {
            "Sid": "ReadObjectsInLabBucket",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::devops-iam-lab/*"
        }
    ]
}
```

Notice that two different resource ARNs are used.

For the bucket itself:

```text
arn:aws:s3:::devops-iam-lab
```

For objects inside the bucket:

```text
arn:aws:s3:::devops-iam-lab/*
```

This distinction is important because `ListBucket` operates against the bucket while `GetObject` operates against objects inside the bucket.

---

## Least-Privilege Test Results

After applying the restricted policy, I tested the `devops-learner` user again.

### Test 1 — List All S3 Buckets

Result:

```text
❌ DENIED
```

AWS indicated that:

```text
s3:ListAllMyBuckets
```

was required.

This permission was intentionally not included.

### Test 2 — Directly Access the Lab Bucket

I opened the specific bucket directly:

```text
devops-iam-lab
```

Result:

```text
✅ ALLOWED
```

This demonstrated that failing to list all S3 buckets does not necessarily mean the user cannot access a specific bucket.

### Test 3 — List Objects

Inside `devops-iam-lab`, I could see:

```text
iam-test.txt
```

Result:

```text
✅ ALLOWED
```

The relevant permission was:

```text
s3:ListBucket
```

### Test 4 — Read/Download Object

I opened and downloaded:

```text
iam-test.txt
```

Result:

```text
✅ ALLOWED
```

The relevant permission was:

```text
s3:GetObject
```

### Test 5 — Create Another Bucket

I attempted to create another bucket.

Result:

```text
❌ DENIED
```

The user did not have:

```text
s3:CreateBucket
```

Therefore AWS applied implicit deny.

---

## Console Visibility vs Resource Access

One interesting result from this lab was:

```text
S3 Console
│
├── List all account buckets
│      │
│      └── s3:ListAllMyBuckets ❌
│
└── Direct access to devops-iam-lab
       │
       ├── s3:ListBucket ✅
       └── s3:GetObject  ✅
```

The user could not list all buckets from the main S3 bucket listing page.

However, when accessing `devops-iam-lab` directly, the user could:

- View the bucket
- List `iam-test.txt`
- Open `iam-test.txt`
- Download `iam-test.txt`

This demonstrates that:

> Console visibility and authorization to a specific AWS resource are not always the same thing.

This is useful when troubleshooting IAM permissions.

---

## Broad Permission vs Least Privilege

Initially:

```text
AmazonS3ReadOnlyAccess
        │
        ▼
Broad read-only S3 access
```

Later:

```text
S3LabReadOnlyPolicy
        │
        ▼
devops-iam-lab only
        │
        ├── List objects
        └── Read objects
```

The second approach is closer to the principle of least privilege because permissions are limited by both:

```text
Action
+
Resource
```

---

## AWS-Managed vs Customer-Managed Policies

### AWS-Managed Policy

Created and maintained by AWS.

Example:

```text
AmazonS3ReadOnlyAccess
```

Advantages:

- Easy to use
- Maintained by AWS
- Useful for common permission patterns

However, it may provide broader permissions than a specific workload requires.

### Customer-Managed Policy

Created and maintained within an AWS account.

Examples from this lab:

```text
DenyS3LabObjectRead
S3LabReadOnlyPolicy
```

Advantages:

- Greater control
- Can restrict specific actions
- Can restrict specific resources
- Useful for implementing least privilege

---

## IAM Users vs Roles

| IAM User | IAM Role |
|---|---|
| Represents an identity | Represents an assumable identity |
| Can have console access | Usually assumed when needed |
| Can have long-lived credentials | Commonly uses temporary credentials when assumed |
| Permissions can be attached | Permissions can be attached |
| Does not use a role trust policy | Uses a trust policy |

For AWS workloads such as EC2, roles are generally preferable to embedding long-lived access credentials.

---

## Lab Architecture

The IAM lab progressed through several stages:

```text
IAM Fundamentals
        │
        ▼
Create IAM User
devops-learner
        │
        ▼
Create IAM Group
DevOpsLearners
        │
        ▼
AWS-Managed Policy
AmazonS3ReadOnlyAccess
        │
        ▼
Permission Testing
├── Read object ✅
└── Create bucket ❌
        │
        ▼
Explicit Deny Experiment
DenyS3LabObjectRead
        │
        └── GetObject ❌
        │
        ▼
IAM Role
EC2-S3-ReadOnly-Role
├── Trust Policy
└── Permission Policy
        │
        ▼
Least Privilege
        │
        ▼
S3LabReadOnlyPolicy
├── List specific bucket ✅
├── Read specific objects ✅
├── List all buckets ❌
└── Create bucket ❌
        │
        ▼
Resource Cleanup
```

---

## Security Best Practices

### 1. Follow Least Privilege

Avoid granting permissions such as:

```json
{
    "Effect": "Allow",
    "Action": "*",
    "Resource": "*"
}
```

unless they are genuinely required.

Prefer specific actions and resources.

### 2. Prefer Roles for AWS Workloads

Applications running on services such as EC2 should generally use IAM roles rather than storing long-lived AWS credentials inside the application.

### 3. Understand Explicit Deny

An explicit deny overrides an applicable allow.

This is important when troubleshooting unexpected `AccessDenied` errors.

### 4. Avoid Long-Lived Credentials Where Possible

Long-lived credentials increase risk if they are accidentally:

- Committed to Git
- Included in Docker images
- Shared publicly
- Stored insecurely

Use temporary credentials and IAM roles where appropriate.

### 5. Never Commit AWS Credentials

Credentials should never be stored in:

- Git repositories
- README files
- Dockerfiles
- Application source code
- Public documentation

### 6. Remove Temporary Lab Resources

Cloud labs should include cleanup.

Unused resources can:

- Increase security exposure
- Cause confusion
- Accumulate unnecessary infrastructure
- Potentially generate costs depending on the service

---

## Lab Cleanup

After completing the IAM exercises, all temporary resources were removed.

The cleanup included:

```text
IAM User
└── devops-learner              ✅ Deleted

IAM Group
└── DevOpsLearners              ✅ Deleted

Customer-Managed Policies
├── DenyS3LabObjectRead         ✅ Deleted
└── S3LabReadOnlyPolicy         ✅ Deleted

IAM Role
└── EC2-S3-ReadOnly-Role        ✅ Deleted

S3
├── iam-test.txt                ✅ Deleted
└── devops-iam-lab              ✅ Deleted
```

I verified the cleanup in the AWS Console:

```text
IAM Users               → No resources to display
IAM User Groups         → No resources to display
Customer-managed Policy → Lab policies removed
IAM Roles               → EC2-S3-ReadOnly-Role removed
S3 Buckets              → No buckets
```

The AWS-managed policy:

```text
AmazonS3ReadOnlyAccess
```

was not deleted because it is maintained by AWS rather than being a customer-managed policy created during the lab.

---

## Common IAM Troubleshooting Approach

When receiving:

```text
AccessDenied
```

check the request systematically:

```text
1. Who is making the request?
        ↓
2. What AWS action is being attempted?
        ↓
3. Which resource is being accessed?
        ↓
4. Is there an applicable Allow?
        ↓
5. Is there an applicable explicit Deny?
        ↓
6. Does the policy Resource match the target?
```

For example:

```text
User:
devops-learner

Action:
s3:GetObject

Resource:
arn:aws:s3:::devops-iam-lab/iam-test.txt
```

Then inspect the policies affecting that identity.

---

## Common Mistakes

### Mistake 1 — Assuming ReadOnly Means Everything Is Visible

A user may have permission to read a specific resource without having permission to discover every resource through the AWS Console.

### Mistake 2 — Confusing ListBucket with ListAllMyBuckets

These permissions perform different operations.

```text
s3:ListBucket
```

lists objects in a particular bucket.

```text
s3:ListAllMyBuckets
```

allows listing the account's buckets through the relevant S3 API operation.

### Mistake 3 — Using the Wrong S3 ARN

Bucket:

```text
arn:aws:s3:::devops-iam-lab
```

Objects:

```text
arn:aws:s3:::devops-iam-lab/*
```

Using the wrong resource ARN can result in unexpected access denial.

### Mistake 4 — Assuming Allow Always Wins

It does not.

```text
Allow + Explicit Deny
        ↓
       DENY
```

### Mistake 5 — Giving Applications Permanent Credentials

AWS workloads should generally use IAM roles and temporary credentials instead of hardcoded access keys.

---

## Interview Questions

### What is AWS IAM?

IAM is AWS's identity and access management service used to control who can access AWS resources and what actions they can perform.

### What is the Principle of Least Privilege?

Users and workloads should receive only the minimum permissions necessary to perform their required tasks.

### What is the difference between an IAM user and IAM role?

An IAM user represents an identity with permissions and potentially long-lived credentials, while an IAM role is an assumable identity that commonly provides temporary credentials.

### What is an IAM policy?

An IAM policy is a JSON document that defines permissions for AWS actions and resources.

### What happens if no policy allows an action?

The action is denied through **implicit deny**.

### What happens if one policy allows an action but another explicitly denies it?

The request is denied because an applicable **explicit deny overrides allow**.

### What is the difference between a trust policy and permission policy?

A trust policy determines:

```text
WHO can assume the role
```

A permission policy determines:

```text
WHAT the role can do
```

### What is the difference between AWS-managed and customer-managed policies?

AWS-managed policies are created and maintained by AWS.

Customer-managed policies are created and maintained within the AWS account and can be customized for specific requirements.

### Why should EC2 use IAM roles instead of hardcoded access keys?

IAM roles allow EC2 workloads to obtain temporary credentials without embedding long-lived credentials in application code or configuration.

### Why could a user access an S3 bucket directly but not see it on the main bucket list?

The user may have:

```text
s3:ListBucket
```

for the specific bucket but not:

```text
s3:ListAllMyBuckets
```

These are separate permissions.

### What is the difference between s3:ListBucket and s3:GetObject?

`s3:ListBucket` allows listing objects within a bucket.

`s3:GetObject` allows retrieving an individual object.

They also apply to different resource ARN formats.

---

## Key Takeaways

The most important concepts from this lab were:

```text
IAM
│
├── User
│   └── Identity
│
├── Group
│   └── Organizes users and permissions
│
├── Policy
│   └── Defines permissions
│
├── Role
│   └── Assumable identity
│
├── Trust Policy
│   └── WHO can assume a role
│
├── Permission Policy
│   └── WHAT actions are allowed
│
├── Implicit Deny
│   └── No applicable Allow → Denied
│
├── Explicit Deny
│   └── Overrides applicable Allow
│
└── Least Privilege
    └── Grant only required permissions
```

The biggest lesson from the hands-on exercise was that IAM is not simply about giving users "access."

Effective IAM requires understanding the relationship between:

```text
Identity
+
Action
+
Resource
+
Policy evaluation
```

By restricting both actions and resources, permissions can be designed much more securely.

---

## Sprint 5.3 Completion

During this sprint I successfully practiced:

- IAM users
- IAM user groups
- AWS-managed policies
- Customer-managed policies
- Console access
- S3 permission testing
- Implicit deny
- Explicit deny
- IAM roles
- Trust policies
- Permission policies
- Least-privilege policy design
- Resource-level S3 permissions
- IAM troubleshooting
- AWS resource cleanup

**Sprint 5.3 — AWS IAM Fundamentals: Completed ✅**