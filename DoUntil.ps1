$ErrorActionPreference = "SilentlyContinue"
Do
{
$Content = Test-Path "C:\Users\asenn\Documents\DoUntil.txt"
If ($Content -ne "True")
{
Write-Host "File Does not exist - Will check again shortly"
}
$pause = Test-Connection 1.1.1.1 -Count 10 | Out-Null
}
Until ($Content -eq "True")
Write-Host "File exists Now"