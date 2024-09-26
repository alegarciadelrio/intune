Param(
[Parameter(Mandatory=$true)]
[ValidateSet(“Install”, “Uninstall”)]
[String[]]
$Mode
)


$TempFolder = [System.IO.Path]::GetTempPath()
Start-Transcript -Append $TempFolder"IntuneRemoteAccessDeployment.txt"
$destinationShortcutFolder = "C:\users\public\desktop"

If ($Mode -eq “Install”) 
{

Copy-Item -Path "$PSScriptRoot\Test Remote Access.lnk" -Destination "$destinationShortcutFolder"

}

If ($Mode -eq “Uninstall”)
{

Remove-Item -Path $destinationShortcutFolder"\Test Remote Access.lnk"

}


Stop-Transcript