$ErrorActionPreference = "SilentlyContinue"
$a = Get-ADGroupMember COEDEAN-Staff | Select -ExpandProperty Name
ForEach ($b in $a)
{
$c = Get-ADGroupMember $b | Select -ExpandProperty Name
ForEach ($d in $c)
{
$users = Get-ADUser $d -Properties * | Select -ExpandProperty Name
$userstatus = Get-ADUser $d -Properties * | Select -ExpandProperty Enabled
#Write-Host $users "|" $userstatus
If ($userstatus -like "*False*")
{
Write-Host $users "|" $userstatus "|" $b
#$totalinfo = $users + "|" + $userstatus
#Out-File C:\Users\apsenn.admin\Desktop\coedeandisabled.txt -InputObject $totalinfo -Append
}
}
}