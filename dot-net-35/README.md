# .NET Framework 3.5 Deployment

This folder contains scripts for deploying and managing .NET Framework 3.5 on Windows devices through Microsoft Intune.

## Contents

- `installDotNet35.ps1`: PowerShell script for enabling or disabling .NET Framework 3.5

## Script Details

The `installDotNet35.ps1` script uses Windows Optional Features to manage the .NET Framework 3.5 installation. It supports both installation and uninstallation modes and is designed to be deployed through Microsoft Intune.

### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Enables the .NET Framework 3.5 feature
  - `Uninstall`: Disables and removes the .NET Framework 3.5 feature

### Features

- No restart required after installation or removal
- Uses native Windows PowerShell cmdlets for feature management
- Compatible with Windows 10 and Windows 11

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file installDotNet35.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file installDotNet35.ps1 -Mode Uninstall
```

### Detection Rule

Registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0`
