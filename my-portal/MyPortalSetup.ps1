Param(
[Parameter(Mandatory=$true)]
[ValidateSet(“Install”, “Uninstall”)]
[String[]]
$Mode
)


$TempFolder = [System.IO.Path]::GetTempPath()
Start-Transcript -Append $TempFolder"IntuneMyPortalDeployment.txt"
$destinationShortcutFolder = "C:\Program Files (x86)\CommunicationsClients\myPortal"

If ($Mode -eq “Install”) 
{

.\CommunicationsClients.exe /qn /log $TempFolder\CommunicationsClients.txt
Start-Sleep 300
Copy-Item -Path myPortal.jar -Destination "$destinationShortcutFolder"

}

If ($Mode -eq “Uninstall”)
{

(Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -CLike "*CommunicationsClients*"}).uninstall()

}


Stop-Transcript