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
  sudo systemctl restart networking
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
