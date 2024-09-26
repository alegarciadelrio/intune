Param(
[Parameter(Mandatory=$true)]
[ValidateSet(“Install”, “Uninstall”)]
[String[]]
$Mode
)

$TempFolder = [System.IO.Path]::GetTempPath()
Start-Transcript -Append $TempFolder"IntuneDaxDeployment.txt"

If ($Mode -eq “Install”)

{

cmd.exe /c "%windir%\syswow64\ODBCCONF.EXE /a {CONFIGSYSDSN `"SQL Server Native Client 11.0`" `"DSN=TEST|Description=TEST CONNECTION|SERVER=test-server|Trusted_Connection=Yes`"}"

}

If ($Mode -eq “Uninstall”)

{

Remove-OdbcDsn -Name "TEST" -DsnType "System" -Platform "32-bit"

}

Stop-Transcript