$OUs = Get-ADOrganizationalUnit -Filter 'Name -notlike "Desktops" -and Name -notlike "Laptops" -and Name -notlike "Staff"'  -SearchBase 'OU=Staff,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu' | Select -ExpandProperty Name
ForEach ($Unit in $OUs)
{
$Group = "COEDEAN-" + $Unit + ".Users"
Write-Host $Group
Get-ADGroupMember $Group | Select Name
}