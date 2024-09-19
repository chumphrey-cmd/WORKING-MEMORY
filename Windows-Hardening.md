# Windows Hardening Procedures I

## Linksys Router

80/tcp: HTTP (Tomato WAP firmware httpd, Linksys WRT54GL WAP)

### **Securing Port 80/tcp: HTTP (Tomato WAP Firmware)**

#### **1. Change the Default Router Admin Password**

**Using GUI:**

1. Open a web browser and enter the router’s IP address (e.g., `192.168.1.1`) to access the router’s web interface.
2. Log in with the default admin credentials if still set to default.
3. Navigate to `Administration` > `Management`.
4. Find the `Router Password` section.
5. Enter a new, strong password in both the `New Password` and `Verify Password` fields.
6. Click `Save Settings`.

#### **2. Disable Remote Management**

**Using GUI:**

1. Access the router’s web interface as described above.
2. Go to `Administration` > `Management`.
3. Locate the `Remote Management` section.
4. Ensure the `Remote Management` option is set to `Disabled`.
5. Click `Save Settings`.

#### **3. Update Router Firmware**

**Using GUI:**

1. Go to the router’s web interface.
2. Navigate to `Administration` > `Firmware Upgrade`.
3. Check for the latest firmware version on the Tomato website or the router manufacturer’s website.
4. Download the latest firmware.
5. Click `Choose File` to select the downloaded firmware file.
6. Click `Upload` to begin the upgrade process.
7. Wait for the router to reboot and apply the new firmware.

#### **4. Secure HTTP Access**

**Using GUI:**

1. Access the router’s web interface.
2. Navigate to `Administration` > `Management`.
3. Check if there is an option to enable HTTPS access.
   - If available, enable HTTPS and configure it.
   - Ensure that HTTP access is disabled if HTTPS is enabled.
4. Click `Save Settings`.

#### **5. Configure Firewall Rules**

**Using GUI:**

1. Go to `Security` > `Firewall`.
2. Enable firewall protection and ensure that options such as `Block WAN Requests` are checked.
3. Configure custom firewall rules to block incoming traffic on port 80 if you do not need external access:
   - Locate the `Port Forwarding` or `Port Filtering` section.
   - Add a rule to block incoming traffic on port 80 from the WAN side.
4. Click `Save Settings`.

#### **6. Disable Unnecessary Services**

**Using GUI:**

1. Access the router’s web interface.
2. Navigate to `Administration` > `Management`.
3. Look for services like `UPnP` or `Telnet` that might be enabled by default.
4. Disable any unnecessary services.
5. Click `Save Settings`.

#### **7. Set Up Network Security**

**Using GUI:**

1. Navigate to `Wireless` > `Basic Settings`.
2. Ensure that `Wireless Security` is enabled.
3. Choose WPA2-PSK (AES) as the encryption type.
4. Set a strong passphrase for your wireless network.
5. Click `Save Settings`.

#### **8. Enable Logging**

**Using GUI:**

1. Access the router’s web interface.
2. Go to `Administration` > `Syslog`.
3. Enable `Syslog` and configure the router to send logs to a remote syslog server if possible.
4. Click `Save Settings`.

#### **9. Regularly Review and Update**

**Using GUI:**

1. Periodically log in to the router’s web interface.
2. Check for firmware updates and apply them as needed.
3. Review and update passwords and security settings as necessary.

#### **10. Monitor Network Traffic**

**Using GUI:**

1. Access the router’s web interface.
2. Navigate to `Status` > `Bandwidth` or a similar section to monitor traffic.
3. Look for unusual traffic patterns and adjust settings as necessary.

## Windows 10 (Intentionally Vulnerable)

22/tcp: SSH (OpenSSH for Windows 8.1)
135/tcp: MSRPC (Microsoft Windows RPC)
139/tcp: NetBIOS-SSN (Microsoft Windows)
445/tcp: Microsoft-DS
3389/tcp: MS-WBT (Microsoft Terminal Services)
5357/tcp: HTTP (Microsoft HTTPAPI httpd 2.0, SSDP|UPnP)
5985/tcp: HTTP (Microsoft HTTPAPI httpd 2.0, SSDP|UPnP)

