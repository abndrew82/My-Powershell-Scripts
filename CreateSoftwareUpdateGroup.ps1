$Updates = Get-Content D:\Update-CatchUp\Office-Batch2.txt
ForEach ($Update in $Updates)
{
Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Office Batch 2" -SoftwareUpdateName $Update
}