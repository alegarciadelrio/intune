[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Username,
    
    [Parameter(Mandatory=$true)]
    [string]$Email,
    
    [Parameter(Mandatory=$true)]
    [string]$FirstName,
    
    [Parameter(Mandatory=$true)]
    [string]$LastName,
    
    [Parameter(Mandatory=$false)]
    [string]$Description = "",
    
    [Parameter(Mandatory=$false)]
    [string]$Office = "",
    
    [Parameter(Mandatory=$false)]
    [string]$Telephone = "",
    
    [Parameter(Mandatory=$false)]
    [string]$StreetAddress = "",
    
    [Parameter(Mandatory=$false)]
    [string]$City = "",
    
    [Parameter(Mandatory=$false)]
    [string]$State = "",
    
    [Parameter(Mandatory=$false)]
    [string]$PostalCode = "",
    
    [Parameter(Mandatory=$false)]
    [string]$Country = "",
    
    [Parameter(Mandatory=$false)]
    [string]$Title = "",
    
    [Parameter(Mandatory=$false)]
    [string]$Department = "",
    
    [Parameter(Mandatory=$false)]
    [string]$Company = "Birch & Waite"
)

# Load required modules
Install-Module -Name AzureAD -Force -ErrorAction SilentlyContinue
Import-Module AzureAD -ErrorAction SilentlyContinue
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Message constants
$msgWelcome = "Script to create a user account in AD and AAD Services..."
$msgInitProcessAzure = "Connecting to Azure AD..."
$msgInitProcessExchange = "Connecting to Exchange Online..."
$msgInitProcessActiveDirectory = "Connecting to Active Directory..."
$msgInitProcessSyncAAD = "Syncing Azure AD..."
$msgInitProcessRemoveAAD = "Removing group membership of Azure AD..."
$parameterRename = "z_archive"

# Display welcome message
Write-Host $msgWelcome -ForegroundColor Cyan

# If parameters weren't provided via command line, prompt for them
if (-not $PSBoundParameters.ContainsKey('Username')) {
    $Username = Read-Host 'Enter the username (For example Alejandro.Garcia)'
}

if (-not $PSBoundParameters.ContainsKey('Email')) {
    $Email = Read-Host 'Enter the email (For example alejandro.garcia@birchandwaite.com.au)'
}

if (-not $PSBoundParameters.ContainsKey('FirstName')) {
    $FirstName = Read-Host 'Enter the first name'
}

if (-not $PSBoundParameters.ContainsKey('LastName')) {
    $LastName = Read-Host 'Enter the last name'
}

# Connect to Active Directory
Write-Host $msgInitProcessActiveDirectory -ForegroundColor Green

# Create the user in Active Directory
try {
    New-ADUser -Name "$FirstName $LastName" \
              -SamAccountName $Username \
              -UserPrincipalName $Email \
              -GivenName $FirstName \
              -Surname $LastName \
              -DisplayName "$FirstName $LastName" \
              -Description $Description \
              -Office $Office \
              -OfficePhone $Telephone \
              -StreetAddress $StreetAddress \
              -City $City \
              -State $State \
              -PostalCode $PostalCode \
              -Country $Country \
              -Title $Title \
              -Department $Department \
              -Company $Company \
              -EmailAddress $Email \
              -Enabled $true \
              -AccountPassword (ConvertTo-SecureString -AsPlainText "TemporaryP@ssw0rd1" -Force) \
              -ChangePasswordAtLogon $true
                
    Write-Host "User $Username created successfully in Active Directory" -ForegroundColor Green
} catch {
    Write-Error "Failed to create user in Active Directory: $_"
    exit 1
}

# Connect to Azure AD
Write-Host $msgInitProcessAzure -ForegroundColor Green
try {
    Connect-AzureAD
    Write-Host "Connected to Azure AD" -ForegroundColor Green
} catch {
    Write-Warning "Could not connect to Azure AD: $_"
    Write-Host "The user was created in Active Directory but not in Azure AD." -ForegroundColor Yellow
    Write-Host "You may need to run Azure AD Connect to sync the user." -ForegroundColor Yellow
}

# Sync Azure AD if connected
if ((Get-Module -Name AzureAD).Version) {
    Write-Host $msgInitProcessSyncAAD -ForegroundColor Green
    # Add Azure AD specific commands here if needed
}

Write-Host "User account creation process completed." -ForegroundColor Cyan
