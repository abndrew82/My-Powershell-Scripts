$Collections = Get-Content D:\OldCollections.txt
ForEach ($Collection in $Collections)
{
$QueryRules = Get-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection | Select -ExpandProperty RuleName
ForEach ($QueryRule in $QueryRules)
{
Write-Host $Collection "|" $QueryRule
Remove-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection -RuleName $QueryRule -Force
}
}