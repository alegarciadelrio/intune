Param(
[Parameter(Mandatory=$true)]
[ValidateSet(“Install”, “Uninstall”)]
[String[]]
$Mode
)


$TempFolder = [System.IO.Path]::GetTempPath()
Start-Transcript -Append $TempFolder"IntuneDaxDeployment.txt"
$destinationConfigFolder = "C:\Program Files (x86)\Microsoft Dynamics AX\50\Client\Bin\"
$destinationShortcutFolder = "C:\users\public\desktop"
#$destinationShortcutFolder = $env:OneDrive+"\Desktop\"
#$destinationShortcutFolder = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)

If ($Mode -eq “Install”) 
{

Copy-Item -Path "$PSScriptRoot\AX09-Prod64.axc" -Destination "$destinationConfigFolder"
Copy-Item -Path "$PSScriptRoot\AX2009-Production.lnk" -Destination "$destinationShortcutFolder"

}

If ($Mode -eq “Uninstall”)
{

Remove-Item -Path $destinationConfigFolder"AX09-Prod64.axc"
Remove-Item -Path $destinationShortcutFolder"\AX2009-Production.lnk"

}


Stop-Transcript