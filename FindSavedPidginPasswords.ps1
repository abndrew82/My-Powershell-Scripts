Enter-PSSession itecs-dt-45
$users = Get-ChildItem C:\Users
##$users = Get-ChildItem C:\Users 
##Echo $users
$ErrorActionPreference = "SilentlyContinue"
##Write-Output $users
ForEach ($user in $users)
{
$strFileName="C:\users\$user\AppData\Roaming\.purple\accounts.xml"
Echo $strFileName
If (Test-Path $strFileName) {
Get-Content C:\Users\$user\AppData\Roaming\.purple\accounts.xml | Where-Object { $_.Contains("password") }
}
}