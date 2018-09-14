######This script will check WMI for SCCM Application Requests by Users, and send an email to designated team for them to go in and Approve######
######It will also send emails to the team once approved or denied so everybody knows if someone already done it#################################
######First Check if there are any Apps with Pending Approval as Current State which is a 1######################################################
$AppNeedsApproval = Get-WmiObject -Class SMS_UserApplicationRequest -Namespace root/SMS/site_FS1 -ComputerName fsusccm | Where-Object {$_.CurrentState -eq "1"}
######If we find any requests, then process the data for them and send an email with the information#############################################
If ($AppNeedsApproval -ne $null)
{
ForEach ($RequestedApp in $AppNeedsApproval)
{
$RequeastedApp = $RequestedApp.Application
$RequestingUser = $RequestedApp.User
$RequestDate = $RequestedApp.LastModifiedDate
$RequestDate = ([WMI] '').ConvertToDateTime($RequestDate)
$RequestedComputer = $RequestedApp.RequestedMachine
$UserComments = $RequestedApp.Comments
Send-MailMessage -To "asenn@uncfsu.edu" -SmtpServer "webmail.uncfsu.edu" -Subject "Application Request Received" -Port "587" -Body "<b><h3>The following Application Request has been submitted - Please use the SCCM Console to Approve or Deny</b></h3><br><b>Application Name</b> : $RequeastedApp<br><b>Requesting User</b> : $RequestingUser<br><b>Requested Date</b> : $RequestDate<br><b>Requested Computer</b> : $RequestedComputer<br><b>User Comments</b> : $UserComments" -From "sccmadmin@uncfsu.edu" -BodyAsHtml
}
}
######Check for Apps that have been approved and send email to team, to inform them it has been approved######
######Only do this the first time we determine it was approved, to avoid repeated sends######
######This is done by adding data to a custom WMI Namespace and Class with properties of the requested App plus User and the RequestedGUID as the value the first time it finds the approved request"
$Approved = Get-WmiObject -Class SMS_UserApplicationRequest -Namespace root/SMS/site_FS1 -ComputerName fsusccm | Where-Object {$_.CurrentState -eq "4"}
ForEach ($ApprovedApp in $Approved)
{
$ApprovedAppName = $ApprovedApp.Application
$ApprovedUserName = $ApprovedApp.User
$ApprovedDate = $ApprovedApp.LastModifiedDate
$ApprovedBy = $ApprovedApp.LastModifiedBy
$RequestGuid = $ApprovedApp.RequestGuid
$AppNoSpace = $ApprovedApp  -replace '[ ]',''
$ApprovedUsernoslash = $ApprovedUserName.Substring("7")
$ApprovedDate2 = ([WMI] '').ConvertToDateTime($ApprovedDate)
$RequestGuid = $RequestGuid  -replace '[-]',''
$CheckifSent = Get-WMIProperty -NameSpace Root\SCCMRequestedApps -ClassName "ApprovedApps" -PropertyName $AppNoSpaceApprovedUsernoslash
Write-Host $CheckifSent
If ($CheckifSent -eq $null)
{
Send-MailMessage -To "asenn@uncfsu.edu" -SmtpServer "webmail.uncfsu.edu" -Subject "App Request Approved" -Port "587" -Body "Application = $ApprovedApp<br>User = $ApprovedUser<br>Approved By = $ApprovedBy<br>Approved on = $ApprovedDate2" -From "sccmadmin@uncfsu.edu" -BodyAsHtml
New-WMIProperty -NameSpace Root\SCCMRequestedApps -ClassName "ApprovedApps" -PropertyName $AppNoSpace$Usernoslash -PropertyValue $RequestGuid
}
Else
{
Write-Host "Email Already Sent"
}
}
######Check for Applications that have been denied, and send email to team, so they know somebody has denied it########################
######First We check for any Denys in the system##################
$Denied = Get-WmiObject -Class SMS_UserApplicationRequest -Namespace root/SMS/site_FS1 -ComputerName fsusccm | Where-Object {$_.CurrentState -eq "3"}
ForEach ($DeniedApp in $Denied)
{
$DeniedAppName = $DeniedApp.Application
$DeniedUserName = $DeniedApp.User
$DeniedDate = $DeniedApp.LastModifiedDate
$DeniedDate2 = ([WMI] '').ConvertToDateTime($DeniedDate)
$DeniedReason = $DeniedApp.Comments
$DeniedBy = $DeniedApp.LastModifiedBy
$DeniedAppNoSpace = $DeniedAppName  -replace '[ ]',''
$DeniedUsernoslash = $DeniedUserName.Substring("7")
$RequestGuid = $DeniedApp.RequestGuid
$RequestGuid = $RequestGuid  -replace '[-]',''
$CheckifDenySent = Get-WMIProperty -NameSpace Root\SCCMRequestedApps -ClassName "DeniedApps" -PropertyName $DeniedAppNoSpace$DeniedUsernoslash
If ($CheckifDenySent -eq $null)
{
Send-MailMessage -To "asenn@uncfsu.edu" -SmtpServer "webmail.uncfsu.edu" -Subject "App Request Denied" -Port "587" -Body "<b><h3>The Following Application Request has been Denied, see notes below</b></h3><br><b>Application Name</b> : $DeniedAppName<br><b>Requesting User</b> : $DeniedUser<br><b>Date Denied</b> : $DeniedDate2<br><b>Denied By</b> : $DeniedBy<br><b>Denied Reason</b> : $DeniedReason" -From "sccmadmin@uncfsu.edu" -BodyAsHtml
New-WMIProperty -NameSpace Root\SCCMRequestedApps -ClassName "DeniedApps" -PropertyName $DeniedAppNoSpace$DeniedUsernoslash -PropertyValue $RequestGuid
}
Else
{
Write-Host "Email Already Sent"
}
}