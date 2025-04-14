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

**1. Configure Proxmox VE Networking for VLANs**

* **Objective:** Enable the primary network bridge on all Proxmox nodes to handle VLAN tagged traffic.
* **Action:**
    * Navigate to `Datacenter` > `[Node Name]` > `System` > `Network` for **each node** in the cluster (Node 1, Node 2, Node 3).
    * Select the primary bridge connected to the physical network (typically `vmbr0`).
    * Click `Edit`.
    * Check the box **`VLAN aware`**.
    * Click `OK` and apply changes if prompted.
* **Result:** `vmbr0` on all cluster nodes is now capable of handling traffic for multiple VLANs based on tags assigned to VM network interfaces.

**2. Obtain pfSense Installation Media**

* **Objective:** Download the pfSense Community Edition (CE) ISO installer.
* **Action:**
    * Visit the [official pfSense download page](https://www.pfsense.org/download/).
    * Select Architecture: `AMD64 (64-bit)`, Installer: `ISO`.
    * Download the `.iso.gz` file (e.g., `pfSense-CE-X.Y.Z-RELEASE-amd64.iso.gz`).
    * Extract the `.iso` file from the downloaded `.gz` archive (e.g., using 7-Zip). Resolve any file permission errors during extraction by saving the `.iso` to a user-writable location like `Downloads` or `Desktop`.

**3. Upload pfSense ISO to Proxmox**

* **Objective:** Make the pfSense installer ISO available within Proxmox.
* **Action:**
    * In the Proxmox UI, navigate to a storage location enabled for ISO images (e.g., `Datacenter` > `[Node Name]` > `local` > `ISO Images`).
    * Click `Upload`.
    * Select the extracted pfSense `.iso` file.
    * Click `Upload` and wait for completion.

**4. Create the pfSense Virtual Machine Shell**

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

**5. Add Second Network Interface (LAN - VLAN 10)**

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

**6. Install pfSense Operating System**

* **Objective:** Install pfSense onto the VM's virtual disk.
* **Action:**
    * Start the `pfSense-Router` VM.
    * Immediately open the `Console`.
    * Follow the pfSense installer prompts: Accept notices, choose `Install`, select keymap, use `Auto (UFS)` partitioning.
    * Select `No` for manual configuration during installation.
    * Choose `Reboot` when installation completes.
    * **Crucial:** Before the VM fully boots up after rebooting, go to the VM's `Hardware` tab > `CD/DVD Drive` > `Edit` > select **`Do not use any media`**. This prevents booting from the ISO again.

**7. Initial pfSense Configuration (Console)**

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

**8. Access pfSense Web GUI, Complete Wizard, & Configure Lab VLANs**

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
        * **8.8.1. Shutdown pfSense:** Gracefully shut down the `pfSense-Router` VM from the pfSense GUI (`Diagnostics` -> `Halt System`). Wait for it to stop in Proxmox.
        * **8.8.2. Add NICs:** In Proxmox UI, select `pfSense-Router` VM -> `Hardware`.
        * **8.8.3.** Click `Add` -> `Network Device` three times, configuring each as follows:
            * **`net2`**: Bridge `vmbr0`, **VLAN Tag `20`**, Model `VirtIO`.
            * **`net3`**: Bridge `vmbr0`, **VLAN Tag `30`**, Model `VirtIO`.
            * **`net4`**: Bridge `vmbr0`, **VLAN Tag `99`**, Model `VirtIO`.
        * **8.8.4. Start pfSense:** Start the `pfSense-Router` VM again.

    * **8.9. Assign New Interfaces (in pfSense Web GUI):**
        * **8.9.1. Login:** Log back into the pfSense Web GUI at `https://10.10.10.1` (using your new admin password).
        * **8.9.2. Navigate:** Go to `Interfaces` -> `Assignments`.
        * **8.9.3. Add Interfaces:** Under "Available network ports", locate `vtnet2`, `vtnet3`, `vtnet4`.
            * Click `+ Add` next to `vtnet2` (becomes `OPT1`).
            * Click `+ Add` next to `vtnet3` (becomes `OPT2`).
            * Click `+ Add` next to `vtnet4` (becomes `OPT3`).
        * **8.9.4. Save:** Click `Save`.

    * **8.10. Configure Interface IP Addresses & Settings:**
        * **8.10.1. Configure OPT1 (UsersVLAN):**
            * Navigate to `Interfaces` -> `[OPT1]`.
            * Check **`Enable interface`**.
            * `Description`: `UsersVLAN`.
            * `IPv4 Configuration Type`: `Static IPv4`.
            * `IPv4 Address`: `10.10.20.1`, select `/24`.
            * Click `Save`.
        * **8.10.2. Configure OPT2 (ServersVLAN):**
            * Navigate to `Interfaces` -> `[OPT2]`.
            * Check **`Enable interface`**.
            * `Description`: `ServersVLAN`.
            * `IPv4 Configuration Type`: `Static IPv4`.
            * `IPv4 Address`: `10.10.30.1`, select `/24`.
            * Click `Save`.
        * **8.10.3. Configure OPT3 (AttackerVLAN):**
            * Navigate to `Interfaces` -> `[OPT3]`.
            * Check **`Enable interface`**.
            * `Description`: `AttackerVLAN`.
            * `IPv4 Configuration Type`: `Static IPv4`.
            * `IPv4 Address`: `10.10.99.1`, select `/24`.
            * Click `Save`.
        * **8.10.4. Apply Changes:** Click the **`Apply Changes`** button at the top of the page.

    * **8.11. Configure DHCP Servers for New VLANs:**
        * **8.11.1. Navigate:** Go to `Services` -> `DHCP Server`.
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

    * **8.12. Add Basic Firewall Rules for Lab Traffic:**
        * **8.12.1. Navigate:** Go to `Firewall` -> `Rules`.
        * **8.12.2. Add Rule for UsersVLAN:**
            * Select **`UsersVLAN`** tab. Click `+ Add` (up arrow).
            * `Action`: `Pass`, `Interface`: `UsersVLAN`, `Address Family`: `IPv4`, `Protocol`: `Any`, `Source`: `UsersVLAN net`, `Destination`: `any`, `Description`: `Allow Users VLAN Outbound`. Click `Save`.
        * **8.12.3. Add Rule for ServersVLAN:**
            * Select **`ServersVLAN`** tab. Click `+ Add` (up arrow).
            * `Action`: `Pass`, `Interface`: `ServersVLAN`, `Address Family`: `IPv4`, `Protocol`: `Any`, `Source`: `ServersVLAN net`, `Destination`: `any`, `Description`: `Allow Servers VLAN Outbound`. Click `Save`.
        * **8.12.4. Add Rule for AttackerVLAN:**
            * Select **`AttackerVLAN`** tab. Click `+ Add` (up arrow).
            * `Action`: `Pass`, `Interface`: `AttackerVLAN`, `Address Family`: `IPv4`, `Protocol`: `Any`, `Source`: `AttackerVLAN net`, `Destination`: `any`, `Description`: `Allow Attacker VLAN Outbound`. Click `Save`.
        * **8.12.5. Apply Changes:** Click the **`Apply Changes`** button that appears after adding the rules.


