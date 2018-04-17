###Import Log function to easily write to a log###
. "$PSScriptRoot\Write-Log.ps1"
###Create the Initial Log in case this is first run###
If (!(Test-Path c:\windows\temp\AppRequest.csv))
{
Write-Log -GUID "Initial Entry" -ComputerName "Initial Entry" -Application "Initial Entry" -User "Initial Entry" -RequestState "Initial Entry"`
 -Comments "Initial Entry" -LastModifiedBy "Initial Entry" -LastModifiedDate "Initial Entry" -Severity Information
}
###Various Global Variables###
$EmailServer = "webmail.uncfsu.edu"
$EmailReceiver = "CCM-Team@uncfsu.edu"
$EmailSender = "sccmadmin@uncfsu.edu"
$Port = "587"
$SiteCode = "FS1"
###Get List of Application Requests###
$ApplicatonRequests = Get-WmiObject -Class SMS_UserApplicationRequest -Namespace root/SMS/site_$SiteCode -ComputerName fsusccm
ForEach ($ApplicatonRequest in $ApplicatonRequests)
{
###Process through Each one and check for the current state###
###Get the Base Data from Each Request###
$ApplicationName = $ApplicatonRequest.Application
$RequestingUser = $ApplicatonRequest.User
$LastModifiedDate = $ApplicatonRequest.LastModifiedDate
$RequestedComputer = $ApplicatonRequest.RequestedMachine
$ApprovedorDeniedBy = $ApplicatonRequest.LastModifiedBy
$RequestGUID = $ApplicatonRequest.RequestGuid
$Comments = $ApplicatonRequest.Comments
###If the Current State is a request, send an email to the Approver so that they can Approve or Deny###
If ($ApplicatonRequest.CurrentState -eq "1")
{
###Format the date to a more readable format###
$LastModifiedDate = ([WMI] '').ConvertToDateTime($LastModifiedDate)
###Form the HTML Body###
$Emailbody = "<b><h3>The following Application Request has been submitted - Please use the SCCM Console to Approve or Deny</b></h3><br>`
<b>Application Name</b> : $ApplicationName<br>`
<b>Requesting User</b> : $RequestingUser<br>`
<b>Requested Date</b> : $LastModifiedDate<br>`
<b>Requested Computer</b> : $RequestedComputer<br>`
<b>User Comments</b> : $Comments"
Send-MailMessage -To $EmailReceiver -SmtpServer $EmailServer -Subject "Application Request Received" -Port $Port -Body $Emailbody -From $EmailSender -BodyAsHtml
}
###If the Current State is Denied, Check to see if we have previously sent an email for this Request, and if not Send One###
ElseIf ($ApplicatonRequest.CurrentState -eq "3") 
{
###Check if we have previously sent an email for this Denial###
$LogFile = Import-Csv -Path C:\Windows\Temp\AppRequest.csv
If ($LogFile.GUID -notcontains $RequestGUID)
{
###Format the date to a more readable format###
$LastModifiedDate = ([WMI] '').ConvertToDateTime($LastModifiedDate)
###Form the HTML Body###
$Emailbody = "<b><h3>The following Application Request has been denied, see below for more information</b></h3><br>`
<b>Application Name</b> : $ApplicationName<br>`
<b>Requesting User</b> : $RequestingUser<br>`
<b>Requested Date</b> : $LastModifiedDate<br>`
<b>Requested Computer</b> : $RequestedComputer<br>`
<b>Denied by</b> : $ApprovedorDeniedBy<br>`
<b>Admin Comments</b> : $Comments"
Write-Log -GUID $RequestGUID -ComputerName $RequestedComputer -Application $ApplicationName -User $RequestingUser -RequestState "Denied"`
 -Comments $Comments -LastModifiedBy $ApprovedorDeniedBy -LastModifiedDate $LastModifiedDate -Severity Information
Send-MailMessage -To $EmailReceiver -SmtpServer $EmailServer -Subject "Application Request Denied" -Port $Port -Body $Emailbody -From $EmailSender -BodyAsHtml
}
}
###If the Current State is Approved, Check to see if we have previously sent an email for this Request, and if not Send One###
ElseIf ($ApplicatonRequest.CurrentState -eq "4")
{
###Check if we have previously sent an email for this Approval###
$LogFile = Import-Csv -Path C:\Windows\Temp\AppRequest.csv
If ($LogFile.GUID -notcontains $RequestGUID)
{
###Format the date to a more readable format###
$LastModifiedDate = ([WMI] '').ConvertToDateTime($LastModifiedDate)
###Form the HTML Body###
$Emailbody = "<b><h3>The following Application Request has been approved, see below for more information</b></h3><br>`
<b>Application Name</b> : $ApplicationName<br>`
<b>Requesting User</b> : $RequestingUser<br>`
<b>Requested Date</b> : $LastModifiedDate<br>`
<b>Requested Computer</b> : $RequestedComputer<br>`
<b>Approved by</b> : $ApprovedorDeniedBy<br>`
<b>Admin Comments</b> : $Comments"
Write-Log -GUID $RequestGUID -ComputerName $RequestedComputer -Application $ApplicationName -User $RequestingUser -RequestState "Approved"`
 -Comments $Comments -LastModifiedBy $ApprovedorDeniedBy -LastModifiedDate $LastModifiedDate -Severity Information
Send-MailMessage -To $EmailReceiver -SmtpServer $EmailServer -Subject "Application Request Approved" -Port $Port -Body $Emailbody -From $EmailSender -BodyAsHtml
}
}
}