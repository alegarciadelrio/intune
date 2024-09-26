Param(
[Parameter(Mandatory=$true)]
[ValidateSet(“Install”, “Uninstall”)]
[String[]]
$Mode
)

$TempFolder = [System.IO.Path]::GetTempPath()
Start-Transcript -Append $TempFolder"IntuneForticlientDeployment.txt"

If ($Mode -eq “Install”) 
{
    # Install FortiClient VPN
    #Start-Process Msiexec.exe -Wait -ArgumentList '/i FortiClientVPN.msi REBOOT=ReallySuppress /qn'
    .\FortiClientVPN.msi REBOOT=ReallySuppress /qn /log $TempFolder\FortiClientDeploy.txt
    Start-Sleep 200

    # Install VPN Profiles
    if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN") -ne $true) {  New-Item "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN' -Name 'Description' -Value 'VPN to connect Test' -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN' -Name 'Server' -Value 'vpn.Test.com.au' -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN' -Name 'promptusername' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN' -Name 'promptcertificate' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN' -Name 'ServerCert' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

}

If ($Mode -eq “Uninstall”)
{
    # Stop FortiClient Process
    Stop-Process -Name FortiClient -ErrorAction SilentlyContinue
    # Uninstall FortiClient
    Start-Process Msiexec.exe -wait -ArgumentList /'x {0272F040-0C81-4077-9AA7-82CCD495ADCA} REBOOT=ReallySuppress /qn'
    # Remove FortiClient VPN Profiles
    Remove-Item -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN" -force -ErrorAction SilentlyContinue
}

Stop-Transcript