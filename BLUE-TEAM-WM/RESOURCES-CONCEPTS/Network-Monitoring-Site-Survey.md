# Purpose 

The purpose of this document is to collect information that allows analysts to discover Critical Infrastructure and Key Terrain supporting Customer operations, and identify  vulnerabilities in those systems that may inhibit their ability to meet requirements. In order to provide the most timely  and comprehensive support, this document needs to be completed within five business days. If any areas that require additional time to answer, please highlight those areas and provide an estimate for completion.

## Logistics

1. **Primary Contact:** Who is our main contact for deployment logistics & technical coordination? (Name, Title, Email, Phone)

2. **Work Hours:** What are standard site work hours & key staff availability times?

3. **Site Access:**  
   1. What's the process/info needed for site access clearance? Contact info?  
   2. How does our team get badges/credentials upon arrival?  
   3. Any other special access rules (checks, briefings, NDAs, letters)?

4. **Classified Access (if applicable):** If needed, what's the process for classified network access (e.g., NIPR, SIPR, JWICS/NSAnet, SAAR forms)?

5. **Locations:** Where will our team work & install equipment? (Building/room numbers for workspace, data centers, comms closets)

6. **Workspace:** Is workspace available for **[XX-number]** people (desks, chairs, power)?

7. **Power:**  
   1. What outlet types/voltages are in workspace & server rooms (120v/240v)?  
   2. Can we use site UPS? Connection type & capacity?

8. **Secure Storage:** Is secure storage available for team equipment (laptops, tools)?

9. **Transport Rules:** Any rules/procedures for moving equipment/data in/out of the facility?

10. **Internet:** Will the team have commercial internet access from their workspace?

11. **Safety:** Any specific site safety rules, hazards, or procedures for our team?

12. **Privileged Access:** Our team may need temporary privileged system access (e.g., admin rights for installs) or specific read-access (logs, traffic). What are your policies/procedures for granting this to external teams?

13. **System Changes:** We may need to run diagnostics or enable services (with your coordination/approval). What are your relevant change control policies or sensitivities?  
      
14. **Special Considerations:** Are there any special considerations in regards to transporting hardware, software, or data into and out of the facility? If yes, please elaborate.

## Key Personnel Contacts (CUI)

| Role / Function | Name | Phone | Work Email Address |
| :---- | :---- | :---- | :---- |
| Site / Organizational Lead (e.g., CO, Dept. Head) |  |  |  |
| Primary Technical Contact (e.g., Local Network Defender Lead) |  |  |  |
| Security Compliance / Info Assurance Lead (e.g., IAM) |  |  |  |
| Change Approval Authority (e.g., DAA) |  |  |  |
| Program / System Manager (If applicable) |  |  |  |
| Server / System Administration Lead |  |  |  |
| Network / Firewall Administration Lead |  |  |  |
| External Security Provider Contact (e.g., CSSP) |  |  |  |
| Other Key Contact (Specify Role): |  |  |  |
| Other Key Contact (Specify Role): |  |  |  |

**Role Descriptions & Acronyms:**

1. **Site / Organizational Lead – CO (Commanding Officer):** Senior leader responsible for the site/organization; may provide high-level awareness or final approval.

2. **Primary Technical Contact – Local Network Defender Lead:** Main point person for day-to-day technical questions, coordination, and facilitating access during deployment.

3. **Security Compliance / Info Assurance Lead – IAM (Information Assurance Manager):** Oversees cybersecurity program, policies, and compliance; key contact for ensuring deployment meets security requirements and for related approvals.

4. **Change Approval Authority – DAA (Designated Approving Authority):** Individual or body responsible for reviewing and approving technical changes to the network or systems needed for deployment (e.g., firewall rules, configurations).

5. **Program / System Manager:** Manages a specific IT program or system that may be the focus of monitoring; provides system-specific context.

6. **Server / System Administration Lead:** Manages server infrastructure; contact for server access, potential agent installations, log configurations, and OS-level troubleshooting.

7. **Network / Firewall Administration Lead:** Manages network infrastructure (routers, switches) and firewalls; contact for network diagrams, traffic access (e.g., SPAN/TAP setup), and firewall rule implementation.

8. **External Security Provider Contact – CSSP (Cybersecurity Service Provider):** Primary contact at a third-party organization providing cybersecurity services.

## Technical Requests 

### A. Network Architecture & Topology

