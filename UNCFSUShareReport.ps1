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
$ReportName = $Share -creplace '(?s)^.*\\', ''
$Files = Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)}
ForEach ($File in $Files)
{
If ($ReportName -eq "$null")
{
$ReportName = "UNCFSUShareDefault"
}
$filesize = $file.Length/1MB
$fileandsize = $file.FullName + "|" + $file.LastAccessTime + "|" + $filesize
Out-File $Destination\$ReportName.txt -InputObject $fileandsize -Append
}
If ($Move -eq "Yes")
{
Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)} | Move-Item -Destination $Destination
}
