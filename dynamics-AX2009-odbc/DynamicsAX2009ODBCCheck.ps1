$DSN = "TEST"

Write-Host "Custom script based detection : $DSN"

if (Get-OdbcDsn | Where-Object{$_.Name -CLike "$DSN"}) {
    Write-host "ODBC $DSN already installed."
    Exit 0
} 
else { 
    Write-Host "ODBC $DSN not found. ODBC not installed."
    Exit 1
}