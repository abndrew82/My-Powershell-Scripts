$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-Content 'C:\Users\$asenn\Documents\DisabledComps.txt'
ForEach ($Comp in $Comps)
{
$ADStatus = Get-ADComputer -Identity $Comp -Properties Enabled | Select -ExpandProperty Enabled
$DisabledComputers = $Comp + "|" + $ADStatus
#Out-File 'C:\Users\$asenn\Documents\DisabledComputers2.txt' -InputObject $DisabledComputers -Append
#Write-Host $Comp "|" $ADStatus
If ($ADStatus -eq "True")
{
Write-Host $Comp
}
}
