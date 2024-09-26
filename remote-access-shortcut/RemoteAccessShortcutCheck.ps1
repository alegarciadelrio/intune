$shortcutToCheck = "C:\users\public\desktop\Test Remote Access.lnk"
$argumentToCheck = "https://rds.Test.com.au/rdweb"

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