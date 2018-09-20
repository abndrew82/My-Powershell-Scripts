#Get-Help Remove-GPLink -Examples
$ErrorActionPreference = "Continue"
$OUs = Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty DistinguishedName
ForEach ($OU in $OUs)
{
Write-Host "Removing Hibernation Employees - 7/13/2015 from:" $OU
Remove-GPLink -Name "Hibernation Employees - 7/13/2015" -Target $OU -Confirm:$false
}