## 22/tcp: SSH (OpenSSH for Windows 8.1)

### **1. Disable SSH if Not Required**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Stop the SSH service:

   ```bash
   net stop sshd
   ```

3. Disable the SSH service from starting automatically:

   ```bash
   sc config sshd start= disabled
   ```

**Using GUI:**

1. Press `Windows + R`, type `services.msc`, and press Enter.
2. Locate `OpenSSH SSH Server` in the list of services.
3. Right-click on `OpenSSH SSH Server` and select `Properties`.
4. Click the `Stop` button to stop the service.
5. Change the `Startup type` to `Disabled`.
6. Click `Apply`, then `OK`.

### **2. Restrict SSH Access**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Configure Windows Firewall to block SSH access by default and allow only specific IPs:

   ```bash
   netsh advfirewall firewall add rule name="Allow SSH from Trusted IP" protocol=TCP dir=in localport=22 remoteip=TRUSTED_IP_ADDRESS action=allow
   netsh advfirewall firewall add rule name="Block SSH" protocol=TCP dir=in localport=22 action=block
   ```

   Replace `TRUSTED_IP_ADDRESS` with the IP addresses you want to allow.

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Select `TCP` and specify port `22`, then click `Next`.
6. Choose `Allow the connection` and click `Next`.
7. Select the profiles where this rule should apply (Domain, Private, Public), then click `Next`.
8. Give the rule a name like "Allow SSH from Trusted IP" and click `Finish`.
9. Create another rule to block SSH:
   - Follow the same steps but choose `Block the connection` in step 6.
   - Name the rule "Block SSH".

### **3. Configure SSH Securely**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Edit the SSH configuration file (typically located at `C:\ProgramData\SSH\sshd_config`):

   ```bash
   notepad C:\ProgramData\SSH\sshd_config
   ```

3. Add or modify the following lines in `sshd_config`:

   ```bash
   PermitRootLogin no
   PasswordAuthentication no
   PubkeyAuthentication yes
   ```

4. Save the file and exit Notepad.
5. Restart the SSH service to apply changes:

   ```bash
   net stop sshd
   net start sshd
   ```

**Using GUI:**

