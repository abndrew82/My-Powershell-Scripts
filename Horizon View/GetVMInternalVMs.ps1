Get-ADComputer -Filter * -SearchBase "OU=Virtual Desktops,OU=FSU,DC=uncfsu,DC=edu" -Properties Description | Where-Object {$_.Description -like "*Internal*"} | Select-Object Name, DistinguishedName, Description
$InternalCount = Get-ADComputer -Filter * -SearchBase "OU=Virtual Desktops,OU=FSU,DC=uncfsu,DC=edu" -Properties Description | Where-Object {$_.Description -like "*Internal*"} | Select-Object Name, DistinguishedName
$InternalCount.Count
Connect-VIServer view-st -User 'uncfsu\$asenn' -Password "****"
Get-vm -Server view-st | Where-Object {$_.Name -like "*template*"} | Select -ExpandProperty Name
Connect-VIServer view-bt -User 'uncfsu\$asenn' -Password "****"
Get-vm -Server view-bt | Where-Object {$_.Name -like "*template*"} | Select -ExpandProperty Name

