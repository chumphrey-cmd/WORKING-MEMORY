# Method of Analysis: DFIR Playbook  

## Intrusion Metholodgy Roadmap

### Threat Hunting & Assessment

We will start our process by looking at the network using tools that can scale collection and analysis, focusing on occurrence stacking and outlier analysis. Most attendees have thousands of endpoints necessitating broad scoping techniques at the start of an investigation.

### Triage Collection & Analysis

As systems of interest are identified, we will perform targeted triage collection to acquire a deeper understanding of attacker activity. Triage data can include traditional forensic artifacts like application execution data, file system information, and in-memory artifacts such as process trees.

### Deep-Dive Forensics

Finally, we will reserve our limited analyst time for performing deep-dive forensics on only a handful of systems having the best chance to help us understand attacker tools and tradecraft and craft better indicators to assist with scoping additional compromised systems.

---

### **1. Network Analysis – Surveying Stone Deposits** 
 
- Begin by identifying compromised systems through network artifacts, such as unusual traffic patterns or unauthorized connections.  

- Think of this as locating the initial block of marble for your investigation. Network analysis provides a broad view of activity, helping pinpoint suspicious behavior worth deeper exploration.  

### **2. Isolating Systems and Capturing Volatile Data – Shaping the Block (1/3)** 
 
- Focus on volatile data (e.g., memory, live network activity) early to prevent critical evidence from being lost. 
 
- In cases involving a **Determined Human Adversary (DHA)**, consider delaying isolation to monitor their **Tactics, Techniques, and Procedures (TTPs)** and gain additional intelligence.  

### **3. Event Log Collection – Shaping the Block (2/3)**  

- Event logs provide a timeline of system activity and attacker movements. Focus on **Event IDs (EIDs)** and their surrounding context to identify patterns efficiently.  

### **4. Disk Artifact Analysis – Shaping the Block (3/3)**  

- Examine artifacts such as prefetch files, shim cache, and the App Compatibility Cache to uncover executed applications and attacker interactions with the system. 

### **5. Forensic Analysis – Chiseling the Details**  

- Conduct deeper forensic analysis to map out how the attacker gained access, what tools they used, and their movements through the environment.  

---

## Collection Order  

Prioritize the **most volatile** data first to capture evidence likely to be altered or lost:  

1. **Memory Collection**  
   - Tools: WinPMEM, F-Response  

2. **Log Collection**  
   - Includes network, event, host, and Windows Defender logs.  
   - Tools: Kansa, KAPE, Velociraptor  

3. **Disk Artifact Collection**  
   - Prefetch, shim cache, AppCompatibility cache, etc.  
   - Tools: Eric Zimmerman’s suite, Autopsy, FTK Imager
  
4. **File System Changes**  
   - Identify malware or persistence mechanisms.  
   - Tools: **UPDATE WITH PERSONAL NOTES** 

---

## Analysis Order  

Analysis is often performed in reverse of collection order, starting with low-effort artifacts to confirm suspicions before diving deeper:  

1. **Log Analysis**  
   - Focus on quick wins by analyzing event and network logs for patterns.  
   - Tools: EvtxECmd, Event Log Explorer, Timeline Explorer.  

2. **Disk Artifact Analysis**  
   - Examine artifacts for evidence of executed commands and attacker activities.  
   - Tools: AppCompatParser.py, Eric Zimmerman’s tools.  

3. **Memory Analysis**  
   - Perform detailed memory analysis to uncover persistence, tools used, and attacker behavior.  
   - Tools: Volatility, MemProcFS, MemoryBaseliner.py  

---

## Triage Timeline Creation

### 0. KAPE Artifact Extraction
- Place all collected artifacts into local directory (e.g., "G:\timeline")

### 1. Creating Bodyfile

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


### 2. Enrich Bodyfile with mactime and convert into .csv
   
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


### 3. Tune out unnecessary noise
```bash
grep -v -i -f timeline_noise.txt timeline.csv > timeline-final.csv
```  

---

## Super Timeline Creation - Partial Disk Analysis

### 1. List Timezones
```bash
log2timeline.py -z list
```



### 2. Timeline Windows artifacts
```bash
log2timeline.py --timezone 'EST5EDT' --parsers 'winevtx, winiis' --storage-file out.plaso [/cases/artifact_directory]
``` 

### 3. Add Master File Table
```bash
log2timeline.py --parsers 'mactime' --storage-file out.plaso [/cases/timeline_mftecmd.body]
```  

### 4. Convert Super Timeline to CSV and Filter
```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso "date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')"
``` 



```bash
grep -a -v -i -f timeline_noise.txt supertimeline.csv > supertimeline_final.csv
```  

---


## Super Timeline Creation - Full Disk Analysis

### 1. List Timezones
```bash
log2timeline.py -z list
```

### 2. Parse Full Triage Image
```bash
log2timeline.py --timezone 'EST5EDT' -f filter_windows.yaml --parsers 'win7,!filestat' --storage-file out.plaso [/cases/cdrive/YOUR_DISK.E01]
``` 

### 3. Add full MFT Metadata (Bodyfile for Timeline)
```bash
log2timeline.py --parsers 'mactime' --storage-file out.plaso [/cases/mftecmd.body]
```
Adding the mactime parser based on your the file system data from `mftecmd.body`  

### 4. Convert Super Timeline to CSV and Filter

```bash
psort.py --output-time-zone 'UTC' -o l2tcsv -w supertimeline.csv out.plaso "date > datetime('2023-01-01T00:00:00') AND date < datetime('2023-01-27T00:00:00')"
``` 

```bash
grep -a -v -i -f timeline_noise.txt supertimeline.csv > supertimeline_final.csv
```  