1. **Network Maps:** Please provide current logical and physical network maps for the segments to be monitored.

2. **Network Map Currency:** How current are the provided network maps? Are there recent significant changes not yet reflected?  
   1. **Sensors:** Could you please annotate the provided network maps to show the locations of existing network security sensors (e.g., IDS/IPS sensors, network TAPs used for security monitoring)?  
   2. **Public Assets:** Could you also annotate the network maps to clearly identify public-facing systems or network segments?

3. **Monitoring Scope Exclusions:** Please identify any specific devices, IP ranges, or network segments that are explicitly out-of-scope for monitoring or interaction by our team.

4. **Existing Traffic Collection:** Are network TAPs (physical) or SPAN/mirror ports currently configured for traffic collection? If yes, please describe their location, type (inline/passive), and current data feeds.

5. **Mission Relevant Terrain - Cyber (MRT-C):** What systems, applications, or data do you consider Mission Relevant Terrain - Cyber (MRT-C) – assets essential for your primary operational mission?

6. **Key Terrain - Cyber (KT-C):** What systems, applications, data, or access points do you consider Key Terrain - Cyber (KT-C) – assets whose compromise would grant a significant advantage to an adversary or cause severe mission impact?

### B. System Inventory & Configuration Baseline

7. **System Inventory by Segment:** Please provide an inventory of systems within each network enclave/segment, including server roles/functions.

8. **Server Inventory:** Please provide an inventory or summary of server operating systems (including versions/patch levels) and hardware models within scope.

9. **Baseline Configurations:** Could you provide documentation for standard baseline configurations or host images used for servers and workstations?  
   1. **Configuration Baseline Frequency:** How frequently are formal configuration baselines captured or updated for key network devices and servers?

10. **Configuration Standard Deviations:** Are there known systems that deviate significantly from standard security configurations (e.g., STIGs)? If so, please provide context or documentation (e.g., waiver details).

11. **Programs of Record (PORs):** Please list any formal Programs of Record (PORs) systems residing on the network segments in scope. (If POR is not a standard term for you, please clarify).

12. **Public/Web Applications:** Do you host public-facing websites or critical web applications? If yes, please list the primary ones.

13. **SCADA/ICS Systems:** Are there any Supervisory Control and Data Acquisition (SCADA) or Industrial Control Systems (ICS) present on the network segments in scope?

14. **Remote Access Methods:** Please describe all authorized methods for remote access into the network (e.g., VPN types/gateways, VDI platforms, SSH jump-boxes, vendor access methods).

15. **Wireless Usage:** Please describe any wireless communications used within the monitored network segments (e.g., Wi-Fi SSIDs/security type, Bluetooth usage, wireless point-to-point bridges, radio links), including the systems using them and their purpose.

16. **VPN Client/Server Systems:** Do any internal systems act as VPN clients initiating outbound connections, or as VPN servers terminating inbound connections? Please list relevant systems and their purpose.

17. **Significant Scheduled Tasks:** Please describe any significant or non-standard scheduled tasks running commonly on servers or critical workstations (beyond typical OS functions).

18. **GPO Export:** Could you provide an export (e.g., CSV or report) of Group Policy Objects (GPOs) applied within the monitored domain(s)?

19. **GPO Log Access:** Where are GPO processing logs typically stored, and what is the process for accessing them if needed for troubleshooting?

20. **Registry Exports (Critical Systems):** Is it possible to obtain registry exports from specific critical servers (e.g., identified Key Terrain hosts) if needed for detailed configuration analysis?

21. **Other Critical/Unique Systems:** Please list any other unique or critical network services or appliances not covered elsewhere (e.g., mainframe interfaces, specialized databases, legacy systems) using the table below.

| Hostname | Service/Function | IP Address | Operating System | Notes (e.g., Criticality, Monitoring Constraints) |
| :---- | :---- | :---- | :---- | :---- |
|  |  |  |  |  |
|  |  |  |  |  |

### C. Security Controls & Posture

22. **Security Team & Tools Overview:** Please provide an overview of your internal security team structure and the primary security tools currently deployed (e.g., SIEM vendor, EDR solution, firewall vendors).

23. **Vulnerability Scan Results:** Please provide the most recent vulnerability scan results (e.g., from ACAS, Nessus, or similar tools).

