$a = Get-Content D:\xtender.txt
ForEach ($comp in $a)
{
$AssetTag = Get-WmiObject -ComputerName $Comp -Class Win32_SystemEnclosure | Select -ExpandProperty SMBIOSASSETTAG
$NewName = "FSU" + $AssetTag + "D"
Write-Host $Comp "|" $AssetTag "|" $NewName
#Rename-Computer -ComputerName $Comp -NewName $NewName -WhatIf
}