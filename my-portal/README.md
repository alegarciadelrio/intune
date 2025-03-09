# myPortal Communications Client Deployment

This folder contains scripts for deploying and configuring the myPortal communications client through Microsoft Intune.

## Contents

- `MyPortalSetup.ps1`: PowerShell script for installing and uninstalling the myPortal communications client
- `myPortal.jar`: Java application file for the myPortal client
- `CommunicationsClients.exe`: Installer for the Communications Clients package (not included in repository)

## Script Details

### MyPortalSetup.ps1

This script handles the installation and uninstallation of the myPortal communications client. It's designed to be deployed through Microsoft Intune and provides logging for troubleshooting.

#### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Installs the Communications Clients package and deploys the myPortal client
  - `Uninstall`: Removes the Communications Clients package

#### Installation Process

The script performs the following actions during installation:
1. Installs the Communications Clients package silently
2. Waits for the installation to complete (5 minutes)
3. Copies the myPortal.jar file to the installation directory

#### Uninstallation Process

During uninstallation, the script:
1. Uninstalls the Communications Clients package using WMI

#### Features

- Silent installation with no user interaction required
- Comprehensive logging to the system temp folder
- Deploys the Java-based myPortal client
- Complete cleanup during uninstallation

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file MyPortalSetup.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file MyPortalSetup.ps1 -Mode Uninstall
```

### Detection Rule

Check for the existence of the file: `C:\Program Files (x86)\CommunicationsClients\myPortal\myPortal.jar`

### Requirements

- Windows 10 or Windows 11
- Administrative privileges
- Java Runtime Environment (JRE) must be installed
- CommunicationsClients.exe and myPortal.jar must be included in the Intune package

## Notes

- The myPortal client is a Java-based application for unified communications
- The installation process includes a 5-minute wait to ensure the Communications Clients package is fully installed
- The myPortal.jar file is copied to the installation directory after the main package installation
