$ErrorActionPreference = "SilentlyContinue"
$Computers = Get-CMDevice -CollectionId "FS100146" | Select -ExpandProperty Name | Sort-Object Name
ForEach ($Comp in $Computers)
{
$LoggedonUser = Get-WmiObject –ComputerName $Comp –Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
Write-Host $Comp "|" $LoggedonUser
}