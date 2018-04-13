$SecureWifiScopes = Get-DhcpServerv4Scope -ComputerName dhcp01b | Where-Object {$_.Name -eq "DMZ"} | Select -ExpandProperty Name
ForEach ($SecureWifiScope in $SecureWifiScopes)
{
$StartIP = Get-DhcpServerv4Scope -ComputerName "dhcp01b.uncfsu.edu" | Where-Object {$_.Name -eq $SecureWifiScope} | Select -ExpandProperty StartRange
$EndIP = Get-DhcpServerv4Scope -ComputerName "dhcp01b.uncfsu.edu" | Where-Object {$_.Name -eq $SecureWifiScope}  | Select -ExpandProperty EndRange
New-CMBoundary -Name $SecureWifiScope -Type IPRange -Value "$StartIP-$EndIP"
}
