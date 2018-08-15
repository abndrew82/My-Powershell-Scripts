$Files = Get-ChildItem 'Q:\Scripts\OS Upgrade Notifications' | Select -ExpandProperty Name
ForEach ($File in $Files)
{
$SciptFolder = "Q:\Scripts\OS Upgrade Notifications"
$Path = $SciptFolder + "\" + $File
$Newname = $File + ".bak"
Rename-Item -Path $Path -NewName $Newname
}
