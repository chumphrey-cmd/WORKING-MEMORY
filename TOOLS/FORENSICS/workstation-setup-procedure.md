# Memory Forensics Workstation Setup

## 1. Install Proxmox VE (Bare Metal)

- Download Proxmox VE ISO on a machine with internet access.
- Create a bootable USB drive with the ISO (e.g., Rufus, Etcher, Ventoy).
- Boot your server from USB and install Proxmox VE using the installation wizard.

## 2. Initial Airgapped Proxmox Configuration

- Complete local configuration (network, storage) as needed.

### 2.1 Set UTC Time for Proxmox Environment

```bash
# Set system timezone to UTC first
timedatectl set-timezone UTC

# Or use more readable format
date -u -s ""YYYY-MM-DD HH:MM:SS""

# Set hardware clock to UTC and sync
hwclock --systohc --utc

# Verify the change
date -u
timedatectl status
hwclock --show --utc
```

### 2.2 Disable Automatic Time Sync

```bash
# Stop chrony service to prevent conflicts
systemctl stop chronyd
systemctl disable chronyd

# Verify UTC configuration
timedatectl status
```

## 3. Proxmox ZFS RAIDZ1 Storage Setup with LVM Disk Cleanup

### 3.1 Prepare SSDs for ZFS Pool

If any SSD (e.g., `/dev/sda`) has existing LVM partitions or other holders, wipe them first using the commands below. This makes the disk fully available for ZFS:

```bash
# List physical volumes, volume groups, and logical volumes
pvs
vgs
lvs

# Remove logical volumes (replace `nsm/nsm` and `pve/data` with your actual LV names)
lvremove /dev/nsm/nsm
lvremove /dev/pve/data

# Remove remaining volume groups (replace `/dev/sda1` with partition on your disk)
vgremove /dev/sda1 --force --force

# Wipe all filesystem signatures on sda
wipefs -a /dev/sda
```

> **Important:** Confirm `/dev/sda` is not your Proxmox boot disk before wiping.

### 3.2 Create ZFS Pool (RAIDZ1) in Proxmox Web UI

- Log into Proxmox Web GUI.
- Go to **Node > Disks > ZFS**.
- Click **Create: ZFS**, then:
  - Name: `forensics-zpool` (or any name).
  - RAID Level: `RAIDZ`.
  - Disks: Select `/dev/sda`, `/dev/sdb`, `/dev/sdc`.
  - Keep default options (compression=lz4, ashift=12).
- Click **Create**.

### 3.3 Add ZFS Pool as Storage

- Navigate to **Datacenter > Storage > Add > ZFS**.
- Storage ID: `forensics-zpool`.
- ZFS Pool: select the pool created above.
- Content types: enable as needed (`Disk image`, `ISO image`, `Backup`, etc.).
- Click **Add**.

### 3.4 Use Your ZFS Storage

- The pool is now available for VM disks, backup storage, and forensic data.
- Transfer memory images or evidence files to this storage via shell or VM access.

### 3.5 Create Directory Storage on ZFS Pool for File Management

For better file management and forensic workflows, set up a directory storage on your ZFS pool:

- Create a ZFS dataset for evidence and files:

```bash
zfs create forensics-zpool/training
```

- Add this as directory storage in Proxmox:

  - Go to **Datacenter > Storage > Add > Directory**.
  - Set Path to `/forensics-zpool/training`.
  - Enable allowed content types (`Disk image`, `ISO`, `Container`, etc.) as needed.
  - Click **Add**.

- Copy your forensic images, VM exports, or case files into `/forensics-zpool/training` using shell, SCP, SFTP, or WebUI.

```bash
scp -r [file_transfer] root@[proxmox_ip]:/forensics-zpool/forensics-training
```

## 4. Prepare Forensics VM Images

- Obtain SANS FOR508 VMs or desired forensic VMs on another machine.
- Place VM images (OVAs, disks, etc.) onto a USB drive/external storage.

## 4. Importing VMware VMs into Proxmox: Common File Types and Procedure

### 4.1 Common VMware File Types and Their Purpose

| File Extension | Purpose                                                                 |
|:--------------:|-------------------------------------------------------------------------|
| `.vmdk`        | **Virtual disk file:** Contains the VM’s data (operating system, files) |
| `.vmx`         | **VM configuration file:** Contains VM hardware/settings (text, readable)|
| `.nvram`       | VM’s virtual BIOS/EFI (stores boot data/settings)                       |
| `.vmsd`        | Snapshot management metadata                                            |
| `.vmxf`        | Additional config for VM teams/multiple VM products                     |
| `.log`         | VMware log files                                                        |
| `.iso`         | CD/DVD image: sometimes used to install or boot the VM                  |

