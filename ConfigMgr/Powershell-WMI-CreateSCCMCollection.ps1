$CMCOllection = ([WMIClass]"\\fsusccm\root\SMS\Site_FS1:SMS_Collection").CreateInstance()
#$CMCOllection | Get-Member
$CMCOllection.Name = "Cook Windows 10"
$CMCOllection.Comment = "Test Collection Creation with WMI PS"
$CMCOllection.LimitToCollectionID = "FS100119"
$CMCOllection.RefreshType = 2
$CMCOllection.Put()
$CMRule = ([WMIClass]”\\fsusccm\root\sms\site_FS1:SMS_CollectionRuleQuery”).CreateInstance()
#$CMRule | Get-Member
$CMRule.QueryExpression=”select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_OPERATING_SYSTEM on SMS_G_System_OPERATING_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_G_System_OPERATING_SYSTEM.Caption Like `"%Windows 10%`"”
$CMRule.RuleName = “Cook Windows 10”
$CMCollection.AddMembershipRule($CMRule)
$CMSchedule = ([WMIClass]"\\fsusccm\Root\sms\site_FS1:SMS_ST_RecurInterval").CreateInstance()
$CMSchedule.DaySpan = “1”
$CMSchedule.StartTime = [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime((Get-Date).ToString())
$CMCollection.RefreshSchedule=$CMSchedule
$CMCollection.Put()