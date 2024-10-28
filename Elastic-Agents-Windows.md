# Comprehensive Guide to Elastic Agent Deployment and Windows Event Monitoring

## **WireShark Filter for DeAuth Frames**

- **Set WiFi Adapter to Monitor Mode**
  - Select the interface that is placed into monitor mode (e.g., `wlan0mon`).
  
- **Filter for DeAuth Subtype**
  - Use the following filter in Wireshark:
  
  ```bash
  wlan.fc.type == 0 && wlan.fc.type_subtype == 0x0C
  ```

- **Additional Reference**
  - For more details, see the article on analyzing deauthentication packets in Wireshark.

## **Elastic Agent Deployment**

**Note:** Ensure the `elastic_agent_endpoint` option within Elastic allows the subnet of the boxes where you want to deploy agents (e.g., `192.168.1.0/24`).

### **Creating New Agent Policy & Enrolling Agent**

- **Documentation:** Refer to the [Elastic Fleet Guide](https://www.elastic.co/guide/en/fleet/current/install-fleet-managed-elastic-agent.html).

1. **Navigate to Security Onion Manager:**
   - Go to `Fleet > Add Agent`.

2. **Create New Agent Policy:**
   - Provide a descriptive name for the agent policy.

3. **Enroll in Fleet:**
   - Select the specific OS to install Elastic Agent (e.g., Windows or Linux).

4. **Install Elastic Agent:**
   - Remotely access the box where you want to install the agent and execute the following commands line by line:

   ```powershell
   $ProgressPreference = 'SilentlyContinue'
   Invoke-WebRequest -Uri http://192.168.1.2:8443/artifacts/beats/elastic-agent/elastic-agent-8.14.3-windows-x86_64.zip -OutFile elastic-agent-8.14.3-windows-x86_64.zip
   Expand-Archive .\elastic-agent-8.14.3-windows-x86_64.zip -DestinationPath .
   cd elastic-agent-8.14.3-windows-x86_64
   .\elastic-agent.exe install --url=https://192.168.1.2:8220 --enrollment-token=NlR2XzVKRUJGTVFRRVA4REF1d3c6STc5LVowcXVSQ3l6bjRuei1XOVpSQQ== --insecure
   ```

   **Note:** The `--insecure` flag is used to address x509 certificate signed by unknown authority errors (use only in development environments). For more information, see [Secure Connections](https://www.elastic.co/guide/en/fleet/8.15/secure-connections.html)

5. **Validate Log Ingestion:**
   - Run a simple file creation script and identify this activity in Elastic:

   ```powershell
   for ($i=0; $i -lt 25; $i++) {
       New-Item -Path C:\Users\simspace\Host_Generation -Name "File$i.txt" -ItemType "file"
   }
   ```

Here's a refined version of your markdown documentation for clarity and organization:

## **Disenrolling Agents**

If Elastic Agent unenrollment fails, you can use the Kibana Fleet APIs to force unenroll the agent. Refer to the [troubleshooting guide](https://www.elastic.co/guide/en/fleet/8.14/fleet-troubleshooting.html#deleted-policy-unenroll) for more information.

### **Using Kibana Fleet APIs**

1. **Access Management:**
   - Navigate to `Management > Dev`.

2. **Make API Request to Disenroll Agent:**

   ```bash
   POST kbn:/api/fleet/agents/<agent_id>/unenroll
   {
     "force": true,
     "revoke": true
   }
   ```

### **Manually Unenrolling Agent from Windows Box**

1. Stop the Elastic Agent service:

   ```powershell
   Stop-Service -Name "Elastic Agent"
   ```

2. Remove the Elastic Agent directory:

   ```powershell
   Remove-Item -Path "C:\Users\simspace\elastic-agent-8.14.3-windows-x86_64" -Recurse -Force
   ```

3. Delete the Elastic Agent service:

   ```powershell
   sc.exe delete "Elastic Agent"
   ```

4. Verify the service removal:

   ```powershell
   Get-Service | Where-Object {$_.DisplayName -like "*Elastic Agent*"}
   ```

### **Automatically Uninstalling Agent from Windows Box**

Navigate to the Elastic Agent directory and run the uninstall command:

```powershell
cd "C:\Path\to\elastic-agent-8.14.3-windows-x86_64"
.\elastic-agent.exe uninstall
```

## **Agent vs. Beat Deployment**

| Feature                | Beats                                      | Elastic Agent                                         |
|------------------------|--------------------------------------------|-------------------------------------------------------|
| **Purpose**            | Single-purpose shippers (e.g., logs, metrics) | Unified agent for logs, metrics, security             |
| **Management**         | Managed individually                       | Centrally managed via Fleet                           |
| **Deployment**         | Deployed separately (Filebeat, Metricbeat, etc.) | One Elastic Agent per host                            |
| **Configuration**      | Separate YAML files for each Beat          | Managed centrally via Fleet policies                  |
| **Security Integration** | No built-in security features             | Includes security (Endpoint Security, Malware Protection) |
| **Updates**            | Manual updates for each Beat               | Automatic updates via Fleet                           |
| **Complexity**         | Higher complexity for multi-data type use cases | Simpler deployment, especially at scale               |
| **Ideal Use Case**     | Lightweight, purpose-specific data collection | Unified data collection and security with centralized management |

## **Copying Item from Local Box to Remote Box**

1. **Enable WinRm:**
   - Open an Administrator PowerShell session.
   - Run `winrm quickconfig`.

2. **Get Network Interface Index:**
   - List all network adapters and their profiles:

     ```powershell
     Get-NetConnectionProfile
     ```

3. **Set Network to Private:**
   - Use the following command:

     ```powershell
     Set-NetConnectionProfile -InterfaceIndex <index#> -NetworkCategory Private
     ```

4. **Configure WSMan:**

   ```powershell
   Set-WSManQuickConfig -Force
   ```

5. **Enable PowerShell Remoting:**

   ```powershell
   Enable-PSRemoting -Force
   ```

6. **Allow trust between your host and the client VM:**

   ```powershell
   Set-Item WSMan:\localhost\Client\TrustedHosts -Value "IP addresses here"
   ```

7. **Appending trusted IP addresses without deleting what you've already created**:

    ```PowerShell
    $current = Get-Item WSMan:\localhost\Client\TrustedHosts Set-Item WSMan:\localhost\Client\TrustedHosts -Value "ENTER_IPs_HERE"
    ```

8. **Create a Session and Copy Item:**

   ```powershell
   $session = New-PSSession -ComputerName 192.168.1.84 -Credential (Get-Credential)
   Copy-Item .\YOUR-FILE.ps1 -Destination "C:\Users\User\OneDrive" -ToSession $session
   ```

9. **Run Executables:**

    PowerShell script:

    ```powershell
    powershell.exe -ExecutionPolicy Bypass -File .\script.ps1
    ```

    Batch file:

    ```powershell
    & "C:\Path\to\executable.bat"
    ```

Here's a reorganized version of your markdown documentation with embedded links for clarity and organization:

## **Baselining**

```powershell
$baseline = Get-Content .\baseline-service-20231018.txt
$current = Get-Content services-liveinvestigation.txt
Compare-Object -ReferenceObject $baseline -DifferenceObject $current
```

## **Windows Host Configurations**

## **Sysinternals Configuration**

### **Sysinternals Downloads and Deployment**

- [Sysinternals Downloads](https://learn.microsoft.com/en-us/sysinternals/downloads/)
- [Sysinternals Guide](https://www.makeuseof.com/windows-sysinternals-guide/)

### **Sysmon Configuration**

- [Sysmon Configuration by SwiftOnSecurity](<https://github.com/SwiftOnSecurity/sysmon-config>)

### **Windows Host Log Configuration Information:**

- [Enable Windows Log Settings by Yamato-Security](https://github.com/Yamato-Security/EnableWindowsLogSettings)
  - Run this Batchfile on each host to enhance native Windows logging!

### **Essential Event Logs and Event IDs**

| Event             | Specific Event Log                                            | Essential Event IDs                                    |
| ----------------- | ------------------------------------------------------------- | ------------------------------------------------------ |
| Logons            | Security                                                      | 4624, 4625, 4634, 4647, 4648, 4672, 4720, 4726         |
| Account Logon     | Security                                                      | 4768, 4769, 4771, 4776                                 |
| RDP               | Security \| RDPClient \| RDPCoreTS \| RemoteConnectionManager | 4624, 4625, 4778, 4779, 1024, 1102, 98, 131, 1149      |
| Network Shares    | Security                                                      | 5140-5145                                              |
| Scheduled Tasks   | Security \| TaskScheduler                                     | 4698, 106, 140-141, 200-201                            |
| Installation      | Application                                                   | 1033, 1034, 11707, 11708, 11724, 7034-7036, 7040, 7045 |
| Services          | System \| Security                                            | 4697                                                   |
| Log Clearing      | Security \| System                                            | 1102, 104                                              |
| Malware Execution | Security \| System \| Application                             | 1000-1002                                              |
| Anti-Malware Log  | Windows-Defender/Operational                                  | 4688, 1116-1119                                        |
| Command Lines     | Security \| PowerShell/Operational                            | 4688, 4103-4104                                        |
| WMI               | WMI-Activity/Operational                                      | 5857-5861                                              |

## **Deploying Default/Custom Integrations**

### **Default Windows Integration**

The default "Windows Integration" in **Fleet > Agent Policies** contains essential Windows logging. To enhance it, include additional Event Codes to monitor.

- **Filter for Default Windows Integration:**

  ```bash
  winlog.channel: *
  ```

### **Add Custom Windows Event Logs Integration Using Elastic Fleet UI**

1. **Log into Elastic Cloud / Kibana:**
   - Open your web browser and log in to your Elastic Cloud or Kibana instance.
   - Navigate to the Fleet section in the side menu.

2. **Create or Update a Fleet Policy:**
   - Go to the Policies tab under Fleet.
   - Create a new policy or select an existing policy where the Windows agent is enrolled.

3. **Add Windows Integration to the Policy:**
   - Click "Add Integration" within the policy.
   - Search for Windows and install the integration.
   - Configure input fields for Application, Security, System logs, etc.

4. **Edit Integration Policy for Custom Event Logs:**
   - Click "Edit Integration."
   - Scroll to the Custom Event Logs section.
   - Add each log channel with its respective dataset and event IDs as defined in the YAML file below.

   **Note:** Check the "advanced" sections for additional configurations.

   **Example:**

   - Event Log Name: Microsoft-Windows-PowerShell/Operational
   - Dataset Name: windows.custom.powerShell
   - Event IDs: 4103, 4104...

**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdoPO_t7DKySg1UHoUUtrl4fVUIwR7Wv6PUdxNcDg6Y8tJc-Qh_N3Kncne1UR-acK7mPVQHFx0-lxb1J97hV_P42Y91LC-tgry6wWki7_yRmvUg0emL-JHxKqvFrwhjiYLEb0ZulKW8-UCLn23F7wVO9z_6?key=7acgMCMbo5vX64e_MlFaKg)**

**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdG-s7AyMMp3nMb6hCJmS2TYJIIgJvNsohoBqYgkynpO1_FOohlqnzmnhBtaU66IMCUrmxso2lIN6vyU7xbgMX1D3hfPtZWRCzrtFQdvt2oSl91o7sqhyF1BGPusB2yqD21QML0nXhRQ_JfDW9kKjeRmaJC?key=7acgMCMbo5vX64e_MlFaKg)**

### **Add Custom Windows Event Logs Integration (Using YAML File Upload)**

**Note:** The YAML method offers flexibility and efficiency for deploying multiple custom Windows Event Logs.

1. **Ensure YAML Configuration is Correct:**

   ```yaml
   inputs:
     - type: winlog
       streams:
         - name: security
           dataset: windows.security
           event_logs:
             - name: Security
               event_id: 4624, 4625
         - name: application
           dataset: windows.application
           event_logs:
             - name: Application
               event_id: 1000, 1001
         - name: powershell
           dataset: windows.custom.powerShell
           event_logs:
             - name: Microsoft-Windows-PowerShell/Operational
               event_id: 4103, 4104
         - name: terminal_services_remote_connection_manager
           dataset: windows.custom.terminalServices
           event_logs:
             - name: Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational
               event_id: 1149
         - name: terminal_services_local_session_manager
           dataset: windows.custom.localSessionManager
           event_logs:
             - name: Microsoft-Windows-TerminalServices-LocalSessionManager/Operational
               event_id: 21, 24, 25
   ```

2. **Apply YAML Configuration Manually (Optional):**
   - Modify the Elastic Agent's configuration file directly on the agent host:
     - For Linux: `/etc/elastic-agent/elastic-agent.yml`
     - For Windows: `C:\Program Files\Elastic\Agent\elastic-agent.yml`
   - Insert your YAML configuration under the "inputs" section.

3. **Restart the Agent:** Ensure to restart the agent after applying changes for them to take effect.

## **Review, Apply, and Verify Elastic Agents**

Once the agent has ingested the custom event logs, you can verify the logs in Kibana.

### **1. Verify Data Ingestion in Discover**

- **Select Index Pattern:**
  - In the index pattern dropdown, select `logs-*`, `logs-windows-*`, or the specific log ingestion setup you have.

- **Search for Custom Dataset and Event IDs:**
  - Use the following search query:

    ```bash
    event.dataset: "NAME_OF_DATASET" (e.g., "windows.custom.powershell") and event.code: (#### OR ####)
    ```

**Note:** Best practices for tracking integrations include:

- Using a common namespace (e.g., `vg24range`)
- Applying a common filter query (e.g., `winlog.channel: Microsoft-Windows*` and `winlog.channel: "Application"`)

### **2. Create Dashboard to Verify Creation of Agents**

- **Navigate to Dashboard:**
  - Go to **Kibana → Dashboard**.

- **Create New Dashboard (if needed):**
  - Click on "Create new dashboard" to start from scratch or open an existing one to add visualizations.

- **Add a Visualization for PowerShell Logs:**
  - Click on "Create New" → "Visualization."
  - Choose the type of visualization (e.g., table, bar chart, time series).

- **Set Up the Visualization:**
  - **Index Pattern:** Choose the appropriate index pattern, likely `logs-*` or `logs-windows-*`.
  - **Filter by Dataset:** Add a filter for the dataset you are interested in.

## **Tracking Default Elastic Integration Filters**

|                   |               |                                     |          |                                                                       |                                                                                                 |
| ----------------- | ------------- | ----------------------------------- | -------- | --------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| Log Integration   | Index Pattern | Namespace                           | Operator | Filter Query and Channel                                              | Event IDs                                                                                       |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: *                                                     | N/A                                                                                             |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-AppLocker/EXE and DLL"             | 8003, 8004, 8001, 8002, 8005                                                                    |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-AppLocker/MSI and Script"          | 8005, 8006, 8007                                                                                |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-AppLocker/Packaged app-Deployment" | 8007                                                                                            |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-AppLocker/Packaged app-Execution"  | 8008                                                                                            |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-ForwardedEvents"                   | 4624, 4625, 4688, 4776, 4672, 4720, 4726, 4732, 4733, 4673, 4674, 4768, 4771, 4781, 4697        |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-PowerShell/Operational"            | 4103, 4104, 4105, 4106, 4100, 4107                                                              |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-PowerShell"                        | 400, 403, 600, 800                                                                              |
| Windows Endpoints | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-Sysmon/Operational"                | 1, 3, 7, 10, 11, 12, 13, 15, 22, 23, 25, 30, 32, 7045, 4649, 4616, 1102, 1104, 5156, 5158, 5145 |

## **Tracking Elastic Custom Integration Filters**

|                                             |                       |               |                                     |          |                                                                                          |                                                                                                            |
| ------------------------------------------- | --------------------- | ------------- | ----------------------------------- | -------- | ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Custom Log Integration                      | Dataset Name          | Index Pattern | Namespace                           | Operator | Filter Query                                                                             | Event IDs                                                                                                  |
| Terminal Services Remote Connection Manager | windows.custom.remote | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational" | 1149, 21, 1024, 1006, 1008, 1010, 1023, 1025                                                               |
| Application                                 | windows.application   | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Application"                                                            | 1000, 1001, 1026, 2004, 2005, 2019, 2020                                                                   |
| Security                                    | windows.security      | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Security"                                                               | 4624, 4625, 4634, 4648, 4688, 4689, 4720, 4726, 4732, 4733, 4768, 4769, 4770, 4771, 4670, 4697, 4719, 1102 |
| Setup                                       | windows.setup         | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "Setup"                                                                  | 1000, 1001, 1002, 1011, 1020                                                                               |
| System                                      | windows.system        | logs-*        | data_stream.namespace : "vg24range" | AND      | winlog.channel: "System"                                                                 | 6005, 6006, 6008, 7000, 7001, 7011, 7036, 7040, 1101, 1102, 2004, 2019                                     |

## **Windows Integration (Pre-Installed) Event IDs**

### **AppLocker (EXE/DLL and MSI/Script)**

- **8003, 8004**: Application blocked or allowed (EXE/DLL)
- **8001, 8002**: AppLocker policy changes (critical for detecting unauthorized changes)
- **8005**: Script/MSI execution blocked or allowed (rules enforcement)
- **8006, 8007**: Additional MSI/Script and packaged app logs for broader coverage

### **Forwarded Events**

- **4624, 4625**: Logon successes and failures, respectively
- **4688**: Process creation events
- **4776**: Credential validation errors
- **4672**: Special privileges assigned to new logons (admin activities)
- **4720**: User account creation
- **4726**: User account deletion
- **4732, 4733**: Group membership changes (new additions or removals)
- **4673**: Privileged service requested
- **4674**: Privileged object operation
- **4768, 4769, 4770**: Kerberos Ticket requests and renewals
- **4771**: Kerberos pre-authentication failed
- **4648**: A logon was attempted using explicit credentials

### **PowerShell Operational**

- **4103, 4104**: PowerShell script execution and script block logging
- **4105**: Script termination
- **4106**: Module loading
- **4100**: PowerShell Provider started
- **4107**: PowerShell script has been deleted

### **Windows PowerShell Channel**

- **400**: PowerShell engine state changes
- **403**: Command executed
- **600**: PowerShell script block logging (additional context for executed commands)
- **800**: PowerShell script logging (script execution details)

### **Sysmon Operational**

- **1**: Process creation (critical for tracking new processes)
- **3**: Network connections (essential for identifying suspicious network activity)
- **7**: Image loaded (DLL or driver loading)
- **10**: Process access (used for lateral movement or process tampering)
- **11**: File creation
- **12, 13**: Registry object creation and deletion
- **15**: File deletion
- **22, 23**: DNS query logging
- **25**: Process tampering detection (useful for malware or rootkit behavior)
- **30**: File time modifications (often used to cover tracks)
- **32**: WMI activity (WMI often used for lateral movement in attacks)
  
### **General Log Tampering/Anti-Forensics**

- **1102**: The audit log was cleared (direct evidence of potential cover-up of malicious actions)
- **1104**: Security log has been tampered with (important for detecting modification of security logs)
- **4616**: System time was changed (useful in anti-forensics to manipulate timestamps)

## **Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational Event IDs**

- **1149**: A remote desktop session has been disconnected. Useful for tracking remote session activities and potential unauthorized access.
- **21**: A new remote desktop session has been created. Monitors when users initiate remote connections.
- **1024**: A remote desktop session has ended. Important for auditing session terminations.
- **1006**: Remote session logon failure. Crucial for detecting unauthorized access attempts or failed login attempts.
- **1008**: Remote session logon success. Useful for tracking who has accessed the system remotely.
- **1010**: Remote desktop session has been reconnected. Important for tracking reconnection events.
- **1023**: Remote desktop connection failed. Useful for identifying potential connection issues or unauthorized access attempts.
- **1025**: Remote desktop session configuration changes. Crucial for detecting unauthorized changes to session settings.

## **Application Event IDs**

- **1000**: Application Error (application crashes)
- **1001**: Application Hang (application freezes)
- **1026**: .NET Runtime Error (errors in .NET applications)
- **2004**: Application Crash (detailed crash info)
- **2005**: Application Hang (detailed hang info)
- **2019**: Application crashes related to Windows services
- **2020**: Application crashes due to COM component issues

## **Security Channel Event IDs**

- **4624**: Successful Logon - A user successfully logged on to the system.
- **4625**: Failed Logon - A logon attempt was unsuccessful.
- **4634**: Logoff - A user logged off from the system.
- **4648**: Logon Attempt with Explicit Credentials - A logon attempt was made with explicit credentials.
- **4656**: Object Handle Request - An attempt was made to access an object.
- **4662**: Operation Performed on Object - An operation was performed on an object.
- **4663**: Access Attempt to Object - An attempt was made to access an object.
- **4670**: Permissions on Object Changed - Permissions on an object were modified.
- **4688**: Process Creation - A new process has been created.
- **4689**: Process Termination - A process has ended.
- **4697**: Service Installed on System - A service was installed on the system.
- **4719**: System Audit Policy Changed - The audit policy was changed.
- **4720**: User Account Creation - A user account was created.
- **4726**: User Account Deletion - A user account was deleted.
- **4732**: Member Added to Security-Enabled Local Group - A member was added to a security-enabled local group.
- **4733**: Member Removed from Security-Enabled Local Group - A member was removed from a security-enabled local group.
- **4768**: Kerberos Authentication Ticket (TGT) Request - A Kerberos TGT request occurred.
- **4769**: Kerberos Service Ticket Request - A Kerberos service ticket request occurred.
- **4770**: Kerberos Ticket Renewal - A Kerberos ticket was renewed.
- **4771**: Kerberos Pre-Authentication Failure - A Kerberos pre-authentication attempt failed.
- **4776**: NTLM Authentication - NTLM authentication occurred.
- **5145**: Access Attempt to a Network Share Object - An attempt was made to access a network share object.
- **5136**: Directory Service Object Modified - A directory service object was modified.
- **4657**: Registry Value Modified - A registry value was modified.
- **5156**: Windows Filtering Platform Allowed Connection - The Windows Filtering Platform allowed a connection.
- **1102**: Audit Log Cleared - The audit log was cleared.

## **Setup Channel Event IDs**

- **1000**: New Application or Component Installed
- **1001**: Setup Errors (Windows updates/applications)
- **1002**: System Setup Changes (feature addition/removal)
- **1011**: System Startup/Shutdown Related to Setup
- **1020**: Major Setup Changes (Windows upgrade/feature installation)

## **System Channel Event IDs**

- **6005**: Event Log Service Startup
- **6006**: Event Log Service Shutdown
- **6008**: Unexpected Shutdown
- **7000**: Service Failed to Start
- **7001**: Service Dependency Failed
- **7011**: Service Timeout
- **7036**: Service State Change
- **7040**: Service Startup Type Changed
- **1101**: Shutdown Initiated
- **1102**: Audit Log Cleared
- **2004**: System Crashes/Stop Errors
- **2019**: System Resource Exhaustion