1. Navigate to `C:\ProgramData\SSH\` in File Explorer.
2. Right-click on `sshd_config` and select `Open with Notepad`.
3. Make the following changes in the file:
   - Set `PermitRootLogin` to `no` to disable root login.
   - Set `PasswordAuthentication` to `no` to disable password authentication.
4. Save the changes and close Notepad.
5. Restart the SSH service via the Services console:
   - Open `services.msc`, right-click `OpenSSH SSH Server`, and select `Restart`.

### **4. Monitor SSH Logs**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. View the SSH logs (typically located in `C:\ProgramData\SSH\Logs` or accessible through Event Viewer):

   ```bash
   notepad C:\ProgramData\SSH\Logs\sshd.log
   ```

**Using GUI:**

1. Press `Windows + R`, type `eventvwr`, and press Enter to open Event Viewer.
2. Navigate to *Applications and Services Logs* > *OpenSSH* or check under *Windows Logs* > *Security* or *Application* for related events.
3. Review logs for any unusual activity or failed login attempts.

## 135/tcp: MSRPC (Microsoft Windows RPC)

### **Securing Port 135/tcp: MSRPC (Microsoft Windows RPC)**

#### **1. Restrict RPC Access**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Use `netsh` to create firewall rules:
   - **Allow RPC Access from Specific IPs:**

     ```bash
     netsh advfirewall firewall add rule name="Allow RPC from Trusted IP" protocol=TCP dir=in localport=135 remoteip=TRUSTED_IP_ADDRESS action=allow
     ```

   - **Block RPC Access from All Other IPs:**

     ```bash
     netsh advfirewall firewall add rule name="Block RPC" protocol=TCP dir=in localport=135 action=block
     ```

   Replace `TRUSTED_IP_ADDRESS` with the IP addresses you want to allow.

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `135`, then click `Next`.
6. Select `Allow the connection` and click `Next`.
7. Specify the IP addresses or subnets allowed to connect, then click `Next`.
8. Choose the profiles (Domain, Private, Public) where this rule should apply, then click `Next`.
9. Name the rule (e.g., "Allow RPC from Trusted IPs") and click `Finish`.
10. Create another rule to block RPC access:
    - Follow the same steps but choose `Block the connection` in step 6.
    - Name the rule "Block RPC".

#### **2. Apply the Principle of Least Privilege**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Review the accounts under which RPC services are running:

   ```bash
   sc qc RpcSs
   ```

3. Ensure that RPC services are running under the least privileged account necessary.

**Using GUI:**

1. Press `Windows + R`, type `services.msc`, and press Enter to open Services.
2. Locate `Remote Procedure Call (RPC)` and `RPC Locator` services.
3. Right-click each service, select `Properties`, and ensure that they are configured to use the `Local System account` or an appropriate service account with minimal privileges.

#### **3. Regularly Update the System**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Run Windows Update:

   ```bash
   wuauclt /detectnow
   ```

**Using GUI:**

1. Press `Windows + I` to open Settings.
2. Navigate to `Update & Security`.
3. Click `Check for updates`.

#### **4. Monitor RPC Logs**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Use PowerShell to retrieve RPC logs:

   ```bash
   Get-EventLog -LogName System -Source "RPCSS"
   ```

**Using GUI:**

1. Press `Windows + R`, type `eventvwr`, and press Enter to open Event Viewer.
2. Navigate to *Windows Logs* > *System*.
3. Look for events related to `RPCSS`.

#### **5. Configure DCOM Security**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Use `dcomcnfg`:

   ```bash
   dcomcnfg
   ```

3. Navigate to *Component Services* > *Computers* > *My Computer*.
4. Right-click *My Computer*, select *Properties*, and configure settings under the *COM Security* tab.

**Using GUI:**

1. Press `Windows + R`, type `dcomcnfg`, and press Enter.
2. Expand *Component Services* > *Computers* > *My Computer*.
3. Right-click *My Computer*, select *Properties*, and adjust settings under the *COM Security* tab.

#### **6. Use Network Segmentation**

- Configure VLANs or network segments via your network switch or router's management interface to limit RPC traffic to trusted segments only.

## 139/tcp: NetBIOS-SSN (Microsoft Windows)

### **Securing Port 139/tcp: NetBIOS-SSN (Microsoft Windows)**

#### **1. Disable NetBIOS Over TCP/IP**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Run the following command to disable NetBIOS over TCP/IP on all network interfaces:

   ```bash
   wmic nicconfig where (IPEnabled=TRUE) call SetTcpipNetbios 2
   ```

   This command sets NetBIOS over TCP/IP to `Disabled`.

**Using GUI:**

1. Press `Windows + R`, type `ncpa.cpl`, and press Enter to open Network Connections.
2. Right-click on your active network connection and select `Properties`.
3. Select `Internet Protocol Version 4 (TCP/IPv4)` and click `Properties`.
4. Click on `Advanced…`.
5. Navigate to the `WINS` tab.
6. Under `NetBIOS setting`, select `Disable NetBIOS over TCP/IP`.
7. Click `OK` to close the dialog boxes and apply the changes.

#### **2. Block NetBIOS Traffic at the Firewall**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Add a rule to block incoming traffic on port 139:

   ```bash
   netsh advfirewall firewall add rule name="Block NetBIOS" protocol=TCP dir=in localport=139 action=block
   ```

3. Optionally, allow NetBIOS traffic from trusted IPs:

   ```bash
   netsh advfirewall firewall add rule name="Allow NetBIOS from Trusted IP" protocol=TCP dir=in localport=139 remoteip=TRUSTED_IP_ADDRESS action=allow
   ```

   Replace `TRUSTED_IP_ADDRESS` with the IP addresses you want to allow.

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `139`, then click `Next`.
6. Select `Block the connection` and click `Next`.
7. Choose the profiles where this rule should apply (Domain, Private, Public), then click `Next`.
8. Name the rule (e.g., "Block NetBIOS") and click `Finish`.
9. Create another rule to allow NetBIOS traffic from trusted IPs:
   - Follow the same steps but choose `Allow the connection` in step 6.
   - Name the rule "Allow NetBIOS from Trusted IPs".

#### **3. Disable File and Printer Sharing**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Disable file and printer sharing:

   ```bash
   netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No
   ```

**Using GUI:**

1. Press `Windows + R`, type `ncpa.cpl`, and press Enter to open Network Connections.
2. Right-click on your active network connection and select `Properties`.
3. Uncheck `File and Printer Sharing for Microsoft Networks` under the list of installed network components.
4. Click `OK` to apply the changes.

#### **4. Configure Group Policy**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Use `gpedit.msc` to access Group Policy Editor:

   ```bash
   gpedit.msc
   ```

3. Navigate to `Computer Configuration` > `Administrative Templates` > `Network` > `Lanman Workstation`.
4. Set `Enable Insecure Guest Logons` to `Disabled`.

**Using GUI:**

1. Press `Windows + R`, type `gpedit.msc`, and press Enter to open the Group Policy Editor.
2. Navigate to `Computer Configuration` > `Administrative Templates` > `Network` > `Lanman Workstation`.
3. Double-click on `Enable Insecure Guest Logons`.
4. Set it to `Disabled` and click `Apply`, then `OK`.

#### **5. Regularly Review and Update System**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Check for updates to ensure your system is up-to-date:

   ```bash
   wuauclt /detectnow
   ```

**Using GUI:**

1. Press `Windows + I` to open Settings.
2. Navigate to `Update & Security`.
3. Click `Check for updates`.

#### **6. Monitor Network Traffic**

**Using Command Line:**

1. Use `netstat` to monitor network connections:

   ```bash
   netstat -an | find "139"
   ```

**Using GUI:**

1. Open Resource Monitor:
   - Press `Windows + R`, type `resmon`, and press Enter.
2. Navigate to the *Network* tab.
3. Look for connections on port 139.

## 445/tcp: Microsoft-DS

### **Securing Port 445/tcp: Microsoft-DS**

#### **1. Disable SMBv1**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Disable SMBv1:

   ```bash
   sc config lanmanworkstation start= disabled
   sc config lanmanserver start= disabled
   ```

**Using PowerShell:**

1. Open PowerShell as Administrator.
2. Run the following command to disable SMBv1:

   ```powershell
   Disable-WindowsOptionalFeature -Online -FeatureName FS-SMB1
   ```

**Using GUI:**

1. Press `Windows + R`, type `optionalfeatures.exe`, and press Enter to open Windows Features.
2. Locate `SMB 1.0/CIFS File Sharing Support`.
3. Uncheck the box and click `OK`.
4. Restart your computer if prompted.

#### **2. Block Port 445 at the Firewall**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Block incoming traffic on port 445:

   ```bash
   netsh advfirewall firewall add rule name="Block SMB" protocol=TCP dir=in localport=445 action=block
   ```

3. Optionally, allow SMB traffic from specific trusted IP addresses:

   ```bash
   netsh advfirewall firewall add rule name="Allow SMB from Trusted IP" protocol=TCP dir=in localport=445 remoteip=TRUSTED_IP_ADDRESS action=allow
   ```

   Replace `TRUSTED_IP_ADDRESS` with the IP addresses you want to allow.

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `445`, then click `Next`.
6. Select `Block the connection` and click `Next`.
7. Choose the profiles where this rule should apply (Domain, Private, Public), then click `Next`.
8. Name the rule (e.g., "Block SMB") and click `Finish`.
9. Create another rule to allow SMB traffic from trusted IPs:
   - Follow the same steps but choose `Allow the connection` in step 6.
   - Name the rule "Allow SMB from Trusted IPs".

#### **3. Disable Unnecessary SMB Shares**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. List all shared resources:

   ```bash
   net share
   ```

3. Remove unnecessary shares:

   ```bash
   net share sharename /delete
   ```

**Using GUI:**

1. Press `Windows + R`, type `compmgmt.msc`, and press Enter to open Computer Management.
2. Navigate to `Shared Folders` > `Shares`.
3. Right-click on any shares you do not need and select `Stop Sharing`.

#### **4. Apply Security Updates**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Check for updates to ensure your system is up-to-date:

   ```bash
   wuauclt /detectnow
   ```

**Using GUI:**

1. Press `Windows + I` to open Settings.
2. Navigate to `Update & Security`.
3. Click `Check for updates`.

#### **5. Enable Network Level Authentication (NLA) for Remote Desktop**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Run the following command to ensure NLA is enabled for Remote Desktop:

   ```bash
   reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v "UserAuthentication" /t REG_DWORD /d 1 /f
   ```

**Using GUI:**

1. Press `Windows + R`, type `SystemPropertiesRemote`, and press Enter.
2. Under the *Remote* tab, ensure that *Allow connections only from computers running Remote Desktop with Network Level Authentication (recommended)* is selected.
3. Click *Apply*, then *OK*.

#### **6. Monitor Network Traffic**

**Using Command Line:**

1. Use `netstat` to monitor network connections:

   ```bash
   netstat -an | find "445"
   ```

**Using GUI:**

1. Open Resource Monitor:
   - Press `Windows + R`, type `resmon`, and press Enter.
2. Navigate to the *Network* tab.
3. Look for connections on port 445.

#### **7. Restrict SMB Access**

**Using Command Line:**

1. Use `netsh` to create firewall rules to restrict SMB access:

   ```bash
   netsh advfirewall firewall add rule name="Restrict SMB Access" protocol=TCP dir=in localport=445 remoteip=TRUSTED_IP_ADDRESS action=allow
   ```

   Replace `TRUSTED_IP_ADDRESS` with the IP addresses you want to allow.

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules`.
3. Click `New Rule…`.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `445`, then click `Next`.
6. Select *Allow the connection* and click *Next*.
7. Specify the IP addresses or subnets allowed to connect, then click *Next*.
8. Select the profiles (Domain, Private, Public) where this rule should apply, then click *Next*.
9. Name the rule (e.g., "Allow SMB from Trusted IPs") and click *Finish*.

