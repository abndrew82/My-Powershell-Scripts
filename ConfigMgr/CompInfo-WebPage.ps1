﻿Import-Module "c:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
Set-Location "FS1:"
$Computers = Get-CMDevice -CollectionName "LSA 125" | Select -ExpandProperty Name
$CompsSorted = $Computers | Sort-Object
ForEach ($Computer in $CompsSorted)
{
$i++
$TestConn = Test-Connection -ComputerName $Computer -Count 1 -quiet
If ($TestConn -eq $True)
{
$Status = "Online"
$Memory = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | ForEach-Object {[math]::truncate($_.TotalPhysicalMemory / 1GB)}
$Memory = $Memory + 1
$Memory = "$Memory GB"
$Manufacturer = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | Select -ExpandProperty Manufacturer
$Model = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | Select -ExpandProperty Model
$CompName = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | Select -ExpandProperty Name
$LoggedonUser = Get-WmiObject –ComputerName $Computer –Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
#Write-Host $CompName "|" $Status  "|" $Manufacturer "|" $Model "|" $Memory "|" $LoggedonUser

$CompName + " | " + $Status + " | " + $Memory + " | " + $Manufacturer + " | " + $Model
}
ElseIf ($TestConn -eq $false)
{
$Status = "Offline"
$Computer + " | " + $Status
}
}