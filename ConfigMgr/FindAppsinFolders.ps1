$FolderID = 16778492
$Instancekeys = (Get-WmiObject -ComputerName FSUSCCM -Namespace "ROOT\SMS\Site_FS1" -query "select InstanceKey from SMS_ObjectContainerItem where ObjectType='6000' and  ContainerNodeID='$FolderID'").instanceKey
foreach ($key in $Instancekeys)
{
(Get-WmiObject -ComputerName FSUSCCM -Namespace "ROOT\SMS\Site_FS1" -Query "select * from SMS_Applicationlatest  where ModelName = '$key'").LocalizedDisplayName
}