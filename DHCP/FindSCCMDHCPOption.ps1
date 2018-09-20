$Scopes = Get-DhcpServerv4Scope -ComputerName dhcp01b | Select -ExpandProperty ScopeID 
ForEach ($Scope in $Scopes)
{
$CheckforValue = Get-DhcpServerv4OptionValue -ComputerName dhcp01b -ScopeId $Scope | Where-Object {$_.Name -eq "Boot Server Host Name"} | Select -ExpandProperty Value
If ($CheckforValue -eq "10.4.3.16")
{

$ServerName = Get-DhcpServerv4OptionValue -ComputerName dhcp01b -ScopeId $Scope | Where-Object {$_.Name -eq "Boot Server Host Name"} | Select -ExpandProperty Name
$FileName = Get-DhcpServerv4OptionValue -ComputerName dhcp01b -ScopeId $Scope | Where-Object {$_.Name -eq "BootFile Name"} | Select -ExpandProperty Name
$NameValue = Get-DhcpServerv4OptionValue -ComputerName dhcp01b -ScopeId $Scope | Where-Object {$_.Name -eq "Boot Server Host Name"} | Select -ExpandProperty Value
$ServerValue = Get-DhcpServerv4OptionValue -ComputerName dhcp01b -ScopeId $Scope | Where-Object {$_.Name -eq "BootFile Name"} | Select -ExpandProperty Value

Write-Host $Scope "|" $ServerName "|" $NameValue "|" $FileName "|" $ServerValue
}
}