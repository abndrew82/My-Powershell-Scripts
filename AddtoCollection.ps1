$Comps = Get-Content 'C:\Users\asenn\OneDrive - Fayetteville State University\Win10Pilot.txt'
ForEach ($Comp in $Comps)
{
$SMSID = Get-CMDevice -Name $Comp | Select -ExpandProperty SMSID
If ($SMSID -ne $null)
{
Write-Host $comp
Add-CMDeviceCollectionDirectMembershipRule  -CollectionName "Pilot Computers" -ResourceId $(get-cmdevice -Name $Comp).ResourceID
}
}