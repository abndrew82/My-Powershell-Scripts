## Displays a Windows 10 Toast Notification for a ConfigMgr Application deployment
## To be used in a compliance item

## References
# Options for audio: https://docs.microsoft.com/en-us/uwp/schemas/tiles/toastschema/element-audio#attributes-and-elements
# Toast content schema: https://docs.microsoft.com/en-us/windows/uwp/design/shell/tiles-and-notifications/toast-schema
# Datetime format for deadline: Ref: https://msdn.microsoft.com/en-us/library/system.datetime(v=vs.110).aspx

# Required parameters
$Title = "Java 8 Update 181"
$SoftwarecenterShortcut= "softwarecenter:SoftwareID=ScopeId_A44D3C09-DCBF-417C-87F5-B7CE3D5EDD93/Application_821fb378-9c6c-4621-95a4-7fd4a0035ab7"
$AudioSource = "ms-winsoundevent:Notification.Default"
$SubtitleText = "A new version of Java is now available in Software Center."
$BodyText = ""
$HeaderFormat = "ImageOnly" # Choose from "TitleOnly", "ImageOnly" or "ImageAndTitle"

# Optional parameters
# Base64 string for an image, see Images section below to create the string
$Base64Image = "put text for image here"
# Deployment deadline
#[datetime]$Deadline = "31 August 2018 15:00"


# Calculated parameters
If ($Deadline)
{
    $TimeSpan = $Deadline - [datetime]::Now
}

## Images
# Convert an image file to base64 string
<#
$File = "C:\Users\tjones\Pictures\ICON_EV_LOGO_Resized.png"
$Image = [System.Drawing.Image]::FromFile($File)
$MemoryStream = New-Object System.IO.MemoryStream
$Image.Save($MemoryStream, $Image.RawFormat)
[System.Byte[]]$Bytes = $MemoryStream.ToArray()
$Base64 = [System.Convert]::ToBase64String($Bytes)
$Image.Dispose()
$MemoryStream.Dispose()
$Base64 | out-file "C:\Users\tjones\Pictures\ICON_EV_LOGO_Resized.txt" # Save to text file, copy and paste from there to the $Base64Image variable
#>

# Create an image file from base64 string and save to user temp location
If ($Base64Image)
{
    $ImageFile = "$env:TEMP\ToastLogo.png"
    [byte[]]$Bytes = [convert]::FromBase64String($Base64Image)
    [System.IO.File]::WriteAllBytes($ImageFile,$Bytes)
}
 
# Load some required namespaces
$null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
$null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

# Register the AppID in the registry for use with the Action Center, if required
$app =  '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
$AppID = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\\WindowsPowerShell\\v1.0\\powershell.exe"
$RegPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings'

if (!(Test-Path -Path "$RegPath\$AppId")) {
    $null = New-Item -Path "$RegPath\$AppId" -Force
    $null = New-ItemProperty -Path "$RegPath\$AppId" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD'
}


# Define the toast notification in XML format
[xml]$ToastTemplate = @"
<toast scenario="reminder">
    <visual>
    <binding template="ToastGeneric">
        <text>New Software Notification</text>
        <text placement="attribution">from DR Horton IT</text>        
        <group>
            <subgroup>
                <text hint-style="title" hint-wrap="true" >$Title</text>
            </subgroup>
        </group>
        <group>          
            <subgroup>     
                <text hint-style="subtitle" hint-wrap="true" >$SubtitleText</text>
            </subgroup>
        </group>
        <group>
            <subgroup>     
                <text hint-style="body" hint-wrap="true" >$BodyText</text>
            </subgroup>
        </group>
    </binding>
    </visual>
    <actions>
      <action content="Install now" activationType="protocol" arguments="$SoftwarecenterShortcut" />
      <action content="Another time..." arguments="" />
    </actions>
    <audio src="$AudioSource"/>
</toast>
"@

# Change up the headers as required
If ($HeaderFormat -eq "TitleOnly")
{
    $ToastTemplate.toast.visual.binding.group[0].subgroup.InnerXml = "<text hint-style=""title"" hint-wrap=""true"" >$Title</text>"
}
If ($HeaderFormat -eq "ImageOnly")
{
    $ToastTemplate.toast.visual.binding.group[0].subgroup.InnerXml = "<image src=""$ImageFile""/>"
}
If ($HeaderFormat -eq "ImageAndTitle")
{
    $ToastTemplate.toast.visual.binding.group[0].subgroup.InnerXml = "<text hint-style=""title"" hint-wrap=""true"" >$Title</text><image src=""$ImageFile""/>"
}

# Add a deadline if required
If ($Deadline)
{
$DeadlineGroups = @"
        <group>
            <subgroup>
                <text hint-style="base" hint-align="left">Deadline</text>
                 <text hint-style="caption" hint-align="left">$(Get-Date -Date $Deadline -Format "dd MMMM yyy HH:mm")</text>
            </subgroup>
            <subgroup>
                <text hint-style="base" hint-align="right">Time Remaining  .</text>
                <text hint-style="caption" hint-align="right">$($TimeSpan.Days) days $($TimeSpan.Hours) hours $($TimeSpan.Minutes) minutes  .</text>
            </subgroup>
        </group>
"@
    $ToastTemplate.toast.visual.binding.InnerXml = $ToastTemplate.toast.visual.binding.InnerXml + $DeadlineGroups

}

# Load the notification into the required format
$ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
$ToastXml.LoadXml($ToastTemplate.OuterXml)

# Display
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app).Show($ToastXml)

$RegKey = "HKLM:\SOFTWARE\WOW6432Node\JavaSoft\Java Runtime Environment\1.8.0_181"
If (Test-Path $RegKey)
{
    Write-Output "Compliant"
}
Else
{
    Write-Output "Not compliant"
}