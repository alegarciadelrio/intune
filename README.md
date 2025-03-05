# Intune Toolbox 

Examples of program parameters in intune. 

<p>
  <img alt="PowerShell" src="https://img.shields.io/badge/PowerShell-black?style=flat-square&logoColor=white" />
</p>

## For example to install DotNet 3.5, you should set this in "Install Command":
powershell.exe -ExecutionPolicy Bypass -file installDotNet35.ps1 -Mode Install

## For Uninstall Command:
powershell.exe -ExecutionPolicy Bypass -file installDotNet35.ps1 -Mode Uninstall

## Detection rule:
Registry HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0



## For example to install pdf editor:
Install command:
.\pdf_editor_setup.exe /verysilent /log "%temp%\pdf_editor_setup.txt" /norestart ALLUSERS=2

Uninstall command:
"C:\Program Files (x86)\Icecream PDF Editor\unins000.exe" /VERYSILENT /NORESTART
