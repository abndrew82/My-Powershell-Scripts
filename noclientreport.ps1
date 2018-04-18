#
# Press 'F5' to run this script. Running this script will load the ConfigurationManager
# module for Windows PowerShell and will connect to the site.
#
# This script was auto-generated at '2/22/2018 8:30:47 AM'.

# Uncomment the line below if running in an environment where script signing is 
# required.
#Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Site configuration
$SiteCode = "FS1" # Site code 
$ProviderMachineName = "FSUSCCM.uncfsu.edu" # SMS Provider machine name

# Customizations
$initParams = @{}
#$initParams.Add("Verbose", $true) # Uncomment this line to enable verbose logging
#$initParams.Add("ErrorAction", "Stop") # Uncomment this line to stop the script on any errors

# Do not change anything below this line

# Import the ConfigurationManager.psd1 module 
if((Get-Module ConfigurationManager) -eq $null) {
    Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" @initParams 
}

# Connect to the site's drive if it is not already present
if((Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
    New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $ProviderMachineName @initParams
}

# Set the current location to be the site code.
Set-Location "$($SiteCode):\" @initParams

# Email params
$EmailParams = @{
    To         = 'asenn@uncfsu.edu'
    From       = 'sccmadmin@uncfsu.edu'
    Smtpserver = 'webmail.uncfsu.edu'
    Subject    = "ConfigMgr No Client Report  |  $(Get-Date -Format dd-MMM-yyyy)"
}

$Devices = Get-CMDevice -CollectionId FS10036D | Select -ExpandProperty Name
$DeviceCount = $Devices.Count
$html = "<h2>Devices in ConfigMgr with no Client<p><b>Total Count</b> = " + $DeviceCount + "</h2><p>"
$ReturnData = @()
ForEach ($Device in $Devices)
{
$DeviceInfo = Get-CMDevice -Name $Device
$DeviceName = $DeviceInfo.Name
$OS = $DeviceInfo.DeviceOS
Try
{
$Created = Get-ADComputer -Identity $DeviceName -Properties Created  | select -ExpandProperty Created 
$PassSet = Get-ADComputer -Identity $DeviceName -Properties passwordlastset | select -ExpandProperty passwordlastset
$ADLogon = Get-ADComputer -Identity $DeviceName -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
#$TestConn = Test-Connection -ComputerName $DeviceName -Count 1 -Quiet
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
$OffDiff = "No Info"
}
Else 
{
$LastOffline = $DeviceInfo.CNLastOfflineTime
$OffDiff =  $Today - $LastOffline
$OffDiff = $OffDiff.Days
}
If ($DeviceInfo.CNLastOnlineTime -eq $null)
{
$OnDiff = "No Info"
}
Else
{
$LastOnline = $DeviceInfo.CNLastOnlineTime
$OnDiff = $Today - $LastOnline
$OnDiff = $OnDiff.Days
}
#New-TimeSpan -Start $Today -End $Lastoff.CNLastOfflineTime | Select -ExcludeProperty Days
$ReturnData += New-Object psobject -Property @{"Computer Name" = $DeviceName; "OS" = $OS; "Offline Days" = $OffDiff; "Days since Online" = $OnDiff; "AD Created" = $Created; "Days PWD Change" = $PassSet; "Days since AD Logon" = $ADLogon; "Pingable" = $TestConn }
}
$ReturnData | Select "Computer Name", "OS", "Offline Days", "Days since Online", "AD Created", "Days PWD Change", "Days since AD Logon", "Pingable" | Sort-Object "Computer Name" | ConvertTo-Html | Out-File 'd:\Report.htm' -Force
$html += Get-Content 'd:\Report.htm' | Out-String
#$Data = $html
#Write-Host $html
Send-MailMessage @EmailParams -Body $html -BodyAsHtml

