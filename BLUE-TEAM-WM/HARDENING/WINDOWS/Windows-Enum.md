# Windows Host Enumeration 🪟

## Hidden File and Folder identification within the last XX-Hours/XX-Days

```powershell

Get-ChildItem -Path "C:\YourDirectory" -Recurse -Force | Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-6) }

```

```powershell

Get-ChildItem -Path "C:\YourDirectory" -Recurse -Force | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-1) }

```

## File Encryption with PowerShell

```powershell

(Get-Item –Path C:\file.txt).Encrypt()

```

Modify ACL for the Specific File that you Need to Encrypt!

```powershell

$acl = Get-Acl -Path "C:\Users\simspace\Desktop\SCADA Notes.txt"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("simspace","FullControl","Allow")
$acl.SetAccessRule($accessRule)
Set-Acl -Path "C:\Users\simspace\Desktop\SCADA Notes.txt" -AclObject $acl

```

## Identifying Active SSH Sessions on Windows Machines

```powershell

Get-CimInstance -ClassName Win32_Process -Filter "Name = 'sshd.exe'" |
Get-CimAssociatedInstance -Association Win32_SessionProcess |
Get-CimAssociatedInstance -Association Win32_LoggedOnUser |
Where-Object {$_.Name -ne 'SYSTEM'} | Ft -Wrap

```
