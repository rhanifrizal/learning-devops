1. What is Continuous Integration?
Continuous Integration (CI) is the practice of automatically building, testing, and validating every code change after a developer pushes code to the repository. It ensures that new changes can be safely integrated into the main project without breaking existing functionality.

2. What is Continuous Delivery?
The software is automatically prepared for production, but deployment to production requires manual approval.

3. What is Continuous Deployment?
Continuous Deployment automatically releases every successful code change to production without requiring manual approval.


Comparison Table:

| Feature                         | CI | Continuous Delivery | Continuous Deployment |
| ------------------------------- | -- | ------------------- | --------------------- |
| Automatic Build                 | ✅ | ✅                | ✅                     |
| Automatic Testing               | ✅ | ✅                | ✅                     |
| Automatic Deploy to Staging     | ❌ | ✅                | ✅                     |
| Manual Approval                 | ❌ | ✅                | ❌                     |
| Automatic Production Deployment | ❌ | ❌                | ✅                     |


## Reflection

1. Which concept was easiest to understand?
The concepts were relatively straightforward because they build on one another. Once I understood Continuous Integration, it became much easier to understand the differences between Continuous Delivery and Continuous Deployment.

2. Which concept was the most confusing?
At this stage, none of the concepts are particularly confusing because they build upon one another. Understanding Continuous Integration made it easier to understand Continuous Delivery and Continuous Deployment.

3. Which approach would you choose for a banking application? Why?
For a banking application, I would choose Continuous Delivery because banking systems are critical and require manual review and approval before deploying to production.

4. Which approach would you choose for a startup? Why?
For startup, it would be better to use Continuous Deployment because speed matters.

5. If I had to explain CI/CD to a friend in one minute, what would I say?
CI/CD is a software development practice that automates the process of building, testing, and delivering applications. Continuous Integration ensures code changes are safely integrated into the project, while Continuous Delivery or Continuous Deployment automates the release process, making software delivery faster, more reliable, and less prone to human error.

CI: Frequently integrates code changes from multiple developers into the main project. Automated builds and tests help detect bugs early and prevent integration issues.

CD: Automates the release process by preparing verified software for deployment. Depending on the organization, deployment may require manual approval (Continuous Delivery) or happen automatically (Continuous Deployment).