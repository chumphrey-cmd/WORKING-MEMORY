# Setup and Configuration

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

### Network Settings

My Home Router: 192.168.1.1
Hostname: pve-node#.lab.home
IP Address (Laptop): 192.168.1.200

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
