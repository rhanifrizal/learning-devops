# DevOps Pipeline

The DevOps pipeline is a structured workflow that automates the process of planning, developing, testing, releasing, deploying, operating, and monitoring software. It enables teams to deliver software faster, more reliably, and with higher quality through automation and continuous feedback.

8 Stages of DevOps Pipeline:

Planning
    │
    ▼
Coding
    │
    ▼
Building
    │
    ▼
Testing
    │
    ▼
Release
    │
    ▼
Deployment
    │
    ▼
Operations
    │
    ▼
Monitoring

1. Planning:
Teams define project requirements, establish workflows, and outline development goals. This stage aligns the business objectives with the actual technical execution.

2. Coding:
Developers write, review, and organize the application's source code. Version control systems like Git are used to track changes and let multiple developers collaborate without conflicts.

3. Building:
Automation tools compile the raw source code into executable, deployable files. This step packages the application so it is ready for validation. The application dependencies are also downloaded and packaged during this stage, ensuring everything required to run the application is included.

4. Testing:
The built application goes through rigorous automated and manual tests to catch bugs, security vulnerabilities, and performance flaws. Only code that passes these quality checks moves forward in the pipeline. Common automated tests include unit tests, integration tests, security scans, and code quality analysis.

5. Release:
The validated code is prepared for production release. This stage ensures the release meets all business and compliance standards before it is made available to end users. The validated application is versioned and packaged for deployment. Release management ensures that only approved versions move into production.

6. Deployment:
The software is automatically installed and configured into the target environment. This can involve pushing to a staging area for final checks or directly into a live production environment.

7. Operations:
IT operations teams manage and maintain the infrastructure to ensure the application runs smoothly. This includes ongoing maintenance, configuration, and provisioning of servers. The application and infrastructure are managed in production. Teams ensure availability, scalability, backups, security, and incident response.

8. Monitoring:
Teams track the real-time health, performance, and usage of the applications. This continuous feedback identifies issues before they cause crashes and informs future planning. Monitoring includes application health, infrastructure performance, logs, metrics, alerts, and user experience.




## Reflection

1. What surprised me the most?

What surprised me the most is how the process from development and deployment is a lengthy process without the automation by DevOps. After the use of DevOps, everything seems easier and only required a minimum step to deploy.

2. What part of the pipeline do I understand well?

I have the strongest understanding of the Coding stage because I have worked as a Software Engineer for the past three years. The remaining stages are still new to me, and I look forward to learning them throughout this journey.

3. Which technologies are completely new to me?

Most of these technologies are familiar to me at a high level. I have previously used Docker during my university FYP and have basic exposure to Kubernetes. Terraform is the only technology that is completely new to me.

4. If I had to explain DevOps to a friend, how would I explain it?

DevOps is a culture that brings Development and Operations together by automating software delivery. It helps teams build, test, deploy, and maintain applications faster while reducing human error and ensuring consistent environments.