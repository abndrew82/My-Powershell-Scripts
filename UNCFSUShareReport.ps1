Param (
       [parameter(Mandatory=$True,HelpMessage='Enter Share to get file list from.')]
       [string]$share = '',
       [parameter(Mandatory=$True,HelpMessage='Enter file age in # of days.')]
       [string]$Days = 'No',
       [parameter(Mandatory=$True,HelpMessage='Location to move files to.')]
       [string]$Destination = ''
)
$ReportName = $share -creplace '(?s)^.*\\', ''
$Files = Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)}
ForEach ($File in $Files)
{
$fileandsize = $file.FullName + "|" + $file.Length
Out-File $Destination\$ReportName.txt -InputObject $fileandsize -Append
}
#Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)} | Move-Item -Destination $Destination