$Comps = Get-CMDeviceCollectionDirectMembershipRule -CollectionName "NoClient" | Select -ExpandProperty RuleName
ForEach ($Comp in $Comps)
{
Write-Host $comp
$DistName = Get-ADComputer $Comp -Properties DistinguishedName | Select -ExpandProperty DistinguishedName
Disable-ADAccount -Identity $DistName
Write-Host $Comp "- AD Account Disabled"
Remove-CMDevice -Name $Comp -Confirm:$false -Force
Write-Host $Comp "- Removed from SCCM"
$ReportData = $Comp + "|" + "Computer Disabled in AD and Removed from SCCM"
Out-File C:\Users\$asenn\Documents\DisabledReport.txt -InputObject $ReportData
}