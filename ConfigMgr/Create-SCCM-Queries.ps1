$AllDells = Get-Content F:\share\10builds.txt
ForEach ($Dell in $AllDells)
{
New-CMQuery -Name $Dell -Expression "select SMS_R_System.Name, SMS_G_System_COMPUTER_SYSTEM.Model,` 
SMS_G_System_OPERATING_SYSTEM.Caption, SMS_G_System_OPERATING_SYSTEM.Version, SMS_G_System_OPERATING_SYSTEM.BuildNumber from  SMS_R_System`
inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceID = SMS_R_System.ResourceId`
inner join SMS_G_System_OPERATING_SYSTEM on SMS_G_System_OPERATING_SYSTEM.ResourceID = SMS_R_System.ResourceId`
where SMS_G_System_OPERATING_SYSTEM.Caption like '%$Dell%'`
order by SMS_R_System.Name" -TargetClassName "SMS_R_System"
}