24. **Scan Context (Source Specific):** Regarding scans referenced in [Specify source, e.g., TASKORD/engagement letter], which specific IP addresses were targeted or responded to? Is captured network traffic (PCAP) from that scanning activity available for review?

25. **Internal Vulnerability Scanners:** Please list any vulnerability scanners operating within the network and their source IP addresses.

26. **Endpoint Management Tools:** Please list centralized endpoint management tools (e.g., Elastic, Tanium, Splunk, etc.) and provide an overview of their scope (managed systems) and key security policies deployed via these tools.

27. **Host-Based Security Agents:** Are host-based vulnerability scanners or other security agents (beyond standard AV/EDR) deployed widely? If yes, please list the tools.

28. **Intrusion Detection/Prevention Systems (IDS/IPS):** Please list all IDS/IPS in use (network-based and host-based), including vendor/model and an overview of deployed rulesets or detection policies.

29. **Device Configurations:** To understand traffic flow and rulesets, could you provide current configuration files for key network devices (firewalls, routers, core switches), or describe the process for reviewing them?

30. **Allowed Network Services:** Please provide a list of authorized network ports, protocols, and services, noting any common services running on non-standard ports within the monitored segments.

31. **Block/Allow Lists:** Please provide lists of centrally managed blocked or allowed Domains/IPs/URLs (e.g., via proxy, firewall, DNS sinkhole).

32. **Log Collection & Access:** Please describe how system and security event logs are collected (e.g., local storage, central logging server, SIEM). What methods or tools are used for log access and analysis? What are the typical log retention periods?

### D. Policies & Procedures

33. **Key Network Policies:** Please provide key network policy documents, such as the Acceptable Use Policy (AUP) and Network Access Control (NAC) guidelines/policy.

34. **Security Policies:** Please provide copies of current policies regarding password complexity/rotation, account lockout, and USB device usage.

35. **Authorized Software:** Please provide the authorized software list or software baseline documentation for workstations and servers.

36. **Account Privilege Structure:** To understand privilege structure, please describe the roles and typical privileges assigned to user and administrator accounts. Is Role-Based Access Control (RBAC) implemented? Are administrator accounts typically shared?

37. **Change Management Process:** Please provide documentation outlining your Change Management process, particularly for network and system modifications.

38. **Patching & Scanning Cadence:** Please describe your regular schedules or cadence for system patching/updates and vulnerability scanning.

39. **System Reboot Policy:** What are the typical reboot schedules or policies for workstations and servers?

40. **Backup Strategy & Status:** Please describe the backup strategy for critical systems (frequency, retention, verification) and provide the status of recent backup jobs.

### E. Access & Coordination Requirements

41. **Privileged Access Process:** What is the process for granting temporary privileged access (e.g., Domain Admin equivalent with RDP) needed for agent deployment on hosts?

42. **Endpoint Console Access:** What is the process for requesting supervised, read-only access to endpoint management consoles for configuration review or agent status verification?

43. **Team Communication Accounts:** If required for communication during the engagement, what is the process for requesting user accounts on relevant networks (e.g., NIPR, SIPR, JWICS) for our team?

44. **Traffic Collection Feasibility:** To obtain necessary network traffic visibility, what are the possibilities for configuring SPAN/mirror ports on switches or deploying network TAPs in key locations?

45. **Scheduled Interruptions:** Are any scheduled interruptions or major maintenance windows scheduled during our potential deployment period?

46. **Scheduled Maintenance Request Process:** Is there a process for requesting a maintenance window if required for monitoring deployment activities (e.g., sensor installation, network changes)?

47. **Daily Sync Timing:** During the on-site engagement period, what time(s) are generally most convenient for a brief daily synchronization meeting?

48. **Primary Daily Contact:** Could you confirm the best single point of contact for routine, day-to-day operational or technical questions that may arise during the engagement? (This might be the "Primary Technical Contact" identified earlier).

### F. Engagement Coordination and Expectations 

49. **Engagement Synergy:** What are the primary focus areas or current operational activities of your internal network/security defense team? Understanding this helps us identify how our team (MDTF) can best supplement your efforts and avoid duplication.

50. **Incident Reporting Procedure:** Please describe your internal procedures for reporting suspected Malicious Cyber Activity (MCA). Who are the primary points of contact for incident intake?

51. **Deliverables & Expectations:** What are your primary expectations regarding the deliverables, reports, or outcomes from this engagement?