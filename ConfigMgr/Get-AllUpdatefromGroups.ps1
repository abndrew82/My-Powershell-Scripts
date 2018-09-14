$UpdateGroups = Get-CMSoftwareUpdateGroup | Select -ExpandProperty LocalizedDisplayName
ForEach ($UpdateGroup in $UpdateGroups)
{
If ($UpdateGroup -like "*Batch*")
{
Get-CMSoftwareUpdate -UpdateGroupName $UpdateGroup -Fast | Select -ExpandProperty LocalizedDisplayName
}
}