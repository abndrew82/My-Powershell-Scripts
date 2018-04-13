$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-ADComputer -Filter * -SearchBase "OU=1 - Sort,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu"
ForEach ($Comp in $Comps)
{
$ADStatus = Get-ADComputer -Identity $Comp -Properties Enabled | Select -ExpandProperty Enabled
$ADDistName = Get-ADComputer -Identity $Comp -Properties DistinguishedName | Select -ExpandProperty DistinguishedName
$DisabledComputers = $Comp + "|" + $ADStatus
#Out-File 'C:\Users\$asenn\Documents\DisabledComputers2.txt' -InputObject $DisabledComputers -Append
#Write-Host $Comp "|" $ADStatus
If ($ADStatus -ne "True")
{
Write-Host $Comp "|" $ADStatus "|" $ADDistName
#Remove-ADComputer -Identity $Comp -confirm:$false
}
}
