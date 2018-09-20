Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location FS1:\
# Email params
$EmailParams = @{
    To         = 'asenn@uncfsu.edu'
    From       = 'sccmadmin@uncfsu.edu'
    Smtpserver = 'webmail.uncfsu.edu'
    Subject    = "ConfigMgr No Client Report  |  $(Get-Date -Format dd-MMM-yyyy)"
}
$Devices = Get-CMDevice -CollectionName "Clients | No" | Select-Object -ExpandProperty Name
#$Devices = Get-CMDevice | Where-Object {$_.IsClient -eq $false -and $_.Name -notcontains "unknown"} | Select -ExpandProperty Name
$DeviceCount = $Devices.Count
$Title = "<h2>Devices in ConfigMgr with no Client<p><b>Total Count = " + $DeviceCount + "</h2><p>"
$header = '<table border="1">
<tr><td><b>Computer Name</b></td>
<td><b>User</b></td>
<td><b>OS</b></td>
<td><b>offline Days</b></td>
<td><b>AD Created</b></td>
<td><b>Days since AD Logon</b></td>
<td><b>Currently Pingable</b></td>
</tr>'
ForEach ($Device in $Devices)
{
$DeviceInfo = Get-CMDevice -Name $Device
$DeviceName = $DeviceInfo.Name
$OS = $DeviceInfo.DeviceOS
$User = $DeviceInfo.UserName
If ($User -eq $null)
{
$User = "No Data"    
}
If ($OS -eq $null)
{
$OS = "No Data"
}
Try
{
$Today = (Get-Date)
$Created = Get-ADComputer -Identity $DeviceName -Properties Created  | Select-Object -ExpandProperty Created 
$PassSet = Get-ADComputer -Identity $DeviceName -Properties passwordlastset | Select-Object -ExpandProperty passwordlastset
$ADLogon = Get-ADComputer -Identity $DeviceName -Properties LastLogonDate | Select-Object -ExpandProperty LastLogonDate
$TestConn = Test-Connection -ComputerName $DeviceName -Count 1 -Quiet
$PassDiff = $Today - $PassSet
$LogonDiff = $Today - $ADLogon
$PassSet = $PassDiff.Days
$ADLogon = $LogonDiff.Days
}
Catch
{
$Created = "AD Record Does not Exist"
$PassSet = "AD Record Does not Exist"
$ADLogon = "AD Record Does not Exist"
$TestConn = "False"
}

$Today = (Get-Date)
If ($DeviceInfo.CNLastOfflineTime -eq $null)
{
$OffDiff = "SCCM Data Lost"
}
Else 
{
$LastOffline = $DeviceInfo.CNLastOfflineTime
$OffDiff =  $Today - $LastOffline
$OffDiff = $OffDiff.Days
}
$data += "<tr><td>$DeviceName</td><td>$User</td><td>$OS</td><td>$OffDiff</td><td>$Created</td><td>$ADLogon</td><td>$TestConn</td></tr>" | Sort-Object $DeviceName
}
$html = $title + $header + $data
Send-MailMessage @EmailParams -Body $html -BodyAsHtml
Remove-Variable * -ErrorAction SilentlyContinue