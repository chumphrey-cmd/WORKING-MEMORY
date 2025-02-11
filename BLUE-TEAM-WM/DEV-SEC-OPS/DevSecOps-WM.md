# Cloud Security and DevSecOps Automation


- [Cloud Security and DevSecOps Automation](#cloud-security-and-devsecops-automation)
- [(1) DevOps Security Automation](#1-devops-security-automation)
  - [DevOps, Security, and Cloud Essential Toolchain](#devops-security-and-cloud-essential-toolchain)
  - [DevOps Security and Challenges](#devops-security-and-challenges)
    - [DevOps Success Factors](#devops-success-factors)
    - [DevSecOps Resources](#devsecops-resources)
    - [DevOps Toolchain](#devops-toolchain)
      - [Git Concepts](#git-concepts)
      - [GitFlow: Clone and Edit](#gitflow-clone-and-edit)
      - [GitFlow: Commit and Push](#gitflow-commit-and-push)
      - [GitFlow: Share Change with Another Remote](#gitflow-share-change-with-another-remote)
      - [Continuous Integration (CI)](#continuous-integration-ci)
      - [Continuous Delivery/Deployment (CD)](#continuous-deliverydeployment-cd)
      - [Continuous Deployment (CD)](#continuous-deployment-cd)
      - [CI/CD Systems](#cicd-systems)
        - [GitHub Actions](#github-actions)
        - [GitLab CI/CD](#gitlab-cicd)
      - [OpenID Connect](#openid-connect)
        - [OpenID Connect JSON Web Tokens (JWT)](#openid-connect-json-web-tokens-jwt)
        - [CI/CD Security Risks](#cicd-security-risks)
        - [CI/CD Hardening Guidelines (General)](#cicd-hardening-guidelines-general)
      - [Toolchain Potential Attack Vectors](#toolchain-potential-attack-vectors)
        - [Version Control](#version-control)
        - [Continuous Integration (CI) / Continuous Delivery (CD)](#continuous-integration-ci--continuous-delivery-cd)
        - [Secrets Management](#secrets-management)
- [(2) Cloud Infrastructure Security](#2-cloud-infrastructure-security)
- [(3) Cloud-Native Security Operations](#3-cloud-native-security-operations)
- [(4) Microservice and Serverless Security](#4-microservice-and-serverless-security)
- [(5) Continuous Compliance and Protection](#5-continuous-compliance-and-protection)



# (1) DevOps Security Automation



## DevOps, Security, and Cloud Essential Toolchain

| Role                                  | System(s)                               |
|---------------------------------------|-------------------------------------------|
| Version Control                       | GitLab                                   |
| Continuous Integration and Delivery   | GitLab CI/CD                             |
| Configuration Management              | Ansible, Terraform                       |
| Container Execution                   | Docker, Kubernetes (EKS, AKS)            |
| Secrets Storage                       | Vault, AWS SSM, Azure Key Vault           |
| Cloud Infrastructure                  | AWS, Azure                                |

* [DevOps Is For Horses: Stop Making Excuses For Starting](https://devops.com/devops-is-for-horses-stop-making-excuses-for-starting/)  
* [10 Cool Security Tools Open-Sourced By The Internet's Biggest Innovators](https://www.darkreading.com/application-security/10-cool-security-tools-open-sourced-by-the-internet-s-biggest-innovators)  
* [Barclays banks on agile and DevOps to tackle competitive threats in fintech](https://www.computerweekly.com/news/450299551/Barclays-banks-on-agile-and-DevOps-to-tackle-competitive-threats-in-fintech)  
* [DevOps Enterprise Summit](https://itrevolution.com/events/)  
* [GitHub Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

## DevOps Security and Challenges

### DevOps Success Factors

* CAMS (or CALMS) is a common lens for understanding DevOps and for driving DevOps change.  
* ESSENTIALLY the idea of **failing fast** and **failing forward**. It’s not a matter of if you fail or will be compromised, it’s a matter of how fast you can remediate and recover\!

* Your organization succeeds when it reaches "CALMS":

  * **Culture:** people come first  
  * **Automation:** rely on tools for efficiency and repeatability  
  * **Lean:** apply Lean engineering practices to continuously learn and improve  
  * **Measurement:** use data to drive decisions and improvements  
  * **Sharing:** share ideas, information, and goals across silos

* [Kanbans and DevOps](https://itrevolution.com/articles/resource-guide-for-the-phoenix-project-kanbans-part-2/)  
* [Amazon Deployment](https://news.ycombinator.com/item?id=2971521)  
* [Velocity Culture](https://www.youtube.com/watch?v=dxk8b9rSKOo)

### DevSecOps Resources

* [The Phoenix Project](https://itrevolution.com/product/the-phoenix-project/)  
* [The Five Dysfunctions of a Team](https://www.tablegroup.com/product/dysfunctions/)  
* [Building DevOps Culture](https://www.oreilly.com/library/view/building-a-devops/9781449368340/)  
* [The Unicorn Project](https://itrevolution.com/product/the-unicorn-project/)

### DevOps Toolchain

#### Git Concepts

**Key actions/commands:**

* **git clone:** download a project repository from a remote location; check out the most recent commit of the default branch; track the remote location as the "origin" remote  
* **git add:** place a snapshot of a file (new or edited) from the working tree into the staging area  
* **git commit:** record all of the staged changes in the repository, including a message for the history/log  
* **git push:** send changes from the local repository to a remote repository  
* **git pull:** integrate changes from a remote repository into the local repository

**Key Terms:**

* **repository:** history and all branches; compressed (local and remote)  
* **branch:** pointer to a snapshot of your changes  
* **working tree:** checked-out branch; files ready to edit  
* **staging area:** file change snapshots, waiting to be committed to Repository  
* [Atlassian Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)  
* [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow)

#### GitFlow: Clone and Edit

```bash
git clone [https://example-url.com]
# creates "app" directory, as a working tree for org/app.git
# creates "app/.git" directory to hold a local copy of the repository
# creates "app/.git/index" for the staging area
# checks out the default branch into the "app" directory ("main")
# defines a default remote called "origin"

cd app
git checkout -b feature/docs
# change into the working directory and create a feature branch

nano README # edit the README file
git status # show what files have been changed in the working tree
git diff # show changes made to files in the working tree
```


#### GitFlow: Commit and Push

```bash
git add README
# add the changes to README to the staging area

git commit -m "added author to README"
# commit the changes from the staging area to the local repository

git push origin feature/docs
# send the updates from the local repository to the default remote repository
# only the change to README will be sent to the new feature branch


Total 5 (delta 3), reused 0 (delta 0)
remote: To create a merge request for feature/docs, visit:
remote:   https://gitlab.com/org/app/merge_requests/new?merge_request%5Bsource_branch%5D=feature%2Fdocs
```


#### GitFlow: Share Change with Another Remote

```bash
git remote add qa-bill git@git.me:USER/app.git
# define a new remote to share with Bill from the QA group

git push qa-USER main
# share changes with USER, by pushing the code to his repository for review
```

#### Continuous Integration (CI)

* Fundamental Agile development technical practice focusing on incremental changes to code or configuration in small incremental steps that are checked into the main branch frequently to ensure compatibility.

**Approving and completing a merge request creates a commit on the "main" branch and automatically triggers a pipeline:**

* Ensures changes integrate successfully with the rest of the codebase  
* Executes automated unit tests and other automated checks  
  * **Red:** no other check-ins are allowed until the build is fixed  
  * **Green:** creates build artifacts for next steps in CD pipeline  
* Provides fast feedback - build and test steps need to run in a few minutes to encourage iterative development (small, frequent changes)

#### Continuous Delivery/Deployment (CD)

**Pipeline model and control framework extending Continuous Integration:**

* It uses the latest good build from CI, packages for deployment, and release.  
* Changes are automatically pushed to test/staging environments to conduct more realistic/comprehensive tests.  
* It can insert manual reviews/testing/approvals between pipeline stages.  
* Log steps and results to provide audit trail from check-in to deploy.  
* Any failures will "stop the line."  
* No additional changes can be accepted until the failure is corrected.  
* This ensures that code is always ready to be deployed.  
* Changes may be batched up before production release.

**NOTE:** the key difference between delivery and deployment is that **delivery requires human interaction** whereas deployment is automated!

<img src="./files/ContinuousDelivery_vs_Deployment.png">


#### Continuous Deployment (CD)

**Continuous Deployment is how organizations like Amazon, Google, and Netflix push out changes *n* times per day/hour/minute:**

* Changes are deployed directly and automatically to production using the CD pipeline once all tests/checks pass.  
* Self-service - Changes are pushed to production by developers.  
* Blue/Green Deployment - Deploy changes and switch between production environments using load balancing  
* Canaries - Incremental deployment that stops and rolls back if errors occur  
* A/B testing - Measuring the effect/acceptance of a change or new feature in production  
* Dark Launching - Protect changes behind "feature switches"

#### CI/CD Systems

* [Azure DevOps](https://azure.microsoft.com/en-us/products/devops/?nav=min)  
* [CircleCI](https://circleci.com/)  
* [Travis CI](https://www.travis-ci.com/)  
* [Jenkins](https://www.jenkins.io/)  
* [CodePipeline](https://aws.amazon.com/codepipeline/)

##### GitHub Actions

* [GitHub Actions](https://github.com/features/actions)


##### GitLab CI/CD

* [GitLab CI/CD](https://docs.gitlab.com/ee/ci/)  
* [GitLab Auto DevOps](https://docs.gitlab.com/ee/topics/autodevops/)
* [GitLab CI/CD Templates](https://gitlab.com/gitlab-org/gitlab/-/tree/master/lib/gitlab/ci/templates) 

**Predefined Environment Variables**

| Function           | Description                                                                                                                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `CI_BUILDS_DIR`    | Top level directory where builds are executed.                                                                                                                                                            |
| `CI_COMMIT_BRANCH` | The commit branch name. Not available in merge request pipelines or tag pipelines.                                                                                                                         |
| `CI_COMMIT_TAG`    | The commit tag name. Available only in pipelines for tags.                                                                                                                                                 |
| `CI_DEFAULT_BRANCH`| The name of the project's default branch.                                                                                                                                                                 |
| `CI_PIPELINE_ID`   | The instance-level ID of the current pipeline. This ID is unique across all projects on the GitLab instance.                                                                                                |
| `CI_PROJECT_DIR`   | The full path the repository is cloned to, and where the job runs from.                                                                                                                                   |

* [GitLab CI/CI Variables](https://docs.gitlab.com/ee/ci/variables/)
* [Predefined CI/CD Variables](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html)


#### OpenID Connect


**OpenID Connect (OIDC) is concerned with:**

* Authentication and authorization of an end user or machine identity.
* Identity provider issues an identity token with a specific audience for a service provider.
* Identity token claims can be used in authorization decisions by a service provider.
* Identity tokens are signed and valid until they reach an explicit expiration. 



##### OpenID Connect JSON Web Tokens (JWT)


JSON Web Tokens (JWT) are signed by the identity provider (IdP) with claims that identify the issuer, audience, subject, signing key, expiration, and custom data that grants access to a service provider's resources:

* **Header:** Token type (JWT), signing algorithm (HMAC, RSA), and key identifier.
* **Payload:** JSON object that includes the issuer, audience, subject, expiration, and other custom claims.
* **Signature:** Signed header and payload for verifying the token and issuer.


##### CI/CD Security Risks

* [OWASP Top 10 CI/CD Risks](https://owasp.org/www-project-top-10-ci-cd-security-risks/)
* [Attacking and Security CI/CD Pipeline](https://speakerdeck.com/rung/cd-pipeline)


##### CI/CD Hardening Guidelines (General)


* Restrict control flow into production using branch protections and gated approvals.
* Eliminate service account long-lived credentials to help prevent compromise.
* Limit service account permissions.
* Protect the supply chain with allow lists of trusted actions (GH or verified publishers), plugins, and packages.
* Review all changes to workflow files for malicious code execution.
* Patch self-hosted CI/CD runners and software aggressively.
* Include CI/CD audit logs in network and operations monitoring.


**Extra Hardening Resources**
* [Security Hardening for GitHub Actions](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions)
* [GitHub Hardening Actions - Best Practices](https://engineering.salesforce.com/github-actions-security-best-practices-b8f9df5c75f5/)




#### Toolchain Potential Attack Vectors

##### Version Control

1. Threat actor compromises a user's version control credentials and creates an attacker controlled SSH key for accessing source code.

1. Threat actor makes an unauthorized commit, triggering a new release to production that contains a backdoor or trojan.

1. Threat actor modifies a high risk code file (e.g. IaC, cryptography library, authentication module, etc.) without approvals from security team. Releasing changes to high risk code without approvals may violate separation of duties and change approval board requirements.

##### Continuous Integration (CI) / Continuous Delivery (CD)

1. Threat actor discovers a GitLab CI runner exposed on the Internet, and exploits a vulnerability.

1. Threat actor compromises a GitLab CI workflow job and injects malicious code into the build artifacts.

1. User disables a pipeline step enforcing security controls, triggering a release to production that does not meet security or compliance requirements.

1. User approves deployment to production without change approvals.

##### Secrets Management

1. User commits a secret (private key, API key) to the source code repository, which is later used by a threat actor to gain unauthorized access to the system.

1. Threat actor compromises a secrets manager credential by creating a malicious job on the CI / CD server. The secrets manager credential is used to gain access to secrets, code signing certificates, deployment keys, etc. intended for other pipeline jobs.


# (2) Cloud Infrastructure Security


# (3) Cloud-Native Security Operations


# (4) Microservice and Serverless Security


# (5) Continuous Compliance and Protection
