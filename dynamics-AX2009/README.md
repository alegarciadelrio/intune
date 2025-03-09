# Microsoft Dynamics AX 2009 Deployment

This folder contains scripts for deploying Microsoft Dynamics AX 2009 ERP system through Microsoft Intune.

## Contents

- `install.ps1`: PowerShell script for installing and uninstalling Microsoft Dynamics AX 2009 and its required components

## Script Details

The `install.ps1` script handles the complete deployment of Microsoft Dynamics AX 2009, including all required components and prerequisites. It's designed to be deployed through Microsoft Intune and provides comprehensive logging for troubleshooting.

### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Installs Dynamics AX 2009 and all required components
  - `Uninstall`: Removes Dynamics AX 2009 and its components

### Installation Process

The script performs the following actions during installation:
1. Enables .NET Framework 3.5 (required for Dynamics AX 2009)
2. Installs Dynamics AX 2009 client with predefined parameters
3. Installs Dynamics AX 2009 SP1
4. Installs required components:
   - SQL Server CLR Types
   - Microsoft Report Viewer (multiple versions for compatibility)
   - MSXML 6.0 Parser
   - SQL Server Native Client
5. Configures an ODBC connection to the Dynamics AX server

### Uninstallation Process

During uninstallation, the script:
1. Removes all Dynamics AX 2009 components
2. Removes SQL CLR Types
3. Removes Microsoft Report Viewer components
4. Disables .NET Framework 3.5

### Features

- Silent installation with no user interaction required
- Comprehensive logging to the system temp folder
- Predefined configuration for quick deployment
- Complete cleanup during uninstallation

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file install.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file install.ps1 -Mode Uninstall
```

### Requirements

- Windows 10 or Windows 11
- Administrative privileges
- Internet connection (for .NET Framework 3.5 installation)
- Dynamics AX 2009 installation files must be included in the Intune package
