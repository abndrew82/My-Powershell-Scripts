$Models = Get-Content C:\hpmodels.txt
ForEach ($Model in $Models)
{
New-CMDeviceCollection -Name $Model -LimitingCollectionName "All HPs"
$Schedule = New-CMSchedule -Start "01/01/2016 11:00 PM" -RecurInterval Days -RecurCount 1
Set-CMDeviceCollection -Name $Model -RefreshSchedule $Schedule -RefreshType Periodic
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Model -RuleName $Model -QueryExpression "Select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceID = SMS_R_System.ResourceId where SMS_G_System_COMPUTER_SYSTEM.Model = '$Model'"
}
