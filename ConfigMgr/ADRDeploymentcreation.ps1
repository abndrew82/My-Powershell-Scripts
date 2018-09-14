New-CMSoftwareUpdateAutoDeploymentRuleDeployment -Name "ADR - Windows Update - Misc" -WarningAction
-CollectionName "Cook Building" -AvailableTime 3 -AvailableTimeUnit Days -DeadlineImmediately $true`
-WriteFilterHandling $true

-AlertTime 4 -AlertTimeUnit .\Driver

$Schedule = New-CMSchedule -DayOfWeek Wednesday
New-CMSoftwareUpdateAutoDeploymentRule -CollectionName "Laptops" -DeploymentPackageName "Updates235"`
-Name "DeploymentRule22" -AddToExistingSoftwareUpdateGroup $False -AlertTime 4 -AlertTimeUnit Weeks`
-AllowRestart $True -AllowSoftwareInstallationOutsideMaintenanceWindow $True -AllowUseMeteredNetwork $True`
-ArticleId "test" -AvailableImmediately $False -AvailableTime 5 -AvailableTimeUnit Months -CustomSeverity Critical`
-DateReleasedOrRevised Last1day -DeadlineImmediately $False -DeadlineTime $True -DeadlineTimeUnit Hours`
-DeployWithoutLicense $True -Description "Standard updates for our laptop systems." -DisableOperationManager $True`
-DownloadFromInternet $False -DownloadFromMicrosoftUpdate $True -EnabledAfterCreate $False -GenerateOperationManagerAlert $True`
-GenerateSuccessAlert $True -Language "Catalan" -LanguageSelection "English" -Location "\\k\aS_O15_Client_Dev_1"`
-MicrosoftAsVendor $True -NoInstallOnRemote $False -NoInstallOnUnprotected $True -RunType RunTheRuleOnSchedule -Schedule $Schedule`
-SendWakeUpPacket $True -SuccessPercent 99 -Superseded $True -SuppressRestartServer $True -SuppressRestartWorkstation $True`
-UpdateClassification "Critical Updates" -UseBranchCache $False -UserNotification DisplayAll -UseUtc $True -VerboseLevel AllMessages -WriteFilterHandling $True