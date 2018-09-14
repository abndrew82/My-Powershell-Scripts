New-CMDeviceCollection -Name "Hackley Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Hackley Hall" -RuleName "HackleyHallOU" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/Hackley Hall'"

New-CMDeviceCollection -Name "Harris Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Harris Hall" -RuleName "HarrisHallOU" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/Harris Hall'"

New-CMDeviceCollection -Name "Hood Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Hood Hall" -RuleName "HoodHallOU" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/Hood Hall'"

New-CMDeviceCollection -Name "Joyner Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Joyner Hall" -RuleName "JoynerHallOU" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/Joyner Hall'"

New-CMDeviceCollection -Name "McLeod Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "McLeod Hall" -RuleName "McLeodHallOU" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/McLeod Hall'"

New-CMDeviceCollection -Name "New Residence Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "New Residence Hall" -RuleName "NewResidenceHall" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/New Residence Hall'"

New-CMDeviceCollection -Name "Renaissance Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Renaissance Hall" -RuleName "RenaissanceHall" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/Renaissance Hall'"

New-CMDeviceCollection -Name "Smith Hall" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Smith Hall" -RuleName "SmithHall" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/Smith Hall'"

New-CMDeviceCollection -Name "UPA" -LimitingCollectionId "FS100117"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "UPA" -RuleName "UPA" -QueryExpression "select SMS_R_SYSTEM.ResourceID,
SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = 'UNCFSU.EDU/FSU/WORKSTATIONS/UPA'"