## 3389/tcp: MS-WBT (Microsoft Terminal Services)

### **Securing Port 3389/tcp: MS-WBT (Microsoft Terminal Services)**

#### **1. Restrict RDP Access**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Create firewall rules to restrict RDP access to specific IP addresses:
   - **Allow RDP from Trusted IPs:**

     ```bash
     netsh advfirewall firewall add rule name="Allow RDP from Trusted IP" protocol=TCP dir=in localport=3389 remoteip=TRUSTED_IP_ADDRESS action=allow
     ```

   - **Block RDP from All Other IPs:**

     ```bash
     netsh advfirewall firewall add rule name="Block RDP" protocol=TCP dir=in localport=3389 action=block
     ```

   Replace `TRUSTED_IP_ADDRESS` with the IP addresses you want to allow.

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `3389`, then click `Next`.
6. Select `Allow the connection` and click `Next`.
7. Specify the IP addresses or subnets allowed to connect, then click `Next`.
8. Choose the profiles (Domain, Private, Public) where this rule should apply, then click `Next`.
9. Name the rule (e.g., "Allow RDP from Trusted IPs") and click `Finish`.
10. Create another rule to block RDP access:
    - Follow the same steps but choose `Block the connection` in step 6.
    - Name the rule "Block RDP".

#### **2. Use Network Level Authentication (NLA)**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Ensure NLA is enabled for Remote Desktop:

   ```bash
   reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v "UserAuthentication" /t REG_DWORD /d 1 /f
   ```

