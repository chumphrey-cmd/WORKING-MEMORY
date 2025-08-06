# Memory Forensics Workstation Setup

## 1. Install Proxmox VE (Bare Metal)

- Download Proxmox VE ISO on a machine with internet access.
- Create a bootable USB drive with the ISO (e.g., Rufus, Etcher, Ventoy).
- Boot your server from USB and install Proxmox VE using the installation wizard.

## 2. Initial Proxmox Configuration

- Complete local configuration (network, storage) as needed.
- No internet required for installation or basic usage.

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
  - Set Path to `/forensics-zpool/forensics-training`.
  - Name it something descriptive (e.g., `training-dir`).
  - Enable allowed content types (`Disk image`, `ISO`, `Container`, etc.) as needed.
  - Click **Add**.

- Copy your forensic images, VM exports, or case files into `/forensics-zpool/forensics-training` using shell, SCP, SFTP, or WebUI.

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
- Do **not** start the VM after creation.

#### Step 3: Import the VMDK Disk(s) into the New VM

- Use the Proxmox shell or SSH to run the import command for each `.vmdk` file:

```bash
 qm disk import <vmid> <source> <storage>

qm disk import 100 [path_to_vm] forensics-zpool
```

#### Step 4: Attach Imported Disks in Proxmox UI

- Go to the VM's **Hardware** tab in the Proxmox UI.
- The imported disks will appear as "Unused Disks." Attach them as the main boot disk or as additional disks.
- Remove any placeholder disks created at VM setup if they are not needed.
- Set the boot order so your imported disk is first (if it contains the OS).

#### Step 5: Optional Additional Configuration

- Add any `.iso` files as virtual CD/DVD drives if needed for booting or troubleshooting.
- If the guest OS was previously running VMware Tools, uninstall them after boot, and install Proxmox/QEMU guest drivers for best performance.

#### Step 6: Boot and Test the VM

- Start the VM and verify that it boots and operates correctly.
- Troubleshoot device drivers or network adapters as needed.

### 4.3 Notes on Other VMware Files

- `.vmx`: Reference for original VM hardware settings.
- `.nvram`, `.vmsd`, `.vmxf`: Not usually required for import or boot in Proxmox.
- Logs and other auxiliary files: Not necessary for VM operation in Proxmox.

## 5. Import Forensics VM(s) into Proxmox

- Plug USB into Proxmox server.
- Copy VM images to a Proxmox storage directory (e.g., `/var/lib/vz`).
- Use Proxmox web interface or command line to import or create VMs from these images.

## 6. Transfer Memory Images/Evidence

- Place memory images (e.g., `.raw`, `.mem`, `.img`) onto a USB drive or external media.
- Plug into Proxmox server and copy them to a storage area accessible to the target forensic VM.
  - **Option 1:** Create and attach a dedicated virtual disk to the VM, then copy images there.
  - **Option 2:** Use USB passthrough to make the physical USB directly visible to the VM for direct file transfer.

## 7. Analyze in Forensic VM

- Boot up the forensic VM inside Proxmox.
- Ensure evidence disk or storage with memory images is accessible in the VM.
- Use the built-in forensics tools to analyze the memory images.

## 8. Misc. Information/References

- Always work from *copies* of evidence, never originals.
- Document hash values before/after each transfer.
- Use internal-only networking for VM isolation and security.
- Additional resources for tools to integrate in the furture.
  - [Computer Forensics](https://github.com/xiosec/Computer-forensics)
