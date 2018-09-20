$Scopes = Get-DhcpServerv4Scope -ComputerName dhcp01b | Select -ExpandProperty ScopeId
ForEach ($SCope in $Scopes)
{
Get-DhcpServerv4Lease -ComputerName dhcp01b -ScopeId $SCope -ClientId 00-50-56-B8-3D-72 -ErrorAction SilentlyContinue
}