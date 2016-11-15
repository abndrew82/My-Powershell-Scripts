$a = Get-Content D:\Share\softwareshares2.txt
ForEach ($path in $a)
{
$FolderSize = Get-ChildItem $path | Measure-Object -Sum length  #Get folder size
$FolderSizebytes = “{0:N}” -f $FolderSize.sum #Format size
$FolderSizeMB = $FolderSize.sum/1MB #convert size to MB
$FolderSizeMB = “{0:N2}” -f $FolderSizeMB #Format MB size to 2 digital after point
Write-Host $path "|" $FolderSizeMB
}
