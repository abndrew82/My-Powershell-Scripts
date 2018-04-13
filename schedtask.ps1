$action = New-ScheduledTaskAction -Execute 'D:\Dashboard\Dashboard.exe'
$trigger =  New-ScheduledTaskTrigger -Daily -At 7am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Dashboard Update" -Description "Comp Count Dashboard Update"