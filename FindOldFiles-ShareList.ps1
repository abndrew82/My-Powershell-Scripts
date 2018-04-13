$Shares = Get-Content 'C:\Users\$asenn\Documents\testshares.txt'
ForEach ($Share in $Shares)
{
#Write-Host \\fsustorage\dept\$share
$ReturnData = @()
$Destination = "C:\Shares"
$days = "12/31/2014 23:59:59"
$SharePath = "\\fsustorage\" + $Share
$Files = Get-ChildItem -Path $SharePath -Recurse -Exclude "Project Management" | Where-Object {$_.LastAccessTime -gt $days}
#$Files.lastaccesstime
ForEach ($File in $Files)
{
$fileandsize = $file.FullName + "|" + $file.LastAccessTime + "|" + $filesize
#Write-Host $fileandsize
Out-File $Destination\$share.txt -InputObject $fileandsize -Append
$ReturnData += New-Object PSObject -Property @{File=$File; LastAccessTime=$File.LastAccessTime; FileSize=$filesize; FullPath=$file.FullName}
}
$ReturnData | Select File, LastAccessTime, FileSize, FullPath| Sort-Object FileSize -Descending | Out-GridView
}
