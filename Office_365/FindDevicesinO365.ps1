#Get-MsolUser -User "_Device_1QMCSW1@broncosuncfsu.onmicrosoft.com" | Where-Object {$_.isLicensed -eq $false}
$Devices = Get-MsolUser -All | Where-Object {$_.DisplayName -like "_Device_*"} | Select -ExpandProperty DisplayName
$Devices.count