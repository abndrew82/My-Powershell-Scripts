Param (
       [parameter(Mandatory=$True,HelpMessage='Enter Share to get file list from.')]
       [string]$Share = '',
       [parameter(Mandatory=$True,HelpMessage='Enter file age in # of days.')]
       [string]$Days = 'No',
       [parameter(Mandatory=$True,HelpMessage='Location to move files to.')]
       [string]$Destination = '',
       [parameter(Mandatory=$True,HelpMessage='Move files after generating Report (Yes/No)')]
       [string]$Move = ''
)
$ErrorActionPreference = "SilentlyContinue"
$ReturnData = @()
$ReportName = $Share -creplace '(?s)^.*\\', ''
$Files = Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)}
ForEach ($File in $Files)
{
If ($ReportName -eq "$null")
{
$ReportName = "UNCFSUShareDefault"
}
If ($file.Length -ge "1024")
{
$filesize = $file.Length/1MB
}
$fileandsize = $file.FullName + "|" + $file.LastAccessTime + "|" + $filesize
Out-File $Destination\$ReportName.txt -InputObject $fileandsize -Append
$ReturnData += New-Object PSObject -Property @{File=$File; LastAccessTime=$File.LastAccessTime; FileSize=$filesize; FullPath=$file.FullName}
}
If ($Move -eq "Yes")
{
Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)} | Move-Item -Destination $Destination
}
$ReturnData | Select File, LastAccessTime, FileSize, FullPath| Sort-Object FileSize -Descending | Out-GridView