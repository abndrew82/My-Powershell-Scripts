#New-CMSoftwareUpdateGroup -Name "July 2018 Microsoft Updates"
$NewupdateGroup = "July 2018 Microsoft Updates"
$GroupstoCombine = Get-CMSoftwareUpdateGroup |  Where-Object {$_.LocalizedDisplayName -like "*2018-07*"} | Select -ExpandProperty LocalizedDisplayName
ForEach ($Group in $GroupstoCombine)
{
$Updates = Get-CMSoftwareUpdate -UpdateGroupName $Group -Fast | Select -ExpandProperty LocalizedDisplayName
ForEach ($Update in $Updates)
{
Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $NewupdateGroup -SoftwareUpdateName $Update
}
}