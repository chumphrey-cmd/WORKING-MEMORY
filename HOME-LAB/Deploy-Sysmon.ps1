# Script: Deploy-Sysmon.ps1
# Purpose: Installs/Updates Sysmon and then sets the event log size. This ensures the log channel always exists before we try to modify its size, solving the timing issue when using Yamato Security's EnableWindowsLogSettings.bat cleanly and professionally.

# --- Configuration ---
$SysmonExe = "Sysmon64.exe"
$SysmonConfig = "sysmon-config.xml"
$LogName = "Microsoft-Windows-Sysmon/Operational"
$LogSizeMB = 1024 # Set desired size in MB (1024 = 1 GB)
$LogSizeBytes = $LogSizeMB * 1024 * 1024

# --- Script Logic ---
# Get the directory where this script is running from.
# This allows it to find the other files when run from the NETLOGON share.
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Check if the Sysmon service is installed by checking for its presence
$SysmonService = Get-Service -Name "Sysmon64" -ErrorAction SilentlyContinue

if ($null -eq $SysmonService) {
    # --- INSTALLATION (Service does not exist) ---
    Write-Host "Sysmon service not found. Installing..."
    $InstallArgs = "-accepteula -i `"$($ScriptDirectory)\$SysmonConfig`""
    Start-Process -FilePath "$($ScriptDirectory)\$SysmonExe" -ArgumentList $InstallArgs -Wait
    
    # Verify installation before setting log size
    if (Get-Service -Name "Sysmon64" -ErrorAction SilentlyContinue) {
        Write-Host "Sysmon installed successfully. Setting log size to $($LogSizeMB)MB..."
        wevtutil.exe sl $LogName /ms:$LogSizeBytes
    } else {
        Write-Host "ERROR: Sysmon installation failed."
    }

} else {
    # --- CONFIGURATION UPDATE (Service already exists) ---
    Write-Host "Sysmon already installed. Updating configuration..."
    $UpdateArgs = "-c `"$($ScriptDirectory)\$SysmonConfig`""
    Start-Process -FilePath "$($ScriptDirectory)\$SysmonExe" -ArgumentList $UpdateArgs -Wait

    Write-Host "Verifying Sysmon log size is set to $($LogSizeMB)MB..."
    wevtutil.exe sl $LogName /ms:$LogSizeBytes
}

Write-Host "Sysmon deployment script finished."