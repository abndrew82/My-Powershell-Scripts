$ErrorActionPreference = "SilentlyContinue"
$a = Get-ADGroupMember "CCEE-Grad Students.ejjasels.Administrators" | Select -ExpandProperty Name
ForEach ($b in $a)
{
#Write-Host $b
$user = Get-ADUser $b -Properties * | Select -ExpandProperty Enabled
#Write-Host $b "|" $user
If ($user -like "*False*")
{Write-Host $b "|" $user}
}