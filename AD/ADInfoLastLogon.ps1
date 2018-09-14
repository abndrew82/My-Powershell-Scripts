$ErrorActionPreference = "SilentlyContinue"
$comps = Get-Content C:\Users\asenn\Documents\CompstoCheck.txt
ForEach ($comp in $comps)
{
$a = Get-ADComputer $comp -Properties lastlogontimestamp | Select -ExpandProperty LastLogonTimeStamp
$b = Get-ADComputer $comp -Properties passwordlastset | Select -ExpandProperty passwordlastset 
$c = Get-ADComputer $comp -Properties name | Select -ExpandProperty name
$d = Get-ADComputer $comp -Properties lastlogon | Select -ExpandProperty lastlogon
$e = Get-ADComputer $comp -Properties ipv4address | Select -ExpandProperty ipv4Address
$a = [datetime]::FromFileTime($a)
$d = [datetime]::FromFileTime($d)
If ($d -eq $null)
{
$d = "Last Logon is NULL"
}
#Write-Host $c "|" "Password Last Set =" $b "|"  "Last Logon TimeStamp =" $a "|" "Last Logon =" $d
$allinfo = $c + "|" + $b + "|" + $a + "|" + $d + "|" + $e
Out-File C:\Users\asenn\AllCompInfo.txt -InputObject $allinfo -Append
}