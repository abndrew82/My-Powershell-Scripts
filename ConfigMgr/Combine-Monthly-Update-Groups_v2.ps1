<#
.SYNOPSIS
    .
.DESCRIPTION
    .
.PARAMETER TwoDigitMonth
    The 2 digit Month of the previous Month ie 08
.PARAMETER MonthFullName
    The full month name ie August
.PARAMETER Year
    Four Digit year ie 2018
.EXAMPLE
    C:\PS> 
    Combine-Monthly-Update-Groups -TwoDigitMonth 08 -MonthFullName August -Year 2018
#>
Param(
[Parameter(Mandatory=$true)]
[String]
$TwoDigitMonth #Two digit month 08#
,
[Parameter(Mandatory=$true)]
[String]
$MonthFullName #Full Month Name August#
,
[Parameter(Mandatory=$true)]
[String]
$3rd_or_Windows #Full Month Name August#
,
[Parameter(Mandatory=$true)]
[String]
$Year #4 Digit year#
)
$date = Get-Date
$date.ToLongDateString()
If ($3rd_or_Windows -eq "3rd")
{
New-CMSoftwareUpdateGroup -Name "$MonthFullName $Year Microsoft Updates"
$NewupdateGroup = "$MonthFullName $Year Microsoft Updates"
Sleep 10
$GroupstoCombine = Get-CMSoftwareUpdateGroup |  Where-Object {$_.LocalizedDisplayName -like "*$Year-$TwoDigitMonth*" -and  $_.LocalizedDisplayName -like "*3rd*"} | Select -ExpandProperty LocalizedDisplayName
ForEach ($Group in $GroupstoCombine)
{
$Updates = Get-CMSoftwareUpdate -UpdateGroupName $Group -Fast | Select -ExpandProperty LocalizedDisplayName
ForEach ($Update in $Updates)
{
Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $NewupdateGroup -SoftwareUpdateName $Update
}
}
New-CMSoftwareUpdateDeployment -SoftwareUpdateGroupName $NewupdateGroup -DeploymentName $NewupdateGroup `
-DeploymentType Required -TimeBasedOn LocalTime -UserNotification DisplaySoftwareCenterOnly -AllowRestart $true -RestartWorkstation $true `
-CollectionId "FS100227" -DeadlineDateTime $date -AvailableDateTime $date -SoftwareInstallation $true

New-CMSoftwareUpdateDeployment -SoftwareUpdateGroupName $NewupdateGroup -DeploymentName $NewupdateGroup `
-DeploymentType Required -TimeBasedOn LocalTime -UserNotification DisplaySoftwareCenterOnly -AllowRestart $true -RestartWorkstation $true `
-CollectionId "FS1001A4" -DeadlineDateTime $date -AvailableDateTime $date -SoftwareInstallation $true
}
