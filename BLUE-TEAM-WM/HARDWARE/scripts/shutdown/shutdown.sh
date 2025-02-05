#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

# Parse command-line options
DRY_RUN=false
while getopts "d" opt; do
    case $opt in
        d) DRY_RUN=true ;;
    esac
done

# VM names
VM_names=("dc1" "idm" "idm2" "nessus" "dc2")

# Shutdown VMs
for vm in "${VM_names[@]}"; do
    if $DRY_RUN; then
        echo "Dry run: Would shut down $vm"
    else
        echo "Shutting down $vm..."
        virsh shutdown "$vm"
    fi
done

# Skip monitoring and power-off if in dry run mode
if $DRY_RUN; then
    echo "Dry run complete. No VMs were actually shut down."
    exit 0
fi

# Watch to verify shutdown
echo "Monitoring the shutdown process..."
while virsh list --all | grep -q "running"; do
    sleep 1
done

# Once all VMs are shut down, power off the machine
echo "All VMs are shut down, powering off."
poweroff
