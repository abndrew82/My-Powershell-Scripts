$model = GWMI Win32_ComputerSystem | Select -ExpandProperty Model
Write-Host $model
If ($model -like "*Surface Pro 3*")
{
Exit 0
}
If ($model -like "*Surface Pro 4*")
{
exit 0
}
If ($model -like "*Latitude 7275*")
{
exit 0
}
Else
{
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("This is not a Tablet, The Task Sequence will now end")
exit 3443
}