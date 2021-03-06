﻿<#
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
.NOTES
    Author: Keith Hill
    Date:   June 28, 2010    
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
$Year #4 Digit year#
)
New-CMSoftwareUpdateGroup -Name "$MonthFullName $Year Microsoft Updates"
$NewupdateGroup = "$MonthFullName $Year Microsoft Updates"
Sleep 10
$GroupstoCombine = Get-CMSoftwareUpdateGroup |  Where-Object {$_.LocalizedDisplayName -like "*$Year-$TwoDigitMonth*"} | Select -ExpandProperty LocalizedDisplayName
ForEach ($Group in $GroupstoCombine)
{
$Updates = Get-CMSoftwareUpdate -UpdateGroupName $Group -Fast | Select -ExpandProperty LocalizedDisplayName
ForEach ($Update in $Updates)
{
Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $NewupdateGroup -SoftwareUpdateName $Update
}
}