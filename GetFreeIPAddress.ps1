Param(
[Parameter(Mandatory=$true)]
[String]
$ScopeID
)
Get-DhcpServerv4FreeIPAddress -ComputerName DHCP01B -ScopeId $ScopeID