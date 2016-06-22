$ErrorActionPreference = "SilentlyContinue"
$a = Get-ADGroupMember "COEDEAN-Staff" | Select -ExpandProperty Name
ForEach ($b in $a)
{
$c = Get-ADGroupMember $b | Select -ExpandProperty Name
ForEach ($d in $c)
{
$user = Get-ADUser $d -Properties Name | Select -ExpandProperty Name
$userstatus = Get-ADUser $d -Properties Enabled | select -ExpandProperty Enabled
#Write-Host $user "|" $userstatus
If ($userstatus -like "*False*")
{
Write-Host $user "|" $userstatus "|" $b
#Remove-ADGroupMember -Identity $b -Member $user -Confirm:$False
}
}
}