# To Do

## Create Windows Golden Baseline Template

* **Build Base VM:**
    * Create a new Proxmox VM (e.g., name it `Win-Golden-Base`).
    * Install your chosen Windows OS (e.g., Windows 11 Pro from your ISO, or a Windows Enterprise Evaluation).
    * Install all VirtIO drivers from the `virtio-win-*.iso` (run `virtio-win-gt-x64.msi` or similar). Reboot after installation.

* **Prepare OS:**
    * Perform all Windows Updates until the system reports "You're up to date." This may require multiple reboots.
    * Install any common software you want present on all client VMs (e.g., preferred web browser, text editor, Sysinternals Suite, etc.).
    * Apply any desired baseline OS configurations or customizations.
    * **Crucial:** Ensure this VM is **NOT joined to any domain**. It should be in a workgroup.

* **Sysprep the Image:**
    * Once all software, updates, and configurations are finalized, navigate to: `C:\Windows\System32\Sysprep\`
    * Run `sysprep.exe`.
    * In the System Preparation Tool dialog:
        * System Cleanup Action: Select **`Enter System Out-of-Box Experience (OOBE)`**.
        * Check the box for **`Generalize`**.
        * Shutdown Options: Select **`Shutdown`**.
    * Click `OK`. Sysprep will process the image and then shut down the VM.

* **Convert to Proxmox Template:**
    * After the VM has shut down completely from the Sysprep process, **DO NOT power it back on.**
    * In the Proxmox Web UI, right-click on the sysprepped `Win-Golden-Base` VM.
    * Select **`Convert to template`**.

* **Deploy Future VMs:**
    * To create new client VMs, right-click the new template and select `Clone`.
    * Configure the clone's name, choose "Full clone" for independent machines, and assign it to the correct VLAN.
    * The cloned VM will boot into OOBE, allowing you to set a computer name, create a local user (or join domain directly if OOBE/network allows), and it will have a unique SID.

## Integration of Deception Techniques...