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
#Online installer
Enable-WindowsOptionalFeature -Online -FeatureName ‘NetFx3’ -NoRestart
cmd.exe /c "start /wait DynamicsAX2009\setup.exe LogDir=%temp% HideUI=1 AcceptLicenseTerms=1 BypassWarnings=0 RunMode=Custom InstallClientUI=1 ConfigurePrerequisites=1 InstallPath=`"C:\Program Files\Microsoft Dynamics AX\50`" InstallPath32Bit=`"C:\Program Files (x86)\Microsoft Dynamics AX\50`" ClientLanguage=EN-AU ClientHelpLanguages=EN-AU ClientAosServer=TEST AosInstanceName= AosPort=2712 InstallNetBusinessConnector=1"

cmd.exe /c "start /wait DynamicsAX2009SP1\axupdate.exe LogDir=%temp% HideUI=1 AcceptLicenseTerms=1 InstallComponents=1 SetupLanguage=EN InstallPath=`"C:\Program Files\Microsoft Dynamics AX\50`" InstallPath32Bit=`"C:\Program Files (x86)\Microsoft Dynamics AX\50`""

cmd.exe /c "start /wait Requirements\SQLSysClrTypes\SQLSysClrTypes2012_x64.msi /qn /l* `"%temp%\MicrosoftSystemCLRTypesforSQLServer2012_x64.txt`" /norestart ALLUSERS=2"

cmd.exe /c "start /wait Requirements\MicrosoftReportViewer\ReportViewer2005.exe /Q /C:`"install.exe /q /l `"`"%temp%\MicrosoftReportViewerRedistributable2005.txt`"`"`""

cmd.exe /c "start /wait Requirements\MicrosoftReportViewer\ReportViewer2008SP1.exe /q /l `"%temp%\MicrosoftReportViewerRedistributable2008SP1.txt`""

cmd.exe /c "start /wait Requirements\MicrosoftReportViewer\ReportViewer2010SP1.exe /q /norestart /log `"%temp%\MicrosoftReportViewer2010SP1.txt`""

cmd.exe /c "start /wait Requirements\MicrosoftReportViewer\ReportViewer2012.msi /qn /l* `"%temp%\MicrosoftReportViewer2012.txt`" /norestart ALLUSERS=2"

cmd.exe /c "start /wait Requirements\MSXML6.0Parser\msxml6.msi /qn /L* `"%temp%\XML Parser.txt`" /norestart ALLUSERS=2"

cmd.exe /c "start /wait Requirements\SQLServerNativeClient\SQL2012NativeClient64bit\sqlncli.msi /qn /L* `"%temp%\SQL2012NativeClient64bit.txt`" /norestart ALLUSERS=2 IACCEPTSQLNCLILICENSETERMS=YES"

cmd.exe /c "%windir%\syswow64\ODBCCONF.EXE /a {CONFIGSYSDSN `"SQL Server Native Client 11.0`" `"DSN=TEST|Description=TEST CONNECTION|SERVER=test-server|Trusted_Connection=Yes`"}"

}

If ($Mode -eq “Uninstall”)

{

$Dax2009 = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -CLike "*Microsoft Dynamics AX 2009*"}
$CLRTypes = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -CLike "*Microsoft System CLR Types for SQL Server 2012*"}
$ReportViewer = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -CLike "*Microsoft Report*"}

$Dax2009.Uninstall()
$CLRTypes.Uninstall()
$ReportViewer.Uninstall()

Disable-WindowsOptionalFeature -Online -FeatureName ‘NetFx3’ -Remove -NoRestart

}

Stop-Transcript