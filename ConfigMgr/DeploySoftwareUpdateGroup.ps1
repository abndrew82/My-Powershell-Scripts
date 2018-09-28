$date = Get-Date
$date.ToLongDateString()
Write-Host $date
New-CMSoftwareUpdateDeployment -SoftwareUpdateGroupName "3rd Party Baseline Updates" -DeploymentName "3rd Party Updates TestPS"`
-DeploymentType Required -TimeBasedOn LocalTime -UserNotification DisplaySoftwareCenterOnly -AllowRestart $true -RestartWorkstation $true `
-CollectionId "FS1003E9" -DeadlineDateTime $date -AvailableDateTime $date -SoftwareInstallation $true