- The `.vmdk` files are essential virtual disk files needed for import.
- `.vmx` is useful for referencing VM settings but not directly used by Proxmox.
- Other files like `.nvram`, `.vmsd`, `.vmxf`, logs are generally optional for import.

### 4.2 Procedure for Importing VMware VMDKs into Proxmox

#### Step 1: Copy VMware Files to Proxmox Storage

- Transfer your `.vmdk` files and associated VM folder contents (including `.vmx`) to a directory in your Proxmox storage, for example:  
  `/forensics-zpool/training/import/`

#### Step 2: Create a New VM in Proxmox

- In the Proxmox web UI, create a new VM matching the original VM’s OS type and settings.
- **Recommended hardware configuration for forensic analysis:**
  - **CPU:** 4 (set as 1 socket, 4 cores)
  - **RAM:** 32 GB (32768 MB)
  - **Firewall:** uncheck
  - Do **NOT** start the VM after creation.

#### Step 3: Import the VMDK Disk(s) into the New VM

- Use the Proxmox shell or SSH to run the import command for each `.vmdk` file:

```bash
qm disk import <vmid> <source> <storage>

qm disk import 100 [path_to_vm] forensics-zpool
```

#### Step 4: Attach Imported Disks in Proxmox UI

- Go to the VM's **`Hardware`** tab in the Proxmox UI.

> **NOTE:** If deploying a Windows VM, set the **Bus/Device** type as **`SATA`** to ensure that the Windows VM Deploys.

- The imported disks will appear as "Unused Disks." Attach them as the main boot disk or as additional disks.
- Remove any placeholder disks created at VM setup if they are not needed.
- Double-click "Unused Disks" and select "Add".
- Set the boot order so your imported disk is first (if it contains the OS).
  - Navigate to **`VM > Options > Boot Order`** and set your boot disk to the fist option.

#### Step 5: Additional Configuration

- Add any `.iso` files as virtual CD/DVD drives if needed for booting or troubleshooting.
- Update Proxmox VM Configuration for UTC
  - Go to **`VM > Options > "Use local time for RTC"`**
  - Set **`"No"`** for all VMs (this ensures that UTC is used and prevents time conversion issues between host and guest).

> **NOTE:** leave this setting as **`Default (Enabled for Windows)`**. Your Windows VM will inherit the UTC time setting created previously.

##### Mounting an Additional Drive (Windows)

- Poweroff the VM and navigate to the Hardware tab
- Look for "Unused Disk" entries
- Double-click the unused and select it and click: **Edit**
- **Configure the disk:**
  - **Bus/Device:** Set to **SATA**
  - **Select an available SATA port** (e.g., SATA1 if another drive is SATA0)
- Click **"Add"** to attach the disk
- The addition drive should now be present in the file system.

#### Step 6: Boot, Test, and Configure the VM

- Start the VM and verify that it boots and operates correctly.

##### Linux VM Manual UTC Time Configuration

```bash
# Set timezone to UTC
sudo timedatectl set-timezone UTC

# Set time manually in UTC
sudo date -u -s "YYYY-MM-DD HH:MM:SS"

# Sync hardware clock to UTC
sudo hwclock --systohc --utc

# Disable automatic time sync
sudo timedatectl set-ntp false   

# Verify configuration
timedatectl status
date -u
```

##### Windows VM UTC Time Configuration

> **NOTE:** you shouldn't need to run the commands below as Proxmox is set for UTC, however, if for some reason your created VM doesn't inherit those time settings follow the steps below.

```cmd
# Run as Administrator
# Set registry to use UTC (prevents Windows from adjusting for local time)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1 /f

# Set time zone to UTC
tzutil /s "UTC"

# Set date and time (Windows will treat this as UTC)
date "YYYY-MM-DD 
time HH:MM:SS

# Disable Windows Time service
Stop-Service w32time
Set-Service w32time -StartupType Disabled
```

## 5. Transfer Memory Images/Evidence

### 5.1 Create Evidence Directory Structure

- Create an **`evidence`** directory inside of the **`/forensics-zpool/training`**.
- This will serve as the shared storage location between your Proxmox host and forensic VMs.

### 5.2A Setup 9p Filesystem Passthrough for Airgapped Linux VMs

For airgapped Linux VMs or environments where virtiofs is not available, use 9p filesystem passthrough:

#### Step 1: Configure 9p Share in Proxmox

- **Stop your VM first** before making hardware changes.
- Add the 9p share via Proxmox shell or SSH:

  ```bash
  qm set <VMID> --args "-virtfs local,path=/forensics-zpool/training/evidence,mount_tag=evidence-share,security_model=passthrough"
  ```

  Replace **`VMID`** with your actual VM ID.
