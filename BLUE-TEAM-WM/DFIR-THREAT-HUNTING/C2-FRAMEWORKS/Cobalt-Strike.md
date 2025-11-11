# Cobalt Strike IoCs

1. https://www.youtube.com/watch?v=borfuQGrB8g

> **NOTE:** Cobalt Strike's strength is found within it's flexibility, durability, and elasticity. Essentially, it's able to string together many exploits in a robust and customizable C2 framework better than most other frameworks out there...

## Process Tree Detection

> From memory extraction...

<img src="./files/Process_Tree_Detection.png">

### IoC
* Prescence of `WmiPrvSE.exe` spawning multiple `powershell.exe` processes/sacrifical processes.
* Multiple `rundll32.exe` processes generated (default **sacrifical process** for Cobalt Strike; can be changed but still noisy!) 


## Cobalt Strike PowerShell and WMI Processes

> Here we are drilling down on the `rundll32.exe` process of interest...

<img src="./files/PowerShell_and_WMI_Processes.png">

### IoC
* Naked command line with **no additional parameters specified** (default setting).
  * That being said, the setting can be changed via the malleable C2 Setting
  * **HOWEVER** even with a change in the default settings, having multiple command lines with no parameters specified looks **very odd**!

## SysWOW64 Activity

> Here we are looking for the execution of 32-bit code (SysWOW64) associated with with the multiple sacrifical processes of `powershell.exe`

<img src="./files/SysWOW64_Activity.png">

### IoC
* Multiple instances of running **`SysWOW64`**, which indicates the prescence of 32-bit code linked with Cobalt Strike! 

## Named Pipe Detection (from Memory)

> Most common and **default** named pipes used by Cobalt Strike

| Pipe Name | Description |
| --- | --- |
| `\\.\pipe\MSSE-####-server` | Default Artifact Kit (AV bypass) |
| `\\<target>\pipe\msagent_##` | Beacon P2L (SMB) Communication |
| `\\.\pipe\status_##` | Stager for Lateral Movement (psexec\_psh Module) |
| `\\.\pipe\postex_ssh_####` | Communication Pipe for SSH Sessions |
| `\\.\pipe\########` (7-10 char) | Post-Exploitation Jobs (mimikatz, powerpick, pth, etc.) |
| `\\.\pipe\postex_####` | Post-Exploitation Jobs v4.2+ |

> '#' = randomly generated hex-value

<img src="./files/Named_Pipes_Memory.png">

> Here is an example of changing the output of Named Pipe names so that it is more difficult to detect, **HOWEVER**, even with an alternate named pipe name seeing an internal workstation connecting to another internal workstation via named pipe is still odd...

### IoC
* Each of the named pipes **must** all be changed from defaults, otherwise they can be identified. Attackers often don't modify the defaults because they are still able to go undetected!

## Named Pipe Detection (with Sysmon)

<img src="./files/Named_Pipe_Sysmon.png">

### IoC
* Enable **Named Pipe** creation events within Sysmon
* Look for Events **17** and **18** indicating named creation
* Pay attention to **PipeName** for names associated with Cobalt Strike
* Pay attention to **Image** to look for **SysWOW64** (unique to Cobalt Strike for 32-bit code!)

## Idenfication of Named Pipes at Scale (with Sysmon)



**References**
1. https://www.crowdstrike.com/en-us/blog/getting-the-bacon-from-cobalt-strike-beacon/