**Using GUI:**

1. Press `Windows + R`, type `SystemPropertiesRemote`, and press Enter.
2. Under the *Remote* tab, ensure that *Allow connections only from computers running Remote Desktop with Network Level Authentication (recommended)* is selected.
3. Click *Apply*, then *OK*.

#### **3. Change the Default RDP Port**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Use `regedit` to change the RDP port:

   ```bash
   reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "PortNumber" /t REG_DWORD /d PORT_NUMBER /f
   ```

   Replace `PORT_NUMBER` with a non-standard port number (e.g., `3390`).

**Using GUI:**

1. Press `Windows + R`, type `regedit`, and press Enter to open the Registry Editor.
2. Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`.
3. Double-click on `PortNumber`.
4. Change the base to *Decimal* and set a new port number (e.g., `3390`).
5. Click *OK* and close the Registry Editor.
6. Restart the computer for the changes to take effect.

#### **4. Enable RDP Logging**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Use `regedit` to configure RDP logging:

   ```bash
   reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableRdpLogging" /t REG_DWORD /d 1 /f
   ```

**Using GUI:**

1. Press `Windows + R`, type `regedit`, and press Enter to open the Registry Editor.
2. Navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`.
3. Right-click and select *New > DWORD (32-bit) Value*.
4. Name the new value `EnableRdpLogging` and set its value to `1`.
5. Click *OK* and close the Registry Editor.

