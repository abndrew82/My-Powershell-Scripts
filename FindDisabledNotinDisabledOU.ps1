$Comps = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "DC=uncfsu,DC=edu"-Properties CN | Select -ExpandProperty CN
ForEach ($comp in $Comps)
{
$CompStatus = Get-ADComputer -Identity $Comp -Properties Enabled | Select -ExpandProperty Enabled
$CurrentOU = Get-ADComputer -Identity $Comp -Properties DistinguishedName | Select -ExpandProperty DistinguishedName
If ($CompStatus -ne "True" -and $CurrentOU -notlike "*OU=2 - Disabled Computer Accounts,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu*")
{
Write-Host $comp "|" $CompStatus "|" $CurrentOU
}
}