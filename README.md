# Intune Toolbox

<p>
  <img alt="PowerShell" src="https://img.shields.io/badge/PowerShell-black?style=flat-square&logoColor=white" />
</p>

Examples of program parameters in intune.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Repository Structure](#repository-structure)
- [Usage](#usage)
  - [Installing .NET Framework 3.5](#installing-net-framework-35)
  - [Installing PDF Editor](#installing-pdf-editor)

## Overview
This repository contains a collection of scripts and examples for Microsoft Intune deployment. It provides ready-to-use PowerShell scripts for common deployment scenarios and demonstrates how to configure installation parameters, uninstallation commands, and detection rules.

## Requirements
- Microsoft Intune subscription
- Windows 10/11 devices managed by Intune
- PowerShell 5.1 or higher
- Administrative privileges on target devices

## Repository Structure
This repository is organized into several folders, each containing scripts for specific deployment scenarios:

- **dot-net-35**: 
  - Contains the `installDotNet35.ps1` script for enabling or disabling .NET Framework 3.5 on Windows devices
  - Uses Windows Optional Features to manage the .NET Framework installation
  - Supports both installation and uninstallation modes via the `-Mode` parameter
  - No restart required after installation or removal

- **dynamics-AX2009**: 
  - Contains the `install.ps1` script for deploying Microsoft Dynamics AX 2009 ERP system
  - Installs all required components including .NET Framework 3.5, SQL Server Native Client, and Microsoft Report Viewer
  - Configures system prerequisites and sets up the application with predefined parameters
  - Includes comprehensive logging to the system temp folder for troubleshooting
  - Supports clean uninstallation of all components

- **dynamics-AX2009-odbc**: 
  - Contains scripts for configuring ODBC connections required for Dynamics AX 2009
  - `DynamicsAX2009ODBC.ps1` creates a system DSN named "TEST" using SQL Server Native Client 11.0
  - `DynamicsAX2009ODBCCheck.ps1` provides detection methods for Intune to verify successful installation
  - Configures trusted connections to the specified server
  - Supports removal of the ODBC connection during uninstallation

- **dynamics-AX2009-shortcut**: 
  - Contains scripts for creating and managing desktop shortcuts for Dynamics AX 2009
  - `DynamicsAX2009Shortcut.ps1` deploys configuration files and shortcuts to appropriate locations
  - Copies the AX09-Prod64.axc configuration file to the Dynamics AX client bin directory
  - Creates a desktop shortcut for quick access to the Dynamics AX 2009 Production environment
  - `DynamicsAX2009ShortcutCheck.ps1` provides detection methods for Intune
  - Supports clean removal of shortcuts and configuration files during uninstallation

- **forticlient**: 
  - Contains the `FortiClientVPN.ps1` script for deploying FortiClient VPN software
  - Installs the FortiClient VPN application silently with logging
  - Configures VPN profiles through registry settings
  - Sets up a preconfigured VPN connection to "vpn.Test.com"
  - Configures authentication settings and server certificates
  - Supports complete removal of the application and VPN profiles during uninstallation
  - Handles process termination during uninstallation to ensure clean removal

- **my-portal**: 
  - Contains the `MyPortalSetup.ps1` script for installing the myPortal communications client
  - Deploys the CommunicationsClients application package silently
  - Copies the myPortal.jar file to the installation directory
  - Provides comprehensive logging to the system temp folder
  - Supports complete removal of the application using WMI during uninstallation

- **remote-access-shortcut**: 
  - Contains scripts for creating and managing remote access shortcuts on the desktop
  - `RemoteAccessShortcut.ps1` deploys a "Test Remote Access" shortcut to the public desktop
  - Makes remote access tools easily accessible to all users on the device
  - `RemoteAccessShortcutCheck.ps1` provides detection methods for Intune to verify successful deployment
  - Supports clean removal of shortcuts during uninstallation

## Usage
Below are examples of how to use the scripts in this repository with Microsoft Intune.

### Installing .NET Framework 3.5
To deploy .NET Framework 3.5 using Intune:

**Install Command:**
```
powershell.exe -ExecutionPolicy Bypass -file installDotNet35.ps1 -Mode Install
```

**Uninstall Command:**
```
powershell.exe -ExecutionPolicy Bypass -file installDotNet35.ps1 -Mode Uninstall
```

**Detection Rule:**
Registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0`

### Installing PDF Editor
To deploy a PDF editor application using Intune:

**Install Command:**
```
.\pdf_editor_setup.exe /verysilent /log "%temp%\pdf_editor_setup.txt" /norestart ALLUSERS=2
```

**Uninstall Command:**
```
"C:\Program Files (x86)\Icecream PDF Editor\unins000.exe" /VERYSILENT /NORESTART