#### **5. Use Strong Authentication Methods**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Configure Remote Desktop to use smart card authentication (if applicable):

   ```bash
   reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "RequireSmartCard" /t REG_DWORD /d 1 /f
   ```

**Using GUI:**

1. Press `Windows + R`, type `secpol.msc`, and press Enter to open Local Security Policy.
2. Navigate to *Local Policies* > *Security Options*.
3. Locate *Interactive logon: Require smart card* and set it to *Enabled*.

#### **6. Monitor RDP Access**

**Using Command Line:**

1. Use `netstat` to monitor RDP connections:

   ```bash
   netstat -an | find "3389"
   ```

**Using GUI:**

1. Open Resource Monitor:
   - Press `Windows + R`, type `resmon`, and press Enter.
2. Navigate to the *Network* tab.
3. Look for connections on port 3389 and monitor any unusual activity.

#### **7. Regularly Review and Update System**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Check for updates to ensure your system is up-to-date:

   ```bash
   wuauclt /detectnow
   ```

**Using GUI:**

1. Press `Windows + I` to open Settings.
2. Navigate to *Update & Security*.
3. Click *Check for updates*.

## 5357 + 5985/tcp: HTTP (Microsoft HTTPAPI httpd 2.0, SSDP|UPnP)

### **Securing Ports 5357/tcp and 5985/tcp: HTTP (Microsoft HTTPAPI httpd 2.0, SSDP|UPnP)**

#### **1. Disable UPnP (Port 5357/tcp)**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Disable UPnP services:

   ```bash
   sc config upnphost start= disabled
   net stop upnphost
   ```

**Using GUI:**

1. Press `Windows + R`, type `services.msc`, and press Enter to open Services.
2. Locate the *UPnP Device Host* service.
3. Right-click and select *Properties*.
4. Click *Stop* to stop the service.
5. Set the *Startup type* to *Disabled* and click *OK*.

#### **2. Configure Windows Firewall for Port 5357/tcp**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Block incoming traffic on port 5357:

   ```bash
   netsh advfirewall firewall add rule name="Block UPnP" protocol=TCP dir=in localport=5357 action=block
   ```

