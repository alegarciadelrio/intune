#$shortcutToCheck = $env:OneDrive+"\Desktop\AX2009-Production.lnk"
$shortcutToCheck = "C:\users\public\desktop\AX2009-Production.lnk"
$argumentToCheck = "C:\Program Files (x86)\Microsoft Dynamics AX\50\Client\Bin\AX09-Prod64.axc"

$sh = New-Object -COM WScript.Shell
$arguments = $sh.CreateShortcut($shortcutToCheck).Arguments

if ($arguments -like "*$argumentToCheck*") {
    Write-Output "Shortcut already installed. It is pointing to $arguments"
    Exit 0
} 
else { 
    Write-Output "Shortcut not installed."
    Exit 1
}