$Computers = Get-Content D:\compsloggedon.txt
ForEach ($Comp in $Computers)
{
$LoggedonUser = Get-WmiObject –ComputerName $Comp –Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
Write-Host $Comp "|" $LoggedonUser
}