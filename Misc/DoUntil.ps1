$ErrorActionPreference = "SilentlyContinue"
Do
{
$Fail = Get-Content -Tail 1 -Path F:\testreadend.txt
If ($Fail -eq "Pass")
{
Write-Host "Still a Pass"
}
$pause = Test-Connection 1.1.1.1 -Count 3 | Out-Null
}
Until ($Fail -eq "Fail")
Write-Host "We have found Fail"