# VM Shutdown Script

This script shuts down a list of virtual machines (VMs) and powers off the host machine.

## Usage

### 1. Elevate Privileges
Before running the script, ensure you are operating as the root user. You can either:

- Switch to the root user:
  
  ```bash
  su -
  ```

- Or use `sudo -i` to start a root shell:

  ```bash
  sudo -i
  ```

### 2. Execute the Script
Once you have elevated privileges, run the script using `bash`:

```bash
bash shutdown.sh
```

### 3. Dry Run Mode
To simulate the shutdown without making any changes:

```bash
bash shutdown.sh -d
```

### VM List
The script will shut down the following VMs by default:
- `dc1`
- `idm`
- `idm2`
- `nessus`
- `dc2`

You can modify this list in the script under the `VM_names` array.

## Troubleshooting

### Fixing Syntax Errors (Line Endings)
If you receive a syntax error like `^M: bad interpreter`, it could be due to Windows-style line endings. Use `dos2unix` to convert the script:

```bash
dos2unix shutdown.sh
```
