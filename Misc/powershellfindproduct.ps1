GWMI -Class Win32_Product | Where {$_.Name -like "*Microsoft Office Professional Plus 2013*"} | Select -ExpandProperty Version | Out-File $env:temp\OfficeVersion.txt
$OfficeVersion = Get-Content $env:temp\OfficeVersion.txt
Try
{
If ($OfficeVersion -eq "15.0.4569.1506")
{
return $true;
}
}
Catch 
{
return $false
}