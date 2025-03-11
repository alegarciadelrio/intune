# Intune Toolbox

<p>
  <img alt="PowerShell" src="https://img.shields.io/badge/PowerShell-black?style=flat-square&logoColor=white" />
</p>

Examples of program parameters in intune.

## 📋 Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Usage](#usage)
  - [Installing .NET Framework 3.5](#installing-net-framework-35)
  - [Installing PDF Editor](#installing-pdf-editor)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## 🔍 Overview
This repository contains a collection of scripts and examples for Microsoft Intune deployment. It provides ready-to-use PowerShell scripts for common deployment scenarios and demonstrates how to configure installation parameters, uninstallation commands, and detection rules.

## ✅ Requirements
- Microsoft Intune subscription
- Windows 10/11 devices managed by Intune
- PowerShell 5.1 or higher
- Administrative privileges on target devices

## 📁 Repository Structure
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

## 🚀 Usage
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
```

## 🏁 Getting Started

### Using This Repository with Intune

1. **Clone or download this repository**
   ```
   git clone https://github.com/yourusername/intune-toolbox.git
   ```
   Or download as a ZIP file and extract it.

2. **Prepare your deployment package**
   - For each script you want to deploy, create a new Win32 app in Intune
   - Include the script and any required files (e.g., configuration files, installers)
   - Use the commands provided in each folder's README for installation and uninstallation
   - Configure detection rules as specified in the documentation

3. **Test your deployment**
   - Deploy to a test group before rolling out to production
   - Verify that installation, detection, and uninstallation work as expected

4. **Deploy to your organization**
   - Assign the app to the appropriate groups in your organization
   - Monitor deployment status through the Intune portal

### Package Structure for Intune Deployment

When creating an Intune package, ensure it includes:
- The main PowerShell script (e.g., `installDotNet35.ps1`)
- Any supporting files referenced by the script
- Any required installers or binaries

## 🔧 Troubleshooting

### Common Issues

#### Script Execution Policy Errors
If you encounter script execution policy errors, ensure your install command includes `-ExecutionPolicy Bypass`.

#### Detection Rule Failures
If Intune reports that the app is not installed despite successful installation:
- Verify that the detection method is correctly configured
- Check if the detection script is returning the expected exit code
- Ensure registry keys or file paths used for detection exist on the target system

#### Installation Failures
If installation fails:
- Check the logs in the temp folder (`%temp%`) for error messages
- Verify that all prerequisites are installed
- Ensure the target system meets the minimum requirements

#### Uninstallation Issues
If uninstallation fails:
- Check if the application is running during uninstallation
- Verify that the uninstall command is correct
- Check logs for specific error messages

## 👥 Contributing

Contributions to this repository are welcome! Here's how you can contribute:

1. **Fork the repository**
2. **Create a feature branch**
   ```
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test your changes** to ensure they work as expected
5. **Submit a pull request** with a clear description of your changes

### Contribution Guidelines

- Follow the existing code style and naming conventions
- Include detailed comments in your scripts
- Update the README.md files with any necessary information
- Test your scripts thoroughly before submitting

## ⚖️ License

This project is licensed under the MIT License - see the LICENSE file for details.

```
MIT License

Copyright (c) 2025 Your Organization

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
