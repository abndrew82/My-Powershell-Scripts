Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location FS1:
$SecureWifiScopes = Get-DhcpServerv4Scope -ComputerName dhcp01b | Where-Object {$_.Name -eq "Smith_Admin"} | Select -ExpandProperty Name
ForEach ($SecureWifiScope in $SecureWifiScopes)
{
$StartIP = Get-DhcpServerv4Scope -ComputerName "dhcp01b.uncfsu.edu" | Where-Object {$_.Name -eq $SecureWifiScope} | Select -ExpandProperty StartRange
$EndIP = Get-DhcpServerv4Scope -ComputerName "dhcp01b.uncfsu.edu" | Where-Object {$_.Name -eq $SecureWifiScope}  | Select -ExpandProperty EndRange
New-CMBoundary -Name $SecureWifiScope -Type IPRange -Value "$StartIP-$EndIP"
}
