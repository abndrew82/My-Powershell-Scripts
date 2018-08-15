$collections = Get-CMDeviceCollection | Select -ExpandProperty CollectionID
ForEach ($collection in $collections)
{
$Variables = Get-CMDeviceCollectionVariable -CollectionId $collection | Where-Object {$_.Name -ne $null} | Select -ExpandProperty Name
ForEach ($Variable in $Variables)
{
$Collname = Get-CMDeviceCollection -CollectionId $collection | Select -ExpandProperty Name
$VarName = Get-CMDeviceCollectionVariable -CollectionId $collection | Select -ExpandProperty Name
$VarValue = Get-CMDeviceCollectionVariable -CollectionId $collection | Select -ExpandProperty Value
Write-Host $Collname "|" $VarName "|" $VarValue
}
}