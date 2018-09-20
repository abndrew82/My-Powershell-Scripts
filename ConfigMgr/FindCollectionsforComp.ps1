$Collections = (Get-WmiObject -ComputerName fsusccm  -Namespace root/SMS/site_FS1 -Query "SELECT SMS_Collection.* FROM SMS_FullCollectionMembership, SMS_Collection where name = 'FSU27524s' and SMS_FullCollectionMembership.CollectionID = SMS_Collection.CollectionID").Name
ForEach ($Collection in $Collections)
{
Write-Host $Collection
}