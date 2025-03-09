# FortiClient VPN Deployment

This folder contains scripts for deploying and configuring FortiClient VPN software through Microsoft Intune.

## Contents

- `FortiClientVPN.ps1`: PowerShell script for installing, configuring, and uninstalling FortiClient VPN
- `FortiClientVPN.msi`: FortiClient VPN installer package (not included in repository)

## Script Details

### FortiClientVPN.ps1

This script handles the installation, configuration, and uninstallation of FortiClient VPN software. It's designed to be deployed through Microsoft Intune and provides logging for troubleshooting.

#### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Installs and configures FortiClient VPN
  - `Uninstall`: Removes FortiClient VPN and its configurations

#### Installation Process

The script performs the following actions during installation:
1. Installs FortiClient VPN silently using the MSI package
2. Waits for the installation to complete
3. Creates and configures a VPN profile with the following settings:
   - VPN Name: "VPN"
   - Description: "VPN to connect Test"
   - Server: "vpn.Test.com"
   - Authentication settings: Username prompt enabled
   - Certificate settings: Certificate prompt disabled

#### Uninstallation Process

During uninstallation, the script:
1. Stops any running FortiClient processes
2. Uninstalls the FortiClient VPN software using the product code
3. Removes the VPN profile from the registry

#### Features

- Silent installation with no user interaction required
- Comprehensive logging to the system temp folder
- Preconfigured VPN profile for quick deployment
- Complete cleanup during uninstallation

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file FortiClientVPN.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file FortiClientVPN.ps1 -Mode Uninstall
```

### Detection Rule

Registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN`

### Requirements

- Windows 10 or Windows 11
- Administrative privileges
- FortiClientVPN.msi must be included in the Intune package

## Notes

- The FortiClient VPN software is configured to connect to "vpn.Test.com" by default
- Users will be prompted for their username when connecting
- No certificate authentication is configured
- The VPN profile is named "VPN" and will appear in the FortiClient VPN interface
