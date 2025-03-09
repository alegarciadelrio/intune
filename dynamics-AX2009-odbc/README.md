# Dynamics AX 2009 ODBC Configuration

This folder contains scripts for configuring ODBC connections required for Microsoft Dynamics AX 2009 through Microsoft Intune.

## Contents

- `DynamicsAX2009ODBC.ps1`: PowerShell script for creating and removing ODBC connections
- `DynamicsAX2009ODBCCheck.ps1`: PowerShell script for detection rule verification

## Script Details

### DynamicsAX2009ODBC.ps1

This script creates or removes a system DSN (Data Source Name) for connecting to Microsoft Dynamics AX 2009 database. It's designed to be deployed through Microsoft Intune and provides logging for troubleshooting.

#### Parameters

- `-Mode`: (Required) Specifies the operation mode
  - `Install`: Creates the ODBC DSN connection
  - `Uninstall`: Removes the ODBC DSN connection

#### Installation Process

The script performs the following actions during installation:
1. Creates a system DSN named "TEST" using SQL Server Native Client 11.0
2. Configures the connection to use the "test-server" SQL Server
3. Sets up a trusted connection (Windows authentication)
4. Adds a description for the connection

#### Uninstallation Process

During uninstallation, the script:
1. Removes the "TEST" system DSN

#### Features

- Silent configuration with no user interaction required
- Comprehensive logging to the system temp folder
- 32-bit ODBC configuration (required for Dynamics AX 2009)

### DynamicsAX2009ODBCCheck.ps1

This script provides detection methods for Microsoft Intune to verify successful installation of the ODBC connection. It checks for the existence of the configured DSN and returns appropriate exit codes.

## Usage in Intune

### Install Command

```
powershell.exe -ExecutionPolicy Bypass -file DynamicsAX2009ODBC.ps1 -Mode Install
```

### Uninstall Command

```
powershell.exe -ExecutionPolicy Bypass -file DynamicsAX2009ODBC.ps1 -Mode Uninstall
```

### Detection Rule

Use the `DynamicsAX2009ODBCCheck.ps1` script as a custom detection rule in Intune.

### Requirements

- Windows 10 or Windows 11
- Administrative privileges
- SQL Server Native Client 11.0 must be installed (typically installed with the Dynamics AX 2009 package)
