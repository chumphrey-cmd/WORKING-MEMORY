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
  - [Secuing DevOps Workflows](#secuing-devops-workflows)
    - [Pre-Commit Security Controls](#pre-commit-security-controls)
      - [Rapid Risk Assessments (RRA)](#rapid-risk-assessments-rra)
      - [Threat Modeling in DevOps](#threat-modeling-in-devops)
        - [Code Analysis Tools](#code-analysis-tools)
      - [Git Commit/Workflow Hooks](#git-commitworkflow-hooks)
      - [Pre-Commit framework](#pre-commit-framework)
      - [Manual Code Reviews](#manual-code-reviews)
      - [Mandatory Code Reviews: Branch Protections](#mandatory-code-reviews-branch-protections)
      - [Version Control Security: GitHub Branch Protections](#version-control-security-github-branch-protections)
      - [Branch Protections: GitLab Branch Protections](#branch-protections-gitlab-branch-protections)
      - [Detecting High Risk Code Changes: Code Owners](#detecting-high-risk-code-changes-code-owners)
    - [Commit Security Controls (Broad Overview)](#commit-security-controls-broad-overview)
      - [Continuous Integration (CI) Security Testing Limitations](#continuous-integration-ci-security-testing-limitations)
      - [Centralized Security Scanning Factory](#centralized-security-scanning-factory)
      - [Security Factory Integration](#security-factory-integration)
      - [Automated Security Testing Goals](#automated-security-testing-goals)
      - [Automated Security Testing: Minimize False Positives](#automated-security-testing-minimize-false-positives)
      - [Automated Security Testing: Customizing Tools\*](#automated-security-testing-customizing-tools)
      - [Automated Security Testing: Parsing \& Displaying Results](#automated-security-testing-parsing--displaying-results)
      - [Automated Code Scanning Technology Landscape](#automated-code-scanning-technology-landscape)
      - [Semgrep - Secure Code Analysis](#semgrep---secure-code-analysis)
      - [Semgrep - Scan Command Line Interface](#semgrep---scan-command-line-interface)
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
  * <span style="color:red"> Red</span>: no other check-ins are allowed until the build is fixed  
  
  * <span style="color:green"> Green</span>: creates build artifacts for next steps in CD pipeline  
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

2. Threat actor makes an unauthorized commit, triggering a new release to production that contains a backdoor or trojan.

3. Threat actor modifies a high risk code file (e.g. IaC, cryptography library, authentication module, etc.) without approvals from security team. Releasing changes to high risk code without approvals may violate separation of duties and change approval board requirements.

##### Continuous Integration (CI) / Continuous Delivery (CD)

1. Threat actor discovers a GitLab CI runner exposed on the Internet, and exploits a vulnerability.

2. Threat actor compromises a GitLab CI workflow job and injects malicious code into the build artifacts.

3. User disables a pipeline step enforcing security controls, triggering a release to production that does not meet security or compliance requirements.

4. User approves deployment to production without change approvals.

##### Secrets Management

1. User commits a secret (private key, API key) to the source code repository, which is later used by a threat actor to gain unauthorized access to the system.

2. Threat actor compromises a secrets manager credential by creating a malicious job on the CI / CD server. The secrets manager credential is used to gain access to secrets, code signing certificates, deployment keys, etc. intended for other pipeline jobs.



## Secuing DevOps Workflows


**DevOps Workflow Phases**


<img src="./files/DevOps_Workflow.png">


**DevSecOps Critical Security Controls**


<img src="./files/DevSecOps_Critical_Security_Controls.png">



[Artifical Intelligence (AI) in the DevSecOps Workflow](https://drive.google.com/file/d/1DXd1BHp6STMctDVbjnW0jxofWEgau0b-/view)


<img src="./files/AI_DevSecOps_Continum.png">



### Pre-Commit Security Controls

**Pre-Commit:** Activities before code is checked into version control.

**Specific Controls:**

* **Threat Modeling:**
    * Description: Incremental design review, rapid risk assessment for new services or major changes.

* **IDE Security Plugins:**
    * Description: Code editor static analysis and linting plugins.

* **Pre-Commit Hooks:**
    * Description: Commit hooks to check for embedded secrets and enforce review workflows.

* **Peer Code Review:**
    * Description: Security code reviews.



#### Rapid Risk Assessments (RRA)

* Process of quickly asssessing the safety and security of legacy or new applications.

* For new systems/services, start with a high-level risk assessment:

  * Classify the data: legal and compliance requirements, sensitivity, etc.

  * Focus on platform, language, and framework risks: is the team using well-understood tools/approach or something new to the organization?

  * Determine a risk rating and next steps: threat modeling, control gate requirements, security training...

  * Continuously reassess as major changes to design or data occur


* [Mozilla RRA](https://infosec.mozilla.org/guidelines/risk/rapid_risk_assessment.html)

* [Slack RRA](https://slack.engineering/moving-fast-and-securing-things/)



#### Threat Modeling in DevOps

* Iterative and lightweight threat modeling based on risk: early in design or when making major changes.
* Examine trust boundaries and assumptions in architecture.
* Ask these questions when you are making changes (based on SAFECode's Tactical Threat Modeling Guide):
    1. Are you changing the attack surface?
    2. Are you changing the technology stack?
    3. Are you changing application security controls?
    4. Are you adding confidential/sensitive data?
    5. Are you modifying high-risk code?


##### Code Analysis Tools



* [Sloc Cloc and Code (scc)](https://github.com/boyter/scc)
  * For counting the lines of code, blank lines, comment lines, and physical lines of source code in many programming languages. Used to begin the code analysis process...

* [Semgrep](https://github.com/returntocorp/semgrep): VSCode plugin
* [Checkov](https://github.com/bridgecrewio/checkov): VSCode plugin
* [cfn_nag](https://github.com/stelligent/cfn_nag): VSCode plugin
* [IntelliJ IDEA built-in code analysis](https://www.jetbrains.com/help/idea/code-inspection.html) (Includes some basic security checks)
* [FindBugs](http://findbugs.sourceforge.net/manual/eclipse.html): Eclipse plugin
* [FindBugs](https://plugins.jetbrains.com/plugin/3847-findbugs-idea): IntelliJ plugin
* [SpotBugs](https://spotbugs.github.io/): Eclipse plugin
* [Find Security Bugs](https://find-sec-bugs.github.io/): (Based on FindBugs/SpotBugs, with additional security checks)
* [Puma Scan](https://pumasecurity.io/): Visual Studio plugin for C# (Open-source and commercial)
    * Presentation: [Secure DevOps: A Puma's Tail](https://www.slideshare.net/pumasecurity/secure-devops-a-pumas-tail)
* [Security Code Scan](https://security-code-scan.github.io/): Visual Studio plugin for C# (Open-source)
* [Microsoft DevSkim](https://github.com/Microsoft/DevSkim)
* [SonarLint](https://www.sonarlint.org/)
* [Trivy](https://marketplace.visualstudio.com/items?itemName=AquaSecurityOfficial.trivy-vulnerability-scanner)
* [SARIF Viewer](https://marketplace.visualstudio.com/items?itemName=MS-SarifVSCode.sarif-viewer)


#### Git Commit/Workflow Hooks

Commit hooks can be used to automatically run scripts checking for embedded secrets, code correctness, etc. at different points in workflows:

* **Local repository:** pre-commit, prepare-commit, commit, post-commit, post-checkout, pre-rebase
* **Remote repository:** pre-receive, update, post-receive
* Implement team-wide workflow policies or check code for problems before CI
* Repo owners can alter/uninstall hooks
* Hooks cannot be enforced in local clones of the repository


#### Pre-Commit framework

Yelp's multi-language pre-commit hook package manager helps install and configure hooks.

* Add a `.pre-commit-config.yaml` in the repository root directory.
* Configure hooks written in multiple languages (Python, Node, Ruby, Shell scripts, Docker, etc.).
* Create a default hook configuration for newly cloned local repositories.
* Re-run and verify hooks in CI/CD pipelines.

**[pre-commit](https://pre-commit.com/#install)**
* A framework for managing and maintaining multi-language pre-commit hooks



#### Manual Code Reviews


Peer code reviews are required to find problems that automated tools do not find:

* **Security team sets policies and trains developers** on how to do security code reviews. Create checklists for the team.
* Look for problems that static analysis tools don't find.
* Developers can easily be taught to find mistakes in using security features/libraries, and security "code smells": backdoors, hardcoded secrets, hand-rolled crypto, suspect code...
* **Identify and tag high-risk code** (security features and libraries, public APIs...) and ensure that changes are reviewed by experts.



#### Mandatory Code Reviews: Branch Protections

**Branch Protections** prevent harmful actions and unauthorized commits against release branches (e.g., develop/main).

* Prevent deleting release branches.
* Prevent pushing commits directly to release branches.
* Require a pull/merge request to be opened for merging changes into the branch.
* Define code review/approval review requirements, which can vary by provider.




#### Version Control Security: GitHub Branch Protections


* **GitHub Branch Protection Rule**
    * Require pull request approvals before merging.
    * Apply restrictions to project administrators.
    * Require signed commits. (optional)
    * Disable force pushes.
    * Disable deletion.



#### Branch Protections: GitLab Branch Protections


* **GitLab Protected Branches**
    * Require merge requests to commit to the branch.
    * It defines the role that can complete a merge request.
    * It prevents all users from pushing to the branch.
    * It enables the CodeOwners approval workflow.



#### Detecting High Risk Code Changes: Code Owners


**Detecting High Risk Code Changes: Code Owners**

Inventory high risk code and identify groups or individuals responsible for approvals:

* Create a CODEOWNERS file in the repository root directory.
* Define directories or individual files in the CODEOWNERS file.
* Require one (or many) approvers during the pull request workflow to review changes to these files.
* This allows the security team to participate in the GitFlow workflow.


**High-risk Code Includes:**


* security controls (authentication, password handling, access control, output encoding libraries, data entitlement checks, user management, crypto methods)
* admin functions
* application code that works with private data
* runtime frameworks
* public network-facing APIs
* legacy code that is known to be tricky to change (high complexity...) or that is known to be buggy
* release/deployment scripts or tooling


### Commit Security Controls (Broad Overview)


**COMMIT:** Security checks in automated build and CI steps

**SOURCE CODE ANALYSIS:** Incremental or high-signal code analysis (SAST) using only rules with high confidence / low false positives.

**SOFTWARE SUPPLY CHAIN:** Software bill of materials, provenance, component and dependency analysis. Signing and storing build artifacts in a secure repository (more on this later).

**CLOUD NATIVE SECURITY:** Configuration file analysis and policy enforcement for Dockerfile, container images, Kubernetes manifests, and Kubernetes policy as code (more on this later).


#### Continuous Integration (CI) Security Testing Limitations

**Challenges for Inline Security Testing/Scanning in Development-Focused Pipelines:**

* **Rapid CI Cycling:** Demands fast, fully automated, reliable, repeatable, unambiguous, and accurate testing.
* **Security Testing Requirements:** Must be fast, incremental, and accurate.
* **Time Constraints:** Development build pipelines typically complete in 5-10 minutes.

**NOTE:**

* Long-running security testing and scanning must be performed outside the CI pipeline (out of band).
* **TIME, SPEED, AND AGILITY** is of the essence here. If a security scan that is being conducted increases the development build pipeline **greater than** 5-10 mins, you're conducting the scan in the wrong area!



#### Centralized Security Scanning Factory

Following DevOps patterns, security teams can build their own security focused pipelines for managing their workflow:

* Security teams receive a request (or automated hook) to start their process
* Engineers conduct penetration tests, code/design reviews, training, deep scanning, tool building/integration, audits

* Leverages workflow automation concepts, patterns, and practices
* Allows security teams to integrate with engineering CI/CD pipelines

* Centralizes security scanning intelligence for analysis in SIEM systems
* Validates findings and creates tickets for actionable findings

* Scales across an enterprise for hundreds (or thousands) of pipelines

* [Bag of Holding](https://github.com/aparsons/bag-of-holding)
  * FOSS App-Sec management tool that you can use to hold an application inventory and classification for secure pipeline development.




#### Security Factory Integration

<img src="./files/Security_Factory_Pipelines.png">


Four Distinct Stages: The pipeline is divided into four stages: **Intake**, **Triage**, **Test**, and **Delivered**.

* **Intake**: Customers request security services (dynamic, static, manual assessments) through an application repository. They select an existing application or provide details for a new one. This is the initial interaction or "first impression."

* **Triage**: Determines the appropriate security services to apply based on the request. Automated scans might trigger specific actions, like a ZAP scan. This is the assessment and planning phase.

* **Test**: The core of the pipeline. Automates security tools, collects results in a central repository, and reviews findings for false positives. This is the execution and analysis phase.

* **Delivered**: Results are distributed to the customer. Pipelines often integrate with defect trackers and generate summary metrics/reports for management. This is the reporting and remediation phase.



#### Automated Security Testing Goals

Provide fast and clear feedback on code commit:

* Run code scans in parallel with unit testing for speed.
* Run high-risk checks early in the pipeline to "fail fast."
* Do incremental scanning, if possible, as deep scanning takes too long for CI/CD, especially on large codebases.
* Set a max time limit with the dev team, alert if the limit is breached and fix it.
* Select tools with output formats that can be parsed and return results directly to developers using their IDE or backlog ticketing system (JIRA, GitHub, GitLab)
* Run full/long running scans are scheduled (nightly) or from the security scanning factory.


**Deep Scanning vs. Incremental Scanning**

* **Full Scans:** Can take hours or days, unsuitable for CI/CD timeframes.
* **Incremental Scans:** Many SAST tools offer incremental scanning of changed code, updating a cached abstract model. Limitations may exist in check types or accuracy.
* **Deeper Scanning:** Should be done periodically, outside the CI/CD pipeline (e.g., overnight, on-demand). Manual review and triage are recommended.
* **Feedback Mechanisms:** Findings can be delivered to engineers via IDEs, backlog tickets, API integration, or vulnerability managers.
    * [Archerysec](https://www.archerysec.com/)
    * [OWASP Defect Dojo](https://www.defectdojo.org/)


#### Automated Security Testing: Minimize False Positives

Developers will tune out results if you don't tune out false positives:

* Carefully review rules and identify which checks provide high-confidence results.
* Configure the pipeline to stop if these checks fail.
* Turn off noisy, low-confidence checks in the pipeline
* Run low confidence checks in the security scanning factory, validate the findings manually, and send true positive findings to the development team's backlog.
* Periodically review and re-tune rules and configurations.

**Pro tip:**

Store tool configurations, disabled rules, and custom rules in version control to keep a history of decisions for compliance and governance.



#### Automated Security Testing: Customizing Tools*

Security scanning tools have built-in, default rule sets that run out of the box. However, every product uses different naming conventions, patterns, and frameworks:

* Although very few teams do this, you may need to write your own rules using tool plugins or scripts.
* Custom rules can help to enforce your team's specific guidelines.
* For maximum coverage, you will need to run multiple tools, such as SAST, Software Supply Chain, Infrastructure as Code (IaC), Kubernetes, and DAST
* Different scanning approaches find different problems, so make sure you understand what each tool is good at and what its blind spots are.
* Use a vulnerability manager solution to schedule scans, consolidate results, filter duplicates, perform differential analysis, and identify new risks.

* **Resources:**
  * [Static Analysis (SAST)](https://github.com/analysis-tools-dev/static-analysis)
  * [IaC Security Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Infrastructure_as_Code_Security_Cheat_Sheet.html)



#### Automated Security Testing: Parsing & Displaying Results

Running security tools in CI/CD requires a supported machine-readable output format.

* **xUnit/JUnit**
    * Standard XML schema for reporting pass/fail unit test results
* **Checkstyle**
    * Standard XML schema for reporting static analysis results
* **SARIF (Static Analysis Results Interchange Format)**
    * JSON based schema primarily used for displaying results in GitHub
* **CycloneDX**
    * OWASP schema for software bill of materials and vulnerability exploitability exchange (VEX)
* **SPDX (Software Package Data Exchange)**
    * Open standard for communicating software bill of material provenance, license, and security details
* **JSON**
    * Custom schemas are machine readable, but you have work to do!



#### Automated Code Scanning Technology Landscape

Tool support varies widely, depending on your technology stack:

* **Application source code**: open-source tools are available for common languages and frameworks: JavaScript, Java, Python, C#, C/C++, PHP, Ruby on Rails, Android, Objective C, and Go.

* **Software supply chain**: open-source tools are available for application frameworks (npm, Maven, Nuget, PyPI) and scanning container images (more on this later)

* **Configuration management code**: open-source tools are available for Chef, Puppet, Ansible, but are generally limited to lint checks for good coding/correctness. Custom rules and extensions will be required for security coverage.

* **Infrastructure as Code**: open-source tools are available for Terraform, Docker, Kubernetes, CloudFormation, Bicep, and Helm.

* **Limitations**: New languages, frameworks, and technologies have poor (or no) coverage until open-source projects and vendors build in support.

**Static Analysis Resources**
* [Grype](https://github.com/anchore/grype)
* [Sytf](https://github.com/anchore/syft)
* [Supply Chain Levels for Software Artifacts (SLSA)](https://slsa.dev/)
* [Trivy](https://github.com/aquasecurity/trivy)


#### Semgrep - Secure Code Analysis

Semgrep provides a light-weight, multi-language, extensible static analysis solution. Fast, open-source, static analysis tool that searches code, finds bugs, and enforces secure guardrails and coding standards. Semgrep supports 30+ languages and can run in an IDE, as a pre-commit check, and as part of CI/CD workflows.

* Open-source solution built and maintained by returntocorp (r2c)
* Community driven rules Semgrep Registry contains over 1,000 rules
* Language support includes Go, Java, JavaScript, Python, Ruby, TypeScript, C#, and generic markup (JSON, YAML)
* Cloud offering also supports Secrets and Supply chain scanning
* Supports automation from the CLI, Docker image, and GitHub Actions

**References:**
* [Semgrep GitHub](https://github.com/semgrep/semgrep)
* [Semgrep Website](https://semgrep.dev/explore)



#### Semgrep - Scan Command Line Interface

Semgrep is a command-line driven tool:

* Scan command performs code scanning
* Rulesets include r2c-security-audit, r2c-ci, java, jwt, bandit, eslint-security-plugin-security, findsecbugs

| Option | Usage |
|---|---|
| `-f \| -c <config>` | YAML configuration file, directory of the YAML files, URL of a configuration file |
| `-e <pattern>` | Custom code search pattern |
| `-l <language>` | Parse pattern and all files in a specific language |
| `-o <output>` | Save search results to a file or POST to a URL, default is stdout |



# (2) Cloud Infrastructure Security


# (3) Cloud-Native Security Operations


# (4) Microservice and Serverless Security


# (5) Continuous Compliance and Protection
