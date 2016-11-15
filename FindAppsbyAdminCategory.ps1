$apps = Get-CMApplication | Select -ExpandProperty LocalizedDisplayName
ForEach ($app in $apps)
{
$appadmingroup = Get-CMApplication -Name $app | Select -ExpandProperty CategoryInstance_UniqueIDs
If ($appadmingroup -like '*740a58a6-be42-433c-82f9-a9058cea2dd5*')
{
Write-Host $app "|" $appadmingroup
}
}