# Wire Mythos Overview
[Wired Mythos Overview](https://www.wired.com/story/anthropics-mythos-will-force-a-cybersecurity-reckoning-just-not-the-one-you-think/)

* Many companies are not capable of securing their infrastructure—that hasn’t really changed from yesterday to today,” says longtime security engineer and researcher Niels Provos. “But from what I understand, Mythos is really good at coming up with multistage vulnerabilities, and then also provides the proof of exploitation. **I don’t think it intrinsically changes the problem space, but it changes the required skill level to find these vulnerabilities and exploit them.**”
* “In the long run, you want to make sure that your defenses are machine-scale, because the attacks are machine-scale,” Patel said. “If I have billions of agents that are going to be attacking my infrastructure, I need to make sure that I can defend it effectively. What Anthropic did here is a fantastic thing, because it just creates a level of asymmetry against the bad actors.”
* “If you get a million vulnerability researchers, they can find a huge number of bugs. But humans are not very good at holding lots of contextual information in their minds for long periods of time, so finding very long chains of vulnerabilities that are actually exploitable together has been rare," she says.

# MOAK 
[Mother of All KEVs](https://moak.ai/#how-it-works)
* This is a first-of-its-kind automatic predictor of whether a CVE will be exploited in the wild within hours.
* MOAK is a defensive security research system, not an attack tool. It operates exclusively in controlled, isolated environments to help defenders understand and assess the real-world exploitability of vulnerabilities.

(#Prioritization, #Security, #SLAs, #RiskManagement)

* In light of recent events Anthropic has released a cutting edge model and restricted access to roughly 40 to 50 organizations, including major technology companies and critical-infrastructure groups, to help identify and remediate vulnerabilities. While this capability is rumored tested to be truly impactful to the world of computer security. MOAK's core claim is that “AI attackers aren’t coming, they are here,” and the project is positioned as proof that known exploited vulnerabilities (KEV) can be turned into working exploits automatically at very high rates using the current generative models that are pubically available. It doesn't take the emergence of a state of the art (SOTA) model like Mythos from Anthropic to be provided. 
* This now introduces the question of how Blue Teams and Red Teams should approach the pace of KEVs being readily exploited and, from a risk point of view, how small to medium-sized organizations look into reshaping SLAs and prioritization of published vulnerabilities as they arise and are published.
* Blue teams should treat KEV exposure and weak security posture as a time-compressed problem, not a routine backlog problem, because MOAK’s creators explicitly warn of “spray and pray” exploitation within about an hour of disclosure and AISI says Mythos can autonomously attack small, weakly defended vulnerable enterprise systems. Patch SLAs, compensating controls, and exposure management need to be tied to exploitability and external reachability rather than generic severity labels alone.

---

* Additional Blue Team challenges to consider is the collapsing the triage time for internet-facing KEVs and 1-days to aim for same-day decisioning on patch, isolate, virtual patch, or block. This also gets into a discussion about the speed at which Security Incidents and Actions are decided for public facing applications. If an AI system can turn public technical detail into an exploit path quickly, the question is no longer “Is this vuln present?” but “Can this vuln reach impact in this environment before we contain it?”

* From the Red Team point of view the Red Team should assume that AI will automate the lower half of the kill chain (e.g., Reconnaissance, Resource Development, Initial Access), so their value shifts away from proving that a missing patch exists and toward emulating adaptive, chained, objective-driven operations. Basically, there will be more focus on attack chains or systematic staging of attacks rather than isolated and one-off exploits

* From a #Prioritization POV both red and blue teams is a shift from capability-centric thinking to tempo-centric thinking. Similar to how the emergence of generative AI has speed up the code output of the individual developer. The same pace and tempo is true in the discovery and exploitation of vulnerabilities.

---

(#DeployingApplications, #Security, #SLA, #Prioritization, #TechnicalResearch)
* I try to level-set the discussion by tying these stories directly to SWF operations from what I've seen on how applications are deployed and the speed at which they are deployed. From what I understand, I believe that there should be a shift towards speed of shipping, internet exposure, and contractual uptime commitments as part of exploit priority, not as separate business concerns. What this basically means is that the organization should develop a more flexible risk mental model by considering if this feature is reachable from the internet, customer-facing, and hard to patch without downtime, how fast could it hurt my organization?
* A better prioritization mental model when securing, developing, and deploying applications could be ordered as follows (1 - highest priority to 5 - lowest priority)

1. Internet-facing authentication, session, and identity flows, because compromise there usually scales across tenants and users quickly. 
2. File upload, webhook, search, prompt-processing, admin, and integration endpoints, because AI-generated code often mishandles input validation, SSRF, injection, and auth boundaries. 
3. Dependencies and frameworks used by newly shipped features, especially where AI suggested packages, copied old examples, or reintroduced outdated patterns. 
4. Anything tied to SLA penalties, uptime guarantees, or customer contractual commitments, because remediation may be slower and impact larger. 
5. Internal-only tools with strong segmentation, because they usually have more containment options than public product surfaces.

---

(#DeployingApplications, #Security, #TechnicalResearch, #Prioritization)
* Since AI models tend to repeat the same mistakes, an attacker would need to find these bugs just once. “Millions of developers using the same models means the same bugs showing up across different projects,” he said. “Find one pattern in one AI codebase, you can scan for it across thousands of repositories.” (https://research.gatech.edu/bad-vibes-ai-generated-code-vulnerable-researchers-warn)
* The control point is not “ban AI coding”; it is forcing security gates around code that was produced faster than humans can fully reason about on first pass.
* When considering the growing emergence and incentive to ship products as fast as possible it runs into a problem that I’ve been thinking about with AI generated code. There is a huge push and also incentive for developers to deliver products and features quickly utilizing this generated code. As a result, some companies have projected that 80 to 90% of their code base will be AI generated.
* I think the practical answer is not to resist AI coding, but to redesign engineering so that AI can generate code freely inside hard security boundaries, mandatory validation, and risk-based release gates.
* A good mental model that I think about is as follows:
  * Let AI maximize coding speed
  * Let policy constrain what “acceptable” code looks like.
  * Let automation reject unsafe output before it reaches production.

---

* In theme with my current discussion on AI-generated code and #Security. From a #RiskManagement and Security POV - the broader lesson is that AI-generated code should be treated like industrialized software output or a manufacturing plant you do not secure it by inspecting every unit manually, but by building a secure factory around it (e.g., CI/CD pipelines, Static/Dynamic Application Security Testing (SAST/DAST), Software Composition Analysis (SCA)). Obviously, testing EVERYTHING is ideal, but when speed and feature delievery is of the essensce a rule of thumb like:

1. SAST and secrets scanning for source-level issues. 
2. SCA for vulnerable or hallucinated dependencies. 
3. DAST and adversarial API testing for runtime behavior. 
4. Human review for auth, crypto, tenancy, and sensitive data logic.

* If a component is high-risk, then testing each component via #UnitTests, integration tests, and end-to-end tests with meaningful coverage of expected and unexpected behavior. From a #RiskManagement and #Prioritization POV I suspect that testing in layers would be ideal, for example: "verify every high-risk path exhaustively and automatically, then add human review where design mistakes are expensive."

---

* To finish up with the series of journals, I wanted to touch on risk #Metrics that I think I as a developer should be considering when building and deploying given where the SWE industry seems to be moving. If AI will write most of the code, from a #Security standpoint, I believe I should start asking whether AI-generated changes are introducing more exposure, more risky dependencies, or more security exceptions. Some of the key metrics should be release-risk metrics, rather than authorship metrics (e.g., AI generated vs human-generated) (https://cloudsecurityalliance.org/blog/2025/07/09/understanding-security-risks-in-ai-generated-code) 

* Some useful #Metrics that I saw online for risk-based metrics are as follows:

1. Percent of AI-assisted changes that touch exposed or sensitive paths. 
2. Time to detect vulnerable dependencies added by AI-generated changes. 
3. Rate of blocked merges due to CI/CD pipeline failures. 
4. Mean-time to remediate (MTTR) security findings in AI-assisted features. 
5. Number of production incidents tied to missing validation, auth flaws, or unsafe dependency choices.

---

# Red Team Anthropic
[Red Team Anthropic](https://red.anthropic.com/2026/mythos-preview/)
* The best way to be ready for the future is to make the best use of the present, even when the results aren't perfect.
* Gaining practice with using language models for bugfinding is worthwhile, whether it’s with Opus 4.6 or another frontier model. We believe that language models will be an important defensive tool, and that Mythos Preview shows the value of understanding how to use them effectively for cyber defense is only going to increase—markedly.
* Think beyond vulnerability finding. Frontier models can also accelerate defensive work in many other ways. For example, they can:
* Provide a first-round triage to evaluate the correctness and severity of bug reports; 
  * De-duplicate bug reports and otherwise help with the triage processes; 
  * Assist in writing reproduction steps for vulnerability reports;
  * Write initial patch proposals for bug reports;
  * Analyze cloud environments for misconfigurations;
  * Aid engineers in reviewing pull requests for security bugs;
  * Accelerate migrations from legacy systems to more secure ones;
* **To summarize:** it is worth experimenting with language models for all security tasks you are doing manually today. As models get better, the volume of security work is going to drastically increase, so everything that requires manual triage is likely to benefit from scaled model usage.
* Automate your technical incident response pipeline. As vulnerability discovery accelerates, detection and response teams should expect a matching rise in incidents: more disclosures mean more attacker attempts against the window between disclosure and patch. Most incident response programs cannot staff their way through that volume. Models should be carrying much of the technical work: triaging alerts, summarizing events, prioritizing what a human needs to look at, and running proactive hunts in parallel with active investigations. During an incident itself, models can help take notes, capture artifacts, pursue investigation tracks, and draft the preliminary postmortem and root-cause analysis as the basis for further validation.

# Linus's Law
[Linus's Law](https://en.wikipedia.org/wiki/Linus%27s_law)
* Given enough eyeballs all bugs are shallow...
* Given a large enough beta-tester and co-developer base, almost every problem will be characterized quickly and the fix obvious to someone." Presenting the code to multiple developers with the purpose of reaching consensus about its acceptance is a simple form of software reviewing. Researchers and practitioners have repeatedly shown the effectiveness of reviewing processes in finding bugs and security issues.


# Anthropic Bug Finding
[Anthropic Bug Finding](https://www.anthropic.com/news/mozilla-firefox-security)
* We ran this test several hundred times with different starting points, spending approximately $4,000 in API credits. Despite this, Opus 4.6 was only able to actually turn the vulnerability into an exploit in two cases. This tells us two things. 
* One, **Claude is much better at finding these bugs than it is at exploiting them. Two, the cost of identifying vulnerabilities is an order of magnitude cheaper than creating an exploit for them**. However, the fact that Claude could succeed at automatically developing a crude browser exploit, even if only in a few cases, is concerning.
* First, when researching “patching agents,” which use LLMs to develop and validate bug fixes, we have developed a few methods we hope will help maintainers use LLMs like Claude to triage and address security reports faster.
* Claude works best when it's able to check its own work with another tool. We refer to this class of tool as a “task verifier”: a trusted method of confirming whether an AI agent’s output actually achieves its goal. Task verifiers give the agent real-time feedback as it explores a codebase, allowing it to iterate deeply until it succeeds.

# Hunted Lab Dependency Vulnerability Scanning
[Hunted Lab Dependency Vulnerability Scanning](https://huntedlabs.com/research/popping-fast-globs-hood)
(#Security, #DeployingApplications, #RiskManagment)
* There's a popular package called **Fast-glob** that's a widely used Node.js utility designed to quickly find files and folders that match specific patterns, is maintained by a single developer working for Yandex, a Russian tech company that cooperates with requests from the Federal Security Service (FSB), Russia’s security and counterintelligence agency.
* This package is at significant risk of falling under foreign ownership, control, and influence. We recommend its immediate removal from products, particularly those purchased or used by the U.S. Department of Defense or the Intelligence Community.
* A solo maintainer based in an authoritarian country—characterized by a strong security service and limited human rights protections—poses a potential risk to the security and integrity of the package, especially one with the access and popularity of fast-glob. 
* Put simply, fast-glob offers both the solo maintainer and the Kremlin an opportunity to carry out a state-sponsored attack, especially given the open-source community’s tendency to blindly adopt projects with little to no information about the contributors behind them. We cannot overstate the risks. 
* While `mnmInc` has no current ties to any threat actors, the profile could be compromised with near-zero effort. Once that happens, `mnmInc` could push or be influenced to make updates to more than 5,000 projects without oversight from any other GitHub user. This would allow Russia attack vectors immediate access to thousands of known projects—not to mention an unknown number of undisclosed and private projects, including the entire Node.js community. A compromise of that magnitude could infiltrate and disrupt critical infrastructure across government, commercial, healthcare, and financial systems, not to mention the countless other vital industries that citizens around the world rely on every day.

[Data Transfer Objects (DTOs)](https://medium.com/@vishamberlal/understanding-data-transfer-objects-dto-in-spring-boot-ac06b575a1d5)
(#Architecture, #DesignPatternBasics, #RelationalDatabaseBasics)

[Simplifying Unit Testing with Mockito](https://medium.com/@kaustubh.saha/simplifying-java-unit-testing-with-mockito-f4fa6e1ca2fb)

(#UnitTesting, #SpringBasics, #TestDrivenDevelopment)

[Code Review Commentary](https://docs.google.com/document/d/1FKr3MThNbb08SaQuBRftiDcz62ZHEqUwagsAsVOiMtY/edit?tab=t.0)
(#Pairing, #Metrics, #Prioritization, #BalancedTeam)


# DORA Development Metrics
[DORA Development Metrics](https://dora.dev/guides/dora-metrics/)
(#Metrics, #Prioritization, #DeployingSoftware)

* DORA has identified five software delivery performance metrics that provide an effective way of measuring the outcomes of the software delivery process.
* These software delivery performance metrics can be viewed as both leading and lagging indicators. Leading indicators typically signal potential future changes in a system while lagging indicators reflect past performance and outcomes.
* DORA metrics function as to identify:
  * Leading indicators for organizational performance and employee well-being 
  * Lagging indicators for software development and delivery practices.

* The set of DORA metrics are grouped into **`Throughput`** and **`Instability`**
* Basically, **throughput** and **instability** are used to give teams a high-level understanding of their software delivery performance.

**Throughput:**
Throughput is a measure of how many changes can move through the system over a period of time. Higher throughput means that the system can move more changes through to the production environment. DORA uses three factors to measure software delivery throughput:
1) Change lead time: The amount of time it takes for a change to go from committed to version control to deployed in production. 
2) Deployment frequency: The number of deployments over a given period or the time between deployments. 
3) Failed deployment recovery time: The time it takes to recover from a deployment that fails and requires immediate intervention.

**Instability:**
Instability is a measure of how well the software deployments go. When deployments go well, teams can confidently push more changes into production and users are less likely to experience issues with the application immediately following a deployment. DORA uses two factors to measure software delivery instability:
4) Change fail rate: The ratio of deployments that require immediate intervention following a deployment. Likely resulting in a rollback of the changes or a “hotfix” to quickly remediate any issues.
5) Deployment rework rate: The ratio of deployments that are unplanned but happen as a result of an incident in production.

> [!NOTE]
> Speed and stability are not tradeoffs. In fact, we see that the metrics are correlated for most teams. Top performers do well across all five metrics, and low performers do poorly.
> These metrics work for any type of technology your organization is delivering, but are best suited for measuring one application or service at a time. Whether you are building large language models, retail banking applications, mobile food ordering applications, or mainframe-based travel systems, these five metrics can help you assess the delivery performance of your application. 
> Context matters. Apply the metrics in the context of the application or service your team is delivering. The context for your application, organization, and users will vary from other applications that your organization is delivering. While it may be tempting to blend metrics across multiple teams or entire organizations these differences in context mean that doing so can be problematic.

**Common Pitfalls**

* The full list of common pitfalls can be found [here](https://dora.dev/guides/dora-metrics/#common-pitfalls). I've included the set of pitfalls that resonated with me the most...

**Setting metrics as a goal** - this basically means that a team should ignore broad statements that box in an application (e.g., "every application must deploy multiple times per day by year's end"). The result of this are teams attempting to simply game the metrics that they are being assessed on. [Goodhart's law](https://en.wikipedia.org/wiki/Goodhart%27s_law) summarizes this nicely by stating, "When a measure becomes a target, it ceases to be a good measure". Additionally, in the words of Charles Munger - "Show me the incentive, and I'll show you the outcome..."

**Having one metric to rule them all** - this means that teams should avoid attempting to measure complex systems with the idea that only one metric matters. Teams should identify multiple metrics, including some with a healthy amount of tension between them [measurment framework](https://dora.dev/insights/measurement-frameworks/). Essentially we should seek to have a diversity of metrics to assess the efficiency of an application.

**Using industry as a shield against improving**. For example, some teams in highly regulated industries might claim that compliance requirements prevent them from disrupting the status quo (e.g., the ASWF operating within a larger bureaucratic organization where process and procedure are sacrosanct.)

**Competing**. The goal is to [improve your team’s performance over time](https://dora.dev/guides/how-to-empower-software-delivery-teams/), not to compete against other teams or organizations. Use the metrics as a guide for identifying areas for growth and celebrating progress. Often times, teams may forget what they are... a TEAM. The goal is to improve the entire organization and the products that it creates!

**Focusing on measurement at the expense of improvement.** To me this means that a manager or technical lead may overfit or overemphasize the goal of getting the most real-time and purest measurement metrics rather than opting for a simpler discussion with less technical overhead (e.g., building integrations to multiple systems to get precise data about your software delivery performance rather than simply having a discussion about the metrics using something like [DORA Quick Check](https://dora.dev/quickcheck) or other [available products](https://dora.dev/resources/#source-available-tools)).

# The Bitter Lesson

* [Bitter Lesson](https://www.cs.utexas.edu/~eunsol/courses/data/bitter_lesson.pdf)

# Extreme Programming 

* I'm currently reading Extreme Programming (XP) and I've run across the idea of the "basics of software development" which are **coding**, **testing**, **listening**, and **designing**. Coding, testing, and designing seem immediately apparent. After some thinking I found that #Feedback and #Facilitation fit quite nicely into this XP idea. Before encountering the idea, I interpreted feedback specifically as **ONLY** the response that a mentor or potential pair would give you on how you were performing while building an application. But I've discovered that it also represents the response and commentary from the end user and stakeholder about applications/features that you are building as well. In XP, #Feedback directly informs what exact feature you build, iterate, or discard next. The book also explains that #Feedback is also a part of the **listening** basics where, as a developer you pay very close attention to what your core customer/audience demand from you.
* I've noticed that I, as a developer, should also find way to use #Facilitation to create a productive and open discussion with my end-user and the rest of the #BalancedTeam to actually address and accomplish the goal/target of value. 
* I used to believe that the engineers' sole job was only focusing on building the highest quality thing. But I've learned that it's a much more collaborative process to ensure that you don't waste time building what the customer doesn't want. 
* For example, if the user story for a local quiz tool states that the user wants a feature to modify the settings of their current quiz session so that, when using a quiz tool, they can adjust configurations of the quiz in real time. The developer, PM, designer, and PE need to accommodate that concern and make a focused and concerted effort to bring that setting feature to life (assuming that this feature would add significant value for that customer).
* The developer can then receive #Feedback both in the initial feature addition that they create and while discussing with the customer and rest of the #BalancedTeam on feasibility of what they want to ship to ensure that the customer vision aligns with what will be built.