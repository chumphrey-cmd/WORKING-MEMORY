## Security Engineering & DevSecOps Best Practices

### 2. Software Supply Chain & Dependency Management

Yesterday we discussed specific vulnerability remediation efforts that caught my attention in light of recent events. This lead me to the idea of security in the software supply chain for proactive dependency management.
From what I understand, the first line of defense for the SWF is the automated CI/CD scanner/custom bot hooked directly into our GitLab API. This tool acts as a gatekeeper, continuously reviewing dependency trees and automatically blocking Merge Requests if critical vulnerabilities are detected.
When a vulnerability is inevitably flagged, a designated developer can run commands like yarn why or npm explain to pinpoint exactly which top-level package is pulling in the compromised transitive (nested) dependency.
You can also use features like the resolutions field in your package.json to explicitly "pin" a secure version of that sub-dependency, forcing it to apply across your entire project. However, forcing a version update introduces its own risks, as security patches are not always backward compatible.
Therefore, every time a dependency is bumped or pinned, you must execute a strict vulnerability remediation loop, from what I understand the loop is as follows:
1. recompile the build, 2. run your automated test suite, 3. verify the system compatibility to ensure that plugging a security hole doesn't inadvertently break your application's core functionality.

### 4. Security Posture Strategy
* **The Reactive Reality:** Acknowledge that the current standard—scanning for CVEs and patching known vulnerable packages—is inherently **reactive**. You are fixing vulnerabilities that researchers or attackers have already discovered.
* **Shifting Left (Proactive):** To move from reactive to proactive, engineering teams must implement zero-trust architectures, enforce least-privilege permissions, and integrate Static Application Security Testing (SAST) into the IDE/CI pipeline to catch flaws in custom code *before* deployment.