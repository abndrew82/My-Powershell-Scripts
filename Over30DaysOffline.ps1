Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location FS1:\
$Devices = Get-CMDevice -CollectionName "Clients | No" | Select-Object -ExpandProperty Name
ForEach ($Device in $Devices)
{
$DeviceInfo = Get-CMDevice -Name $Device
$Today = (Get-Date)

If ($DeviceInfo.CNLastOfflineTime -eq $null)
{
$OffDiff = "SCCM Data Lost"
$DeviceName = $DeviceInfo.Name
Write-Host "$DeviceName has been offline for 30 or more days : $OffDiff"
}

Else
{
$LastOffline = $DeviceInfo.CNLastOfflineTime
$OffDiff =  $Today - $LastOffline
$OffDiff = $OffDiff.Days
If ($Offdiff -ge "30")
{
$DeviceName = $DeviceInfo.Name
Write-Host "$DeviceName has been offline for 30 or more days : $OffDiff"
}
}
}