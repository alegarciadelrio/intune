# Remote Access Shortcut Deployment

This folder contains scripts for deploying and managing remote access shortcuts through Microsoft Intune.

## Contents

- `RemoteAccessShortcut.ps1`: PowerShell script for creating and removing remote access shortcuts
- `RemoteAccessShortcutCheck.ps1`: PowerShell script for detection rule verification
- `Test Remote Access.lnk`: Preconfigured shortcut file for remote access

## Script Details

### RemoteAccessShortcut.ps1

This script deploys a shortcut for remote access tools to the public desktop. It's designed to be deployed through Microsoft Intune and provides logging for troubleshooting.

#### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Deploys the remote access shortcut
  - `Uninstall`: Removes the remote access shortcut

#### Installation Process

The script performs the following actions during installation:
1. Copies the "Test Remote Access.lnk" shortcut to the public desktop folder

#### Uninstallation Process

During uninstallation, the script:
1. Removes the "Test Remote Access.lnk" shortcut from the public desktop folder

#### Features

- Silent deployment with no user interaction required
- Comprehensive logging to the system temp folder
- Creates shortcuts accessible to all users on the device

### RemoteAccessShortcutCheck.ps1

This script provides detection methods for Microsoft Intune to verify successful deployment of the shortcut. It checks for the existence of the deployed shortcut and returns appropriate exit codes.

### Shortcut File

- `Test Remote Access.lnk`: Preconfigured shortcut that points to remote access tools or resources

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file RemoteAccessShortcut.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file RemoteAccessShortcut.ps1 -Mode Uninstall
```

### Detection Rule

Use the `RemoteAccessShortcutCheck.ps1` script as a custom detection rule in Intune.

### Requirements

- Windows 10 or Windows 11
- Administrative privileges
- The target of the shortcut (remote access tool) should be installed or accessible

## Notes

- The shortcut is deployed to the public desktop, making it available to all users on the device
- The shortcut provides quick access to remote access tools or resources
- The script includes logging to help troubleshoot any deployment issues
