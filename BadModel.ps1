$model = GWMI Win32_ComputerSystem | Select -ExpandProperty Model
Write-Host $model
If ($model -eq "Surface Pro 3" -or "Surface Pro 4" -or "Latitude 7275")
{
exit 0
}
Else
{
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("This is not a Tablet, The Task Sequence will now end")
exit 12345
}