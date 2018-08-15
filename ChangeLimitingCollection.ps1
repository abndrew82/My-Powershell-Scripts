$Collections = Get-CMDeviceCollection | Where-Object {$_.Name -like "*Phase*"} | Select -ExpandProperty Name
ForEach ($Collection in $Collections)
{
Set-CMDeviceCollection -Name $Collection -LimitingCollectionId "FS1003E5"
}