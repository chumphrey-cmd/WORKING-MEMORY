# Proxmox Setup and Configuration

## Useful Commands

Ping Sweep Command Linux:

```bash
for i in {1..254} ;do (ping -c 1 192.168.1.$i | grep "bytes from" &) ;done
```

Ping Sweep Windows:

```PowerShell
for /L %i in (1,1,255) do @ping -n 1 -w 200 192.168.1.%i > nul && echo 192.168.1.%i is up.
```

## Troubleshooting Steps for Proxmox Network Configuration

### Network/Hardware Settings

Router: 192.168.1.1
Hostname: pve-node#.lab.home
Laptop: 192.168.1.200
Dell OptiPlex 1: 192.168.1.201
Dell OptiPlex 2: 192.168.1.202

### 1. Verify Network Interfaces

- Check the status of network interfaces:

  ```bash
  ip link show
  ```

- Identify your Ethernet interface (likely named `enx5c...`).

### 2. Check Bridge Configuration

- Check the status of the bridge interface:

  ```bash
  brctl show vmbr0
  ```

- Confirm that no physical interfaces were attached initially.

### 3. Add Physical Interface to Bridge

- Add the Ethernet interface to the bridge:

  ```bash
  sudo brctl addif vmbr0 enx5c...
  ```

- Verify the change:

  ```bash
  brctl show vmbr0
  ```

### 4. Bring Up Interfaces

- Bring up the Ethernet interface:

  ```bash
  sudo ip link set enx5c... up
  ```

- Bring up the bridge interface:

  ```bash
  sudo ip link set vmbr0 up
  ```

### 5. Verify IP Configuration

- Check the IP configuration of the bridge:

  ```bash
  ip addr show vmbr0
  ```

- If necessary, assign a static IP address:

  ```bash
  sudo ip addr add 192.168.1.100/24 dev vmbr0
  ```

### 6. Set Default Gateway

- Ensure there's a default route to your gateway:

  ```bash
  sudo ip route add default via 192.168.1.1
  ```

### 7. Update Network Configuration File

- Edit the `/etc/network/interfaces` file:

  ```bash
  sudo nano /etc/network/interfaces
  ```

- Ensure the configuration for `vmbr0` looks like this:

  ```plaintext
  auto vmbr0
  iface vmbr0 inet static
      address 192.168.1.100/24
      gateway 192.168.1.1
      bridge_ports enx5c...
      bridge_stp off
      bridge_fd 0
  ```

### 8. Remove Unwanted Bridge Ports

- If `wlo1` (WiFi interface) was attached to the bridge, remove it:

  ```bash
  sudo brctl delif vmbr0 wlo1
  ```

### 9. Restart Networking

- Restart the networking service to apply changes:

  ```bash
  sudo systemctl status systemd-networkd.service
  ```

### 10. Verify Connectivity

- Check if you can ping your gateway:

  ```bash
  ping -c 4 192.168.1.1
  ```

### 11. Access Proxmox Web Interface

- Open a web browser and navigate to:
  - https://[your_proxmox_ip]:8006


# Network Setup and Organization

## Phase 1: Lab Design & Architecture

| Device              | ISO                                               | Purpose                                       | VLAN             | VLAN ID | CPU Cores | RAM (GB) | Storage (GB) | Notes                                                                                                                                                 |
| :------------------ | :------------------------------------------------ | :-------------------------------------------- | :--------------- | :------ | :-------- | :------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **pfSense VM** | pfSense CE (Latest Stable ISO)                    | Firewall, Router, DHCP, DNS for Lab VLANs     | Multiple         | (N/A)   | 2         | 2-4      | 20           | Core network control. Manages inter-VLAN routing & lab internet access via NAT. Assign vNICs to Proxmox bridges/VLANs. Mgmt IFace likely untagged/VLAN 10. |
| **Security Onion VM** | Security Onion 2.4 (Latest ISO)                 | SIEM, NIDS, HIDS, Log Aggregation             | Management       | 10      | 6-8       | 16-32    | 300+         | Central monitoring stack. Resource intensive (adjust as needed). Install as "Standalone". Needs fast storage. Resides on secure Management VLAN.        |
| **Windows Server DC** | Windows Server 2022 Standard Eval (180-day ISO) | Active Directory Domain Controller            | Servers          | 30      | 2-4       | 4-6      | 80           | Primary target for AD security monitoring. Requires Eval ISO. Needs AD DS role configuration post-install.                                              |
| **Windows Client 1**| Windows 10/11 Enterprise Eval (90-day ISO)      | User Workstation Target 1                     | User Endpoints   | 20      | 2-4       | 4-8      | 80           | Simulates Win endpoint. Target for Sysmon, agent (Wazuh/Beat). Requires Eval ISO. Will be domain-joined.                                              |
| **Windows Client 2**| Windows 10/11 Enterprise Eval (90-day ISO)      | User Workstation Target 2                     | User Endpoints   | 20      | 2-4       | 4-8      | 80           | Second user endpoint for diverse testing/simulation. Eval ISO. Will be domain-joined.                                                               |
| **Linux Server 1** | Ubuntu Server 22.04 LTS or Debian 12 (ISO)      | Linux Target Server (Web, DB, etc.)           | Servers          | 30      | 2         | 4        | 50           | Target for Linux host monitoring (Auditd, Osquery) & server attacks. Can host vulnerable apps later.                                                |
| **Attacker VM** | Kali Linux or Parrot Security OS (Latest ISO)     | Offensive Operations / Testing Detections     | Attacker         | 99      | 2-4       | 4-8      | 60           | Used to simulate attacks against lab targets. Kept isolated on its own VLAN.                                                                        |
| **Proxmox Node(s)** | N/A (Hypervisor Host)                             | Virtualization Platform                       | Host Management  | 10   | (Host)    | (Host)   | (Host)       | Underlying hypervisor.       |

