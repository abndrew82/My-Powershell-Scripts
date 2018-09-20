$Scopes = Get-DhcpServerv4Scope -ComputerName DHCP01B | Select -ExpandProperty ScopeID
ForEach ($Scope in $Scopes)
{
$Policy = Get-DhcpServerv4Policy -ComputerName DHCP01B -ScopeId $Scope | Where-Object {$_.Name -like "*Right File*"} | Select -ExpandProperty Name
Foreach ($pol in $Policy)
{
If ($Policy -ne $null)
{
Write-Host $Scope "| Policy already exists"
}
Elseif ($pol -eq $null)
{
Write-Host $Scope "| Policy DOES NOT EXIST"
}
}
}

