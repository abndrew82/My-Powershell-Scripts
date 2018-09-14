Param(
[Parameter(Mandatory=$true)]
[String]
$TwoDigitMonth
,
[Parameter(Mandatory=$true)]
[String]
$MonthFullName
,
[Parameter(Mandatory=$true)]
[String]
$Year
)
New-CMSoftwareUpdateGroup -Name "$MonthFullName $Year Microsoft Updates"
$NewupdateGroup = "$MonthFullName $Year Microsoft Updates"
Sleep 5
$GroupstoCombine = Get-CMSoftwareUpdateGroup |  Where-Object {$_.LocalizedDisplayName -like "*$Year-$TwoDigitMonth*"} | Select -ExpandProperty LocalizedDisplayName
ForEach ($Group in $GroupstoCombine)
{
$Updates = Get-CMSoftwareUpdate -UpdateGroupName $Group -Fast | Select -ExpandProperty LocalizedDisplayName
ForEach ($Update in $Updates)
{
Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $NewupdateGroup -SoftwareUpdateName $Update
}
}