**VLAN Quick Ref:**
* **VLAN 10 (Management):** `10.10.10.0/24`
* **VLAN 20 (User Endpoints):** `10.10.20.0/24`
* **VLAN 30 (Servers):** `10.10.30.0/24`
* **VLAN 99 (Attacker):** `10.10.99.0/24`

## Phase 2: Core Infrastructure Setup - pfSense Router & Network Foundation

### 1. Configure Proxmox VE Networking for VLANs

* **Objective:** Enable the primary network bridge on all Proxmox nodes to handle VLAN tagged traffic.
* **Action:**
    * Navigate to `Datacenter` > `[Node Name]` > `System` > `Network` for **each node** in the cluster (Node 1, Node 2, Node 3).
    * Select the primary bridge connected to the physical network (typically `vmbr0`).
    * Click `Edit`.
    * Check the box **`VLAN aware`**.
    * Click `OK` and apply changes if prompted.
* **Result:** `vmbr0` on all cluster nodes is now capable of handling traffic for multiple VLANs based on tags assigned to VM network interfaces.

### 2. Obtain pfSense Installation Media

* **Objective:** Download the pfSense Community Edition (CE) ISO installer.
* **Action:**
    * Visit the [official pfSense download page](https://www.pfsense.org/download/).
    * Select Architecture: `AMD64 (64-bit)`, Installer: `ISO`.
    * Download the `.iso.gz` file (e.g., `pfSense-CE-X.Y.Z-RELEASE-amd64.iso.gz`).
    * Extract the `.iso` file from the downloaded `.gz` archive (e.g., using 7-Zip). Resolve any file permission errors during extraction by saving the `.iso` to a user-writable location like `Downloads` or `Desktop`.

### 3. Upload pfSense ISO to Proxmox

* **Objective:** Make the pfSense installer ISO available within Proxmox.
* **Action:**
    * In the Proxmox UI, navigate to a storage location enabled for ISO images (e.g., `Datacenter` > `[Node Name]` > `local` > `ISO Images`).
    * Click `Upload`.
    * Select the extracted pfSense `.iso` file.
    * Click `Upload` and wait for completion.

### 4. Create the pfSense Virtual Machine Shell

* **Objective:** Create the VM entry in Proxmox with the correct hardware specifications *before* installation.
* **Action:**
    * Click **`Create VM`**.
    * **General Tab:**
        * Assign a `Name` (e.g., `pfSense-Router`).
        * Accept the default suggested `VM ID` (e.g., `100`).
    * **OS Tab:**
        * Select the uploaded pfSense `.iso` file.
        * Guest OS `Type`: `Other`.
    * **System Tab:**
        * `SCSI Controller`: `VirtIO SCSI single`.
        * Enable `Qemu Agent`.
    * **Disks Tab:**
        * `Bus/Device`: `SCSI`, Unit Number `0`.
        * `Storage`: Select your NVMe storage.
        * `Disk size (GiB)`: `20`.
    * **CPU Tab:**
        * `Sockets`: `1`.
        * `Cores`: `2`.
        * `Type`: `host` (recommended).
    * **Memory Tab:**
        * `Memory (MiB)`: `4096` (4 GiB).
        * Uncheck `Ballooning Device` (recommended for pfSense).
    * **Network Tab (WAN Interface Only):**
        * `Bridge`: `vmbr0`.
        * `VLAN Tag`: **LEAVE BLANK**.
        * `Model`: `VirtIO (paravirtualized)`.
        * `Firewall`: Unchecked.
    * **Confirm Tab:** Review and click `Finish`.

### 5. Add Second Network Interface (LAN - VLAN 10)

* **Objective:** Add the necessary LAN interface to the VM *after* creation but *before* first boot.
* **Action (Workflow Modification):**
    * Select the newly created `pfSense-Router` VM (ensure it's powered off).
    * Go to the `Hardware` tab.
    * Click `Add` > `Network Device`.
    * Configure the second interface (`net1`):
        * `Bridge`: `vmbr0`.
        * `VLAN Tag`: `10`.
        * `Model`: `VirtIO (paravirtualized)`.
        * `Firewall`: Unchecked.
    * Click `Add`.
* **Result:** The VM now has `net0` (WAN) and `net1` (LAN/VLAN 10) network interfaces configured.

### 6. Install pfSense Operating System

* **Objective:** Install pfSense onto the VM's virtual disk.
* **Action:**
    * Start the `pfSense-Router` VM.
    * Immediately open the `Console`.
    * Follow the pfSense installer prompts: Accept notices, choose `Install`, select keymap, use `Auto (UFS)` partitioning.
    * Select `No` for manual configuration during installation.
    * Choose `Reboot` when installation completes.
    * **Crucial:** Before the VM fully boots up after rebooting, go to the VM's `Hardware` tab > `CD/DVD Drive` > `Edit` > select **`Do not use any media`**. This prevents booting from the ISO again.

### 7. Initial pfSense Configuration (Console)

* **Objective:** Assign network interfaces and configure the LAN IP address for web GUI access.
* **Action (After rebooting into installed pfSense):**
    * Follow console prompts for **interface assignment** (Option `1`):
        * Assign the Proxmox NIC corresponding to `net0` (untagged on vmbr0) to the **`WAN`** role.
        * Assign the Proxmox NIC corresponding to `net1` (VLAN 10 on vmbr0) to the **`LAN`** role.
    * Use console menu option `2` (**Set interface(s) IP address**):
        * Select the `LAN` interface.
        * Set IPv4 address: `10.10.10.1`
        * Set subnet bit count: `24`
        * Gateway: Press Enter (none for LAN).
        * IPv6: `n` (for now).
        * Enable DHCP server on LAN: `y`.
        * Set DHCP start range: `10.10.10.100` (example).
        * Set DHCP end range: `10.10.10.200` (example).
        * Revert to HTTP: `n` (keep HTTPS).

### 8. Access pfSense Web GUI, Complete Wizard, & Configure Lab VLANs

* **Objective:** Use a temporary VM to access the pfSense web interface, complete the initial setup wizard, and then configure the necessary interfaces, DHCP services, and firewall rules for all internal lab VLANs (10, 20, 30, 99).

* **Action:**

    * **8.1. Obtain Linux Desktop ISO:**
        * Download an ISO for a lightweight Linux distribution (e.g., Lubuntu, Xubuntu, Linux Mint XFCE).
        * Links: Lubuntu ([https://lubuntu.me/downloads/](https://lubuntu.me/downloads/)), Xubuntu ([https://xubuntu.org/download/](https://xubuntu.org/download/)), Linux Mint ([https://linuxmint.com/download.php](https://linuxmint.com/download.php)).

    * **8.2. Upload ISO to Proxmox:**
        * Upload the downloaded Linux Desktop ISO file to Proxmox ISO storage.

    * **8.3. Create Temporary Test VM:**
        * In Proxmox, click **`Create VM`**.
        * **General:** Name (e.g., `Temp-WebUI-Access`), VM ID.
        * **OS:** Select Linux ISO, Type `Linux`.
        * **System:** Defaults okay, Enable `Qemu Agent`, Controller `VirtIO SCSI single`.
        * **Disks:** SCSI 0, Storage, Size `15-20` GB.
        * **CPU:** Cores `1-2`.
        * **Memory:** `1024-2048` MiB.
        * **Network:** Bridge `vmbr0`, **VLAN Tag `10`**, Model `VirtIO`.
        * **Confirm:** Review and `Finish`.

    * **8.4. Boot Test VM & Verify Network:**
        * Start the `Temp-WebUI-Access` VM.
        * Open `Console`.
        * Boot the "Live" or "Try" environment from the ISO.
        * Verify it receives a `10.10.10.X` IP address via DHCP from pfSense (use `ip addr show` in terminal if needed).

    * **8.5. Access pfSense Web GUI:**
        * Open the web browser **inside the Test VM**.
        * Navigate to **`https://10.10.10.1`**.
        * Accept the certificate warning.

    * **8.6. Log In:**
        * Username: `admin`
        * Password: `pfsense`

    * **8.7. Complete Initial Setup Wizard:**
        * Follow the wizard steps.
        * Set `Hostname` (e.g., `pfsense`), `Domain` (e.g., `lab.local`).
        * Configure `DNS Servers` (e.g., `0.us.pool.ntp.org`, `1.us.pool.ntp.org`).
        * Set `Timezone` (`Pacific/Honolulu` or equivalent).
        * Verify WAN (DHCP) and LAN (`10.10.10.1/24`) settings.
        * **CRITICAL:** Set a new, strong **`Admin Password`**.
        * Click `Reload` to finish the wizard. You should land on the pfSense Dashboard.

    * **8.8. Add Virtual Network Interfaces to pfSense VM (in Proxmox):**
        * **8.8.1. Shutdown pfSense:** Gracefully shut down the `pfSense-Router` VM from the pfSense GUI (`Diagnostics` > `Halt System`). Wait for it to stop in Proxmox.
        * **8.8.2. Add NICs:** In Proxmox UI, select `pfSense-Router` VM > `Hardware`.
        * **8.8.3.** Click `Add` > `Network Device` three times, configuring each as follows:
            * **`net2`**: Bridge `vmbr0`, **VLAN Tag `20`**, Model `VirtIO`.
            * **`net3`**: Bridge `vmbr0`, **VLAN Tag `30`**, Model `VirtIO`.
            * **`net4`**: Bridge `vmbr0`, **VLAN Tag `99`**, Model `VirtIO`.
        * **8.8.4. Start pfSense:** Start the `pfSense-Router` VM again.

    * **8.9. Assign New Interfaces (in pfSense Web GUI):**
        * **8.9.1. Login:** Log back into the pfSense Web GUI at `https://10.10.10.1` (using your new admin password).
        * **8.9.2. Navigate:** Go to `Interfaces` > `Assignments`.
        * **8.9.3. Add Interfaces:** Under "Available network ports", locate `vtnet2`, `vtnet3`, `vtnet4`.
            * Click `+ Add` next to `vtnet2` (becomes `OPT1`).
            * Click `+ Add` next to `vtnet3` (becomes `OPT2`).
            * Click `+ Add` next to `vtnet4` (becomes `OPT3`).
        * **8.9.4. Save:** Click `Save`.

    * **8.10. Configure Interface IP Addresses & Settings:**
        * **8.10.1. Configure OPT1 (UsersVLAN):**
            * Navigate to `Interfaces` > `[OPT1]`.
            * Check **`Enable interface`**.
            * `Description`: `UsersVLAN`.
            * `IPv4 Configuration Type`: `Static IPv4`.
            * `IPv4 Address`: `10.10.20.1`, select `/24`.
            * Click `Save`.
        * **8.10.2. Configure OPT2 (ServersVLAN):**
            * Navigate to `Interfaces` > `[OPT2]`.
            * Check **`Enable interface`**.
            * `Description`: `ServersVLAN`.
            * `IPv4 Configuration Type`: `Static IPv4`.
            * `IPv4 Address`: `10.10.30.1`, select `/24`.
            * Click `Save`.
        * **8.10.3. Configure OPT3 (AttackerVLAN):**
            * Navigate to `Interfaces` > `[OPT3]`.
            * Check **`Enable interface`**.
            * `Description`: `AttackerVLAN`.
            * `IPv4 Configuration Type`: `Static IPv4`.
            * `IPv4 Address`: `10.10.99.1`, select `/24`.
            * Click `Save`.
        * **8.10.4. Apply Changes:** Click the **`Apply Changes`** button at the top of the page.

    * **8.11. Configure DHCP Servers for New VLANs:**
        * **8.11.1. Navigate:** Go to `Services` > `DHCP Server`.
        * **8.11.2. Configure DHCP for UsersVLAN:**
            * Select the **`UsersVLAN`** tab.
            * Check **`Enable DHCP server...`**.
            * `Range`: From `10.10.20.100` To `10.10.20.200`.
            * `DNS Servers`: `10.10.30.10` (Primary), `1.1.1.1` (Secondary - optional).
            * Click `Save`.
        * **8.11.3. Configure DHCP for ServersVLAN:**
            * Select the **`ServersVLAN`** tab.
            * Check **`Enable DHCP server...`**.
            * `Range`: From `10.10.30.100` To `10.10.30.200`.
            * `DNS Servers`: `10.10.30.10` (Primary), `1.1.1.1` (Secondary - optional).
            * Click `Save`.
        * **8.11.4. Configure DHCP for AttackerVLAN:**
            * Select the **`AttackerVLAN`** tab.
            * Check **`Enable DHCP server...`**.
            * `Range`: From `10.10.99.100` To `10.10.99.200`.
            * `DNS Servers`: `10.10.10.1` or `1.1.1.1`.
            * Click `Save`.

    * **8.12. Add Firewall Rules for Lab Traffic (with MGMT Isolation):**
        * **8.12.1. Navigate:** Go to `Firewall` > `Rules`.

        * **8.12.2. Check/Add LAN Outbound Rule:**
            * Select the **`LAN`** tab.
            * **Verify** a default rule exists allowing traffic *from* `Source: LAN net` to `Destination: any`. (pfSense often adds a "Default allow LAN to any rule").
            * If no such rule exists, click `+ Add` (down arrow is fine here) and create it:
                * `Action`: `Pass`, `Interface`: `LAN`, `Address Family`: `IPv4`, `Protocol`: `Any`, `Source`: `LAN net`, `Destination`: `any`, `Description`: `Allow LAN Outbound (Default)`. Click `Save`.
            * *(This ensures your management segment can reach other networks).*

        * **8.12.3. Add Rules for UsersVLAN:**
            * Select the **`UsersVLAN`** tab.
            * **Add BLOCK Rule (TOP):** Click `+ Add` (using the **UP arrow** to add to the **TOP**).
                * `Action`: **`Block`**
                * `Interface`: `UsersVLAN`
                * `Address Family`: `IPv4`
                * `Protocol`: `Any`
                * `Source`: `UsersVLAN net`
                * `Destination`: `LAN net`
                * `Description`: `Block access to MGMT net`
            * Click `Save`.
            * **Add PASS Rule (Below Block):** Click `+ Add` (using the **DOWN arrow** to add below the block rule).
                * `Action`: `Pass`
                * `Interface`: `UsersVLAN`
                * `Address Family`: `IPv4`
                * `Protocol`: `Any`
                * `Source`: **`UsersVLAN net`** *(Use the subnet, not the address)*
                * `Destination`: `any`
                * `Description`: `Allow Users VLAN Outbound`
            * Click `Save`. *(Ensure Block rule is listed above the Pass rule).*

        * **8.12.4. Add Rules for ServersVLAN:**
            * Select the **`ServersVLAN`** tab.
            * **Add BLOCK Rule (TOP):** Click `+ Add` (UP arrow).
                * `Action`: **`Block`**
                * `Interface`: `ServersVLAN`
                * `Address Family`: `IPv4`
                * `Protocol`: `Any`
                * `Source`: `ServersVLAN net`
                * `Destination`: `LAN net`
                * `Description`: `Block access to MGMT net`
            * Click `Save`.
            * **Add PASS Rule (Below Block):** Click `+ Add` (DOWN arrow).
                * `Action`: `Pass`
                * `Interface`: `ServersVLAN`
                * `Address Family`: `IPv4`
                * `Protocol`: `Any`
                * `Source`: **`ServersVLAN net`**
                * `Destination`: `any`
                * `Description`: `Allow Servers VLAN Outbound`
            * Click `Save`. *(Ensure Block rule is listed above the Pass rule).*

        * **8.12.5. Add Rules for AttackerVLAN:**
            * Select the **`AttackerVLAN`** tab.
            * **Add BLOCK Rule (TOP):** Click `+ Add` (UP arrow).
                * `Action`: **`Block`**
                * `Interface`: `AttackerVLAN`
                * `Address Family`: `IPv4`
                * `Protocol`: `Any`
                * `Source`: `AttackerVLAN net`
                * `Destination`: `LAN net`
                * `Description`: `Block access to MGMT net`
            * Click `Save`.
            * **Add PASS Rule (Below Block):** Click `+ Add` (DOWN arrow).
                * `Action`: `Pass`
                * `Interface`: `AttackerVLAN`
                * `Address Family`: `IPv4`
                * `Protocol`: `Any`
                * `Source`: **`AttackerVLAN net`**
                * `Destination`: `any`
                * `Description`: `Allow Attacker VLAN Outbound`
            * Click `Save`. *(Ensure Block rule is listed above the Pass rule).*

        * **8.12.6. Apply Changes:** After adding/modifying rules on all relevant tabs, click the **`Apply Changes`** button that appears at the top of the page.


## Phase 3: VM Selection & Initial Build

### 3.1. Build the Windows Server Domain Controller (DC)

* **Objective:** Install and configure the base Windows Server 2022 operating system, preparing it for promotion to a Domain Controller. This VM will reside on VLAN 30 (ServersVLAN).

* **Actions:**

* **3.1.1. Obtain Windows Server 2022 Evaluation ISO:**
  * Download the **Windows Server 2022 Standard (or Datacenter) Evaluation ISO** (180-day trial) from the Microsoft Evaluation Center.
  * **Link:** [https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022)
  * Select the **ISO download** option.
  * Upload the downloaded `.iso` file to your Proxmox ISO storage (`Datacenter` > `[Node Name]` > `[Storage Name]` > `ISO Images` > `Upload`).

* **3.1.2. Obtain VirtIO Drivers ISO:**
  * **Check Proxmox Storage:** First, check your Proxmox ISO storage (`Datacenter` > `[Node Name]` > `[Storage Name]` > `ISO Images`) for an existing file named `virtio-win-*.iso`.
  * **Download if Missing:** As confirmed it wasn't present, download the drivers from the official Fedora Project repository:
      * **Link:** [https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/)
      * Navigate into the directory for the **latest stable** version (e.g., highest version number not marked as "latest").
      * Download the file ending in **`.iso`**.
  * **Upload to Proxmox:** Upload the downloaded `virtio-win-*.iso` file to your Proxmox ISO storage.

* **3.1.3. Create DC Virtual Machine in Proxmox:**
  * Click **`Create VM`**.
  * **General Tab:**
      * `Name`: `WinDC` (or `LAB-DC01`)
      * `VM ID`: Accept default suggested ID.
  * **OS Tab:**
      * Select the uploaded **Windows Server 2022 ISO**. *(This will be mounted on the first CD/DVD drive, e.g., `ide0` or `ide2`)*.
      * `Type`: `Microsoft Windows`
      * `Version`: `11/2022`
  * **System Tab:**
      * `Graphic card`: Default
      * `SCSI Controller`: `VirtIO SCSI single`
      * **Check** `Qemu Agent`
  * **Disks Tab:**
      * `Bus/Device`: `SCSI`, Unit `0`
      * `Storage`: Select NVMe storage.
      * `Disk size (GiB)`: `80`
      * `Cache`: Default (`No cache`)
      * **Check** `Discard`
      * **Check** `IO thread`
  * **CPU Tab:**
      * `Sockets`: `1`
      * `Cores`: `2`
  * **Memory Tab:**
      * `Memory (MiB)`: `4096`
      * **Uncheck** `Ballooning Device`
  * **Network Tab:**
      * `Bridge`: `vmbr0`
      * `VLAN Tag`: **`30`** *(Connects to ServersVLAN)*
      * `Model`: `VirtIO (paravirtualized)`
      * `Firewall`: Unchecked
  * **Confirm Tab:** Review and click `Finish`.
  * **Add VirtIO CD Drive:** After VM creation (or during, if possible), ensure the VM has a **second CD/DVD drive**. Go to VM > `Hardware` > `Add` > `CD/DVD Drive`. Mount the **`virtio-win-*.iso`** file on this second drive (e.g., `ide1` or `sata0`).

* **3.1.4. Install Windows Server 2022 OS (Loading Drivers):**
  * Start the `WinDC` VM and open the `Console`.
  * Boot from the Windows Server installation ISO.
  * Follow Windows Setup: Language, Time, Keyboard > `Install now` > Click `I don't have a product key` > Select OS Version `(Desktop Experience)` > Accept terms > Choose **`Custom: Install Microsoft Server Operating System only (advanced)`**.
  * **Load Storage Driver:** At the "Where do you want to install Windows?" screen (which shows no drives):
      * Click **`Load driver`**.
      * Click `Browse`.
      * Navigate to the CD drive containing the **VirtIO drivers ISO**.
      * Browse to the **`vioscsi\2k22\amd64`** folder (or `viostor` equivalent if using that driver path).
      * Click `OK`.
      * Select the "Red Hat VirtIO SCSI pass-through controller" driver. Click `Next`.
  * **Select Disk:** The 80GB virtual disk (`Drive 0 Unallocated Space`) should now appear. Select it.
  * Click `Next` to begin the installation. Wait for completion and automatic reboots.

* **3.1.5. Initial Windows Login:**
  * After installation, set the password for the built-in `Administrator` account.
  * Log in as `Administrator`.

* **3.1.6. Perform Essential Post-Installation Tasks:**
  * **Install Remaining VirtIO Drivers & Agent:**
      * Ensure the **`virtio-win-*.iso`** is still mounted in the second CD/DVD drive (check VM > `Hardware` > `CD/DVD Drive`).
      * Inside the Windows VM: Open File Explorer, browse the VirtIO CD drive. Run **`virtio-win-gt-x64.msi`** (or `virtio-win-guest-tools.exe`). Accept defaults to install all remaining drivers and guest services (Network adapter, Ballooning, QEMU Guest Agent).
      * **Reboot** the VM when installation is complete.
  * **Verify Network (DHCP):**
      * After reboot, log in. Open Command Prompt (`cmd`). Run `ipconfig /all`.
      * Verify IPv4 Address is `10.10.30.x`, Gateway is `10.10.30.1`, DNS is `10.10.30.10`.
  * **Set Static IP Address (Initial):**
      * Open `Control Panel` > `Network and Sharing Center` > `Change adapter settings`.
      * Right-click Ethernet adapter > `Properties` > `Internet Protocol Version 4 (TCP/IPv4)` > `Properties`.
      * Select `Use the following IP address`:
          * IP address: **`10.10.30.10`**
          * Subnet mask: **`255.255.255.0`**
          * Default gateway: **`10.10.30.1`**
          * Preferred DNS server: **`10.10.10.1`** *(Temporary - pointing to pfSense for updates)*
          * Alternate DNS server: `1.1.1.1` *(Optional)*
      * Click `OK` > `Close`.
  * **Rename Computer:**
      * Open `Server Manager` > `Local Server` > Click Computer name > `Change...`.
      * New name: `LAB-DC01`. Click `OK` > `OK` > `Close`. **Reboot Now**.
  * **Windows Updates:**
      * After reboot, log in. Verify internet access (e.g., `ping 8.8.8.8`, `nslookup www.google.com`).
      * Go to `Settings` > `Update & Security` > `Windows Update`. **Check for and install all available updates.** This may require multiple reboots. Continue until it reports "You're up to date".
  * **Time Sync Check:** Verify system time is accurate.
  * **Set Final DNS Configuration:**
      * **AFTER** all updates are complete, go back to the IPv4 Properties for the Ethernet adapter.
      * Change the **`Preferred DNS server`** back to **`127.0.0.1`**.
      * Leave `Alternate DNS server` as `10.10.10.1` or clear it.
      * Click `OK` > `Close`.

* **3.1.7. Install AD DS Role & Promote to Domain Controller:**
  * **Objective:** Install Active Directory Domain Services and configure the server as the first Domain Controller in a new forest (`lab.local`).
  * **3.1.7.1. Add AD DS Role:**
      * Open **Server Manager**.
      * `Manage` > `Add Roles and Features`.
      * `Next` (Before You Begin).
      * Select `Role-based or feature-based installation`. `Next`.
      * Select local server (`LAB-DC01`). `Next`.
      * Check box for **`Active Directory Domain Services`**.
      * Click **`Add Features`** on the pop-up window.
      * Click `Next` through Server Roles.
      * Click `Next` through Features.
      * Click `Next` through AD DS information page.
      * Click **`Install`** on Confirmation page (optionally check restart).
      * Wait for installation, then click `Close`.
  * **3.1.7.2. Promote Server to Domain Controller:**
      * In Server Manager, click the notification flag (yellow triangle) > Click **`Promote this server to a domain controller`**.
      * **Deployment Configuration:** Select **`Add a new forest`**. `Root domain name`: **`lab.local`**. Click `Next`.
      * **Domain Controller Options:**
          * Leave Forest/Domain functional levels at default (`Windows Server 2016`).
          * Ensure **`Domain Name System (DNS) server`** is **checked**.
          * Ensure **`Global Catalog (GC)`** is **checked**.
          * Enter and confirm a strong **`DSRM password`**. **Document this password.** Click `Next`.
      * **DNS Options:** Ignore the delegation warning. Click `Next`.
      * **Additional Options:** Verify `NetBIOS name` is `LAB`. Click `Next`.
      * **Paths:** Accept default database/log/SYSVOL paths. Click `Next`.
      * **Review Options:** Review selections. Click `Next`.
      * **Prerequisites Check:** Wait for checks. Ignore warnings (unless critical errors appear). Click **`Install`**.
  * **3.1.7.3. Automatic Reboot:** The server will install AD DS and **reboot automatically**.

  * **3.1.7.4. Post-Promotion Verification:**
      * Log in after reboot (use `LAB\Administrator` or `administrator@lab.local` with the original Administrator password).
      * Check Server Manager shows AD DS and DNS roles are present and services appear to be running (green status).
      * Open `Active Directory Users and Computers` (from `Tools` menu in Server Manager or run `dsa.msc`). Verify your domain (e.g., `lab.local`) is listed and you can expand it to see default containers like `Domain Controllers` (which should list `LAB-DC01`).
      * Open `DNS` console (from `Tools` menu or run `dnsmgmt.msc`):
          * Expand your server name (`LAB-DC01`).
          * Expand `Forward Lookup Zones`. Verify that a zone for **`lab.local`** and a sub-zone **`_msdcs.lab.local`** exist.
          * Expand these zones and check for the presence of various records, especially SRV records (e.g., `_ldap`, `_kerberos` under `_tcp` in both `_msdcs.lab.local` and `lab.local`). These indicate service registration.
          * **Ensure pfSense Firewall Allows DC DNS Forwarding Queries:**
              * Log into the pfSense Web GUI (`https://10.10.10.1`).
              * Navigate to `Firewall` -> `Rules` -> `SERVERS_VLAN` tab.
              * Ensure rules are in the following order (top to bottom), adding/editing as necessary:
                  1.  **`Pass`** `IPv4 UDP` from Source `10.10.30.10` (DC IP) to Destination `10.10.10.1` (pfSense LAN_MGMT IP) Destination Port `DNS (53)`. Description: `Allow DC DNS UDP queries to pfSense LAN_MGMT`.
                  2.  **`Pass`** `IPv4 TCP` from Source `10.10.30.10` (DC IP) to Destination `10.10.10.1` (pfSense LAN_MGMT IP) Destination Port `DNS (53)`. Description: `Allow DC DNS TCP to pfSense LAN_MGMT`.
                  3.  **`Block`** `IPv4 *` from Source `SERVERS_VLAN net` to Destination `LAN_MGMT net`. Description: `Block access to MGMT subnet`.
                  4.  **`Pass`** `IPv4 *` from Source `SERVERS_VLAN net` to Destination `any`. Description: `Allow SERVERS_VLAN Outbound`.
              * Click `Save` if changes are made, and then **`Apply Changes`**.
          * **Configure and Verify Forwarders on DC:** Right-click the server name (`LAB-DC01`) in DNS Manager -> `Properties` -> `Forwarders` tab.
              * Click `Edit...`.
              * Add the IP address of your pfSense LAN/Management interface: **`10.10.10.1`**. It should now validate (or at least function for lookups).
              * Add public DNS servers for redundancy: **`1.1.1.1`** (Cloudflare) and **`8.8.8.8`** (Google) on separate lines.
              * Click `OK`, then `Apply`.
      * Open Command Prompt (`cmd`) or PowerShell **as Administrator**:
          * Run `ipconfig /all`. Verify:
              * `Host Name` is `LAB-DC01`.
              * `Primary Dns Suffix` is `lab.local`.
              * `DNS Servers` list should show `127.0.0.1` (and/or `::1`, its own static IP `10.10.30.10`).
          * Run `nltest /dsgetdc:lab.local`. This should return the name `LAB-DC01.lab.local` and its IP address, confirming the DC is discoverable.
          * Run `nslookup lab.local`. This should resolve to `10.10.30.10` (queried against the local DNS server).
          * Run `nslookup www.google.com` (or another external site). This should now resolve successfully using the configured forwarders.
          * Run `dcdiag /v`. This performs a comprehensive health check. Review the output carefully. It's common to see some initial warnings related to DNS delegation or SysVol replication on a brand new, single DC, but most tests should show as "passed". Address any "failed" tests.

### 3.2. Build the First Windows VM (`WinClient01`)

* **Objective:** Install and configure a Windows client operating system, join it to the `lab.local` domain, and prepare it for endpoint monitoring. This VM will reside on VLAN 20 (UsersVLAN).

* **Actions:**

* **3.2.1. Obtain Windows Client ISO:**
    * Download either **Windows 10 Enterprise Evaluation** or **Windows 11 Enterprise Evaluation** ISO (typically 90-day trials). Windows 10 is often still very relevant for corporate environments, but Windows 11 is the latest. Your choice depends on what environment you want to simulate most closely. For general detection engineering, either is fine. Let's assume Windows 10 for these instructions, but Windows 11 is very similar.
    * **Microsoft Evaluation Center:** Search for "Windows 10 Enterprise Evaluation" or "Windows 11 Enterprise Evaluation" on the [Microsoft Evaluation Center](https://www.microsoft.com/en-us/evalcenter/).
    * Select the ISO download option (registration may be required).
    * Upload the downloaded `.iso` file to your Proxmox ISO storage.

* **3.2.2. Create Client Virtual Machine in Proxmox:**
    * Click **`Create VM`**.
    * **General Tab:**
        * `Name`: `WinClient01` (or `LAB-WCLIENT01`)
        * `VM ID`: Accept default suggested ID.
    * **OS Tab:**
        * Select the uploaded Windows 10/11 Enterprise ISO.
        * `Type`: `Microsoft Windows`
        * `Version`: Select appropriate (e.g., `10/2019/2022` or `11/2022`).
    * **System Tab:**
        * `Graphic card`: Default
        * `SCSI Controller`: `VirtIO SCSI single`
        * **Check** `Qemu Agent`
    * **Disks Tab:**
        * `Bus/Device`: `SCSI`, Unit `0`
        * `Storage`: Select NVMe storage.
        * `Disk size (GiB)`: `80` (as per our table, or 60GB is also fine for a client).
        * `Cache`: Default (`No cache`)
        * **Check** `Discard`
        * **Check** `IO thread`
    * **CPU Tab:**
        * `Sockets`: `1`
        * `Cores`: `2`
    * **Memory Tab:**
        * `Memory (MiB)`: `4096` (4 GiB, can reduce to 2048 MiB after setup if needed, but 4GiB is smoother).
        * **Uncheck** `Ballooning Device`
    * **Network Tab:**
        * `Bridge`: `vmbr0`
        * `VLAN Tag`: **`20`** *(Connects to UsersVLAN)*
        * `Model`: `VirtIO (paravirtualized)`
        * `Firewall`: Unchecked
    * **Confirm Tab:** Review and click `Finish`.
    * **Add VirtIO CD Drive:** After VM creation, ensure the VM's CD/DVD drive (`Hardware` -> `CD/DVD Drive`) has the **`virtio-win-*.iso`** file mounted (you can add a second CD/DVD drive for this if you prefer to keep the Windows ISO also attached initially, or swap it after Windows install starts).

* **3.2.3. Install Windows Client OS (Loading Drivers if Necessary):**
    * Start the `WinClient01` VM and open the `Console`.
    * Boot from the Windows installation ISO.
    * Follow Windows Setup: Language, Time, Keyboard -> `Install now`.
    * Product Key: If asked, there's usually an option like "I don't have a product key" for evaluations.
    * Operating System: Select **`Windows 10 Enterprise`** (or `Windows 11 Enterprise`).
    * Accept license terms.
    * Installation Type: **`Custom: Install Windows only (advanced)`**.
    * **Load Storage Driver (If Needed):** If at the "Where do you want to install Windows?" screen no drives are visible (same issue as with the DC):
        * Ensure the `virtio-win-*.iso` is mounted in a CD/DVD drive.
        * Click **`Load driver`**.
        * Click `Browse`.
        * Select the Red Hat VirtIO pass-through controller for Windows 10/11: **`D:\amd64\w[10/11]wioscsi.in`**. 
        * Click `Next`.
    * **Select Disk:** The virtual disk (`Drive 0 Unallocated Space`) should appear. Select it.
    * Click `Next` to begin installation. Wait for completion and reboots.

* **3.2.4. Windows Out-of-Box Experience (OOBE) & Network Bypass:**
    * After the Windows installation files are copied and the VM reboots, you will be guided through the Out-of-Box Experience (OOBE).
    * **Region and Keyboard:** Select your preferred Region and Keyboard layout. You can skip adding a second keyboard layout if prompted.
    * **Network Connection Screen ("Let's connect you to a network"):**
        * At this screen, you will likely see **no networks available**. This is expected because the VirtIO network driver for your VM's network card is not yet installed.
        * To proceed without a network connection at this stage, press **`Shift + F10`** simultaneously (on some laptops, you might need `Shift + Fn + F10`). This will open a Command Prompt window.
        * In the Command Prompt window, type the following command **exactly** as shown and press Enter:
            ```cmd
            OOBE\BYPASSNRO
            ```
        * The virtual machine will automatically reboot after this command is executed.
    * **After Reboot - OOBE Resumes:**
        * The OOBE process will start again. You'll need to re-select your Region and Keyboard layout.
        * When you reach the "Let's connect you to a network" screen *this time*, you should see a new option like **"I don't have internet"**. Select this option.
        * On the following screen, choose **"Continue with limited setup"**.
    * **Account Setup (Creating a Local Account):**
        * You will now be prompted to create a user for the PC. This will be a **local user account** for now.
        * `Who's going to use this PC?`: Enter a username (e.g., `labadmin`). Click `Next`.
        * Create a memorable password for this `labadmin` local user. Click `Next`. Confirm the password.
        * You will likely be prompted to set up security questions for password recovery. Complete this step.
        * Adjust privacy settings on the subsequent screens as you prefer (you can usually accept defaults or turn features off). Click `Accept` to proceed.
    * Windows will then finalize the setup and take you to the desktop, logged in as the local user you just created (e.g., `labadmin`).

* **3.2.5. Perform Essential Post-Installation Tasks:**
    * Log in as the local user you just created (e.g., `labadmin`).
    * **Install VirtIO Drivers:**
        * Mount the **`virtio-win-*.iso`** in the VM's CD/DVD drive via Proxmox UI (if not still mounted).
        * Inside Windows: Open File Explorer, browse the VirtIO CD. Run **`virtio-win-gt-x64.msi`** (or `virtio-win-guest-tools.exe`). Accept defaults to install all drivers (Network, Storage, Balloon, QEMU Guest Agent, etc.).
        * **Reboot** the VM when installation is complete.
    * **Verify Network & Correct DNS Server (if needed):**
        * After reboot (post VirtIO driver install), log in. Open Command Prompt (`cmd`). Run `ipconfig /all`.
        * **Check IP Configuration:** Verify the `IPv4 Address` is in the `10.10.20.x` range (e.g., `10.10.20.100`) and the `Default Gateway` is `10.10.20.1`.
        * **Check DNS Server:** The `DNS Servers` listed *should* be `10.10.30.10` (your Domain Controller's IP), as this was configured in pfSense's DHCP settings for the UsersVLAN.
            * **If DNS Server is incorrect** (e.g., it shows `10.10.20.1` or something else):
                * **Verify/Correct pfSense DHCP Settings for UsersVLAN:**
                    * Log in to your pfSense Web GUI (`https://10.10.10.1`).
                    * Go to `Services` -> `DHCP Server`.
                    * Click on the **`UsersVLAN`** tab.
                    * Scroll down to the **`Servers`** section.
                    * Ensure the **`DNS Servers`** field has `10.10.30.10` as the first (primary) entry. You can add a secondary public DNS like `1.1.1.1` if desired.
                    * If you made any changes, click **`Save`** at the bottom of the pfSense page.
                * **Renew DHCP Lease on `WinClient01`:**
                    * On `WinClient01`, open Command Prompt **as Administrator**.
                    * Type the following commands, pressing Enter after each:
                    ```cmd
                    ipconfig /release
                    ipconfig /renew
                    ```
                    * After the `renew` command completes, run `ipconfig /all` again.
                    * The `DNS Servers` should now correctly show `10.10.30.10`.
    * **Rename Computer:**
        * Go to `Settings` -> `System` -> `About`.
        * Click `Rename this PC`.
        * New name: `WinClient01`. Click `Next`. Reboot when prompted.
    * **Windows Updates:**
        * After reboot, log in as `labadmin`.
        * Go to `Settings` -> `Update & Security` (or just `Windows Update` in Win11).
        * Check for and install all available updates. This may require multiple reboots. Continue until it reports "You're up to date."
    * **Time Sync Check:** Verify the system time is accurate (it should eventually sync with the DC after joining the domain).
    * **Join to Domain:**
        * Go to `Settings` -> `System` -> `About`.
        * Click `Rename this PC (advanced)` or `Domain or workgroup` (the exact wording might vary slightly, look for advanced system properties or computer name/domain change options).
        * In the System Properties window, on the `Computer Name` tab, click `Change...`.
        * Under "Member of", select `Domain:`. Enter **`lab.local`**. Click `OK`.
        * When prompted for credentials, enter the domain administrator credentials:
            * Username: `LAB\Administrator` (or `administrator@lab.local`)
            * Password: The password you set for the `LAB-DC01` Administrator account.
        * Click `OK`. You should see a "Welcome to the lab.local domain." message.
        * Click `OK` to acknowledge, then `Close`, and **Reboot Now**.
    * **Verify Domain Join:**
        * After reboot, at the login screen, you should be able to switch users and log in with a domain account (e.g., `LAB\Administrator`) or your local `labadmin` account.
        * Log in (e.g., as `labadmin` or `LAB\Administrator`).
        * Go to `Settings` -> `System` -> `About`. Verify the `Full device name` is now `LAB-WCLIENT01.lab.local`.