# nmcli Interface Automation Script

This script automates network interface configuration using `nmcli`, primarily for Security Onion Manager and Search VMs that may lose their statically assigned IP addresses (e.g., 10.kit#.101.100, 101, or 102).  Running this script as root on each VM ensures connection re-establishment and IP reassignment.

## Usage

1.  **Set `KIT_NUM`:**  Edit the `configure_interface.sh` script and modify the `KIT_NUM` variable to match the appropriate kit number for the VM.

2.  **Make the script executable:**
    ```bash
    chmod +x configure_interface.sh
    ```

3.  **Run the script as root:**  This script requires root privileges.
    ```bash
    sudo ./configure_interface.sh
    ```

4.  **Interface Selection:** The script will present a menu to select the network interface to configure.

5.  **Configuration:** The script configures the selected interface with the IP address, gateway, DNS servers, and search domain derived from the `KIT_NUM` variable.

## Configuration Variables

*   `KIT_NUM`:  The kit number
*   `INTERFACE`: The network interface to configure (defaults to `eno1`, but a selection menu is provided)
*   `IP_ADDRESS`: The static IP address
*   `GATEWAY`: The default gateway 
*   `DNS1`: The primary DNS server 
*   `DNS2`: The secondary DNS server 
*   `SEARCH_DOMAIN`: The search domain 