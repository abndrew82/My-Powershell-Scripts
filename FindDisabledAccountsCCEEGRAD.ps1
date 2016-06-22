$ErrorActionPreference = "SilentlyContinue"
$a = Get-ADPrincipalGroupMembership "CCEE-Grad Students.Administrators" | Select -ExpandProperty Name
ForEach ($b in $a)
{
$c = Get-ADGroupMember $b | Select -ExpandProperty Name
ForEach ($d in $c)
{
$user = Get-ADUser $d -Properties * | Select -ExpandProperty Name
$userstatus = Get-ADUser $d -Properties * | select -ExpandProperty Enabled
#Write-Host $user "|" $userstatus
If ($userstatus -like "*False*")
{
Write-Host $user "|" $userstatus "|" $b
#Remove-ADGroupMember -Identity $b -Member $user -Confirm:$False
}
}
}