3. Optionally, allow traffic from trusted IPs (if needed):

   ```bash
   netsh advfirewall firewall add rule name="Allow UPnP from Trusted IP" protocol=TCP dir=in localport=5357 remoteip=TRUSTED_IP_ADDRESS action=allow
   ```

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `5357`, then click `Next`.
6. Select "Block the connection" and click `Next`.
7. Choose the profiles where this rule should apply (Domain, Private, Public), then click `Next`.
8. Name the rule (e.g., "Block UPnP") and click `Finish`.
9. Create another rule to allow traffic from trusted IPs (if needed):
   - Follow the same steps but choose "Allow the connection" in step 6.
   - Name the rule "Allow UPnP from Trusted IPs".

#### **3. Disable WinRM (Port 5985/tcp)**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Disable the WinRM service:

   ```bash
   sc config winrm start= disabled
   net stop winrm
   ```

**Using PowerShell:**

1. Open PowerShell as Administrator.
2. Run the following command to disable WinRM:

   ```powershell
   Disable-PSRemoting -Confirm:$false
   ```

**Using GUI:**

1. Press `Windows + R`, type `services.msc`, and press Enter to open Services.
2. Locate the *Windows Remote Management (WS-Management)* service.
3. Right-click and select *Properties*.
4. Click *Stop* to stop the service.
5. Set the *Startup type* to *Disabled* and click *OK*.

#### **4. Configure Windows Firewall for Port 5985/tcp**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Block incoming traffic on port 5985:

   ```bash
   netsh advfirewall firewall add rule name="Block WinRM" protocol=TCP dir=in localport=5985 action=block
   ```

3. Optionally, allow traffic from trusted IPs (if needed):

   ```bash
   netsh advfirewall firewall add rule name="Allow WinRM from Trusted IP" protocol=TCP dir=in localport=5985 remoteip=TRUSTED_IP_ADDRESS action=allow
   ```

**Using GUI:**

1. Press `Windows + R`, type `wf.msc`, and press Enter to open Windows Firewall with Advanced Security.
2. Click on `Inbound Rules` on the left pane.
3. Click `New Rule…` on the right pane.
4. Select `Port`, then click `Next`.
5. Choose `TCP` and specify port `5985`, then click `Next`.
6. Select "Block the connection" and click `Next`.
7. Choose the profiles where this rule should apply (Domain, Private, Public), then click `Next`.
8. Name the rule (e.g., "Block WinRM") and click `Finish`.
9. Create another rule to allow traffic from trusted IPs (if needed):
   - Follow the same steps but choose "Allow the connection" in step 6.
   - Name the rule "Allow WinRM from Trusted IPs".

#### **5. Configure Security Settings for WinRM**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Configure WinRM security settings to restrict access:

   ```bash
   winrm quickconfig
   ```

**Using PowerShell:**

1. Open PowerShell as Administrator.
2. Configure security settings to limit access to WinRM:

   ```powershell
   Set-Item WSMan:\localhost\Client\TrustedHosts -Value ""
   ```

**Using GUI:**

1. Press `Windows + R`, type `gpedit.msc`, and press Enter to open Group Policy Editor.
2. Navigate to *Computer Configuration* > *Administrative Templates* > *Windows Components* > *Windows Remote Management (WinRM)* > *WinRM Service*.
3. Configure policies related to WinRM access control and authentication as needed.

#### **6. Monitor Network Traffic**

**Using Command Line:**

1. Use `netstat` to monitor connections:

   ```bash
   netstat -an | find "5357"
   netstat -an | find "5985"
   ```

**Using GUI:**

1. Open Resource Monitor:
   - Press `Windows + R`, type `resmon`, and press Enter.
2. Navigate to the *Network* tab.
3. Look for connections on ports 5357 and 5985 and monitor any unusual activity.

#### **7. Regularly Review and Update System**

**Using Command Line:**

1. Open Command Prompt as Administrator.
2. Check for updates to ensure your system is up-to-date:

   ```bash
   wuauclt /detectnow
   ```

**Using GUI:**

1. Press `Windows + I` to open Settings.
2. Navigate to *Update & Security*.
3. Click *Check for updates*.
