$ErrorActionPreference = "SilentlyContinue"
$a = Get-ADComputer ADMIN-HD2 -Properties lastlogontimestamp | Select -ExpandProperty LastLogonTimeStamp
$b = Get-ADComputer ADMIN-HD2 -Properties passwordlastset | Select -ExpandProperty passwordlastset 
$c = Get-ADComputer ADMIN-HD2 -Properties name | Select -ExpandProperty name
$d = Get-ADComputer ADMIN-HD2 -Properties lastlogon | Select -ExpandProperty lastlogon
$a = [datetime]::FromFileTime($a)
$d = [datetime]::FromFileTime($d)
If ($d -eq $null)
{
$d = "Last Logon is NULL"
}
Write-Host $c "-" "Password Last Set =" $b "-"  "Last Logon TimeStamp =" $a "-" "Last Logon =" $d
