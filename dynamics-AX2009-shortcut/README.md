# Dynamics AX 2009 Shortcut Configuration

This folder contains scripts for creating and managing desktop shortcuts for Microsoft Dynamics AX 2009 through Microsoft Intune.

## Contents

- `DynamicsAX2009Shortcut.ps1`: PowerShell script for creating and removing shortcuts and configuration files
- `DynamicsAX2009ShortcutCheck.ps1`: PowerShell script for detection rule verification
- `AX09-Prod64.axc`: Dynamics AX 2009 configuration file
- `AX2009-Production.lnk`: Preconfigured shortcut file

## Script Details

### DynamicsAX2009Shortcut.ps1

This script deploys configuration files and shortcuts for Microsoft Dynamics AX 2009. It's designed to be deployed through Microsoft Intune and provides logging for troubleshooting.

#### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Deploys the configuration file and shortcut
  - `Uninstall`: Removes the configuration file and shortcut

#### Installation Process

The script performs the following actions during installation:
1. Copies the AX09-Prod64.axc configuration file to the Dynamics AX client bin directory
2. Copies the AX2009-Production.lnk shortcut to the public desktop folder

#### Uninstallation Process

During uninstallation, the script:
1. Removes the AX09-Prod64.axc configuration file
2. Removes the AX2009-Production.lnk shortcut

#### Features

- Silent deployment with no user interaction required
- Comprehensive logging to the system temp folder
- Creates shortcuts accessible to all users on the device

### DynamicsAX2009ShortcutCheck.ps1

This script provides detection methods for Microsoft Intune to verify successful deployment of the shortcuts and configuration files. It checks for the existence of the deployed files and returns appropriate exit codes.

### Configuration Files

- `AX09-Prod64.axc`: Contains connection settings for the Dynamics AX 2009 Production environment
- `AX2009-Production.lnk`: Preconfigured shortcut that points to the Dynamics AX 2009 client with the Production configuration

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file DynamicsAX2009Shortcut.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file DynamicsAX2009Shortcut.ps1 -Mode Uninstall
```

### Detection Rule

Use the `DynamicsAX2009ShortcutCheck.ps1` script as a custom detection rule in Intune.

### Requirements

- Windows 10 or Windows 11
- Administrative privileges
- Microsoft Dynamics AX 2009 client must be installed