- **Start your VM** after configuration.

#### Step 2: Mount the Share Inside Your Linux VM

- Create the mount point:

  ```bash
  sudo mkdir /mnt/evidence
  ```

- Mount the 9p share:

  ```bash
  sudo mount -t 9p -o trans=virtio evidence-share /mnt/evidence
  ```

- Make the mount persistent:

  ```bash
  echo "evidence-share /mnt/evidence 9p trans=virtio,nofail 0 0" | sudo tee -a /etc/fstab
  ```

### 5.2B Setup Filesystem Passthrough for Airgapped Windows VMs

#### Step 1: Create the Unformatted Virtual Disk Image

```bash
# Create a raw, unformatted disk image
qemu-img create -f raw /forensics-zpool/training/windows-evidence-access.img 500G

# Alternative: Use qcow2 format for dynamic growth
qemu-img create -f qcow2 /forensics-zpool/training/windows-evidence-access.qcow2 500G
```

> **NOTE:** No formatting is performed at this stage, the disk will be formatted for NTFS later on.

#### Step 2: Import the Disk Image to Proxmox

```bash
# Import the created disk image into Proxmox storage
qm disk import <vm_id> /forensics-zpool/training/windows-evidence-access.img forensics-zpool
```

#### Step 3: Attach to Windows VM

1. **Stop your Windows VM** (if running)
2. **Go to VM → Hardware**
3. **Look for "Unused Disk"** entries - you should see your imported evidence disk
4. **Double-click the unused disk** or select it and click **Edit**
5. **Configure as SATA** for maximum compatibility
6. **Click "Add"** to attach the disk
7. **Start your Windows VM**

#### Step 4: Identify and Format the New Disk in Windows

**Open Disk Management:**

1. **Right-click the Start button** (Windows logo)
2. **Select "Disk Management"** from the context menu

**Locate and Initialize the New Disk:**

1. **Scroll down in Disk Management** to locate the **"Unallocated"** space
2. **Look for your new disk** (should show ~500GB unallocated space)
3. **Right-click on the "Unallocated" space**
4. **Select "New Simple Volume"**
5. **Proceed through the New Simple Volume Wizard with suggested settings:**
   - **Volume Size:** Accept default (uses full disk)
   - **Drive Letter:** Choose available letter (e.g., H:, I:, Z:)
   - **File System:** **Select "NTFS"** (critical for forensic work)
   - **Volume Label:** Enter "Evidence" or "Forensic-Data"
   - **Quick Format:** Check this option
6. **Click "Finish"**

#### Step 5: Verify Drive Access...

### 5.3 Transfer Evidence Files

- Place memory images (e.g., `.raw`, `.mem`, `.img`, `.vmem`) onto a USB drive or external media.
- Plug into Proxmox server or laptop and copy them to `/forensics-zpool/training/evidence/`.
- Files will be accessible from your VM at `/mnt/evidence/`.

### 5.4 Verify File Transfer and Mount Success

#### Test Mount Status

```bash
# Verify the mount is active
mount | grep evidence-share

# Check available space (should show your ZFS pool size)
df -h /mnt/evidence
```

#### Test File Synchronization

**From Proxmox host:**

```bash
# Create test file on host
echo "Test from Proxmox host - $(date)" > /forensics-zpool/training/evidence/test-host.txt
```

**From your Linux VM:**

```bash
# Wait 2-5 seconds for sync, then check
ls -la /mnt/evidence/test-host.txt
cat /mnt/evidence/test-host.txt

# Create test file from VM
echo "Test from VM - $(date)" > /mnt/evidence/test-vm.txt
```

**Back on Proxmox host:**

```bash
# Verify VM file appears on host
ls -la /forensics-zpool/training/evidence/test-vm.txt
```

> **Note:** The 9p method has a sync delay of 2-5 seconds.

## 6. Analyze in Forensic VM

- Boot up the forensic VM inside Proxmox.
- Ensure evidence disk or storage with memory images is accessible in the VM.
- Use the built-in forensics tools to analyze the memory images.

## 8. Misc. Information/References

- Always work from *copies* of evidence, never originals.
- Document hash values before/after each transfer.
- Use internal-only networking for VM isolation and security.
- Additional resources for tools to integrate in the furture.
  - [Computer Forensics](https://github.com/xiosec/Computer-forensics)
  - [FOR508 Resources](https://sansorg.egnyte.com/fl/FiM8JG50Qe#folder-link/FOR508-Dropbox-I01)
