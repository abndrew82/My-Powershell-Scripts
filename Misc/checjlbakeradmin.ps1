$Admins = Get-CimInstance -ClassName win32_group -Filter "name = 'administrators'" | Get-CimAssociatedInstance -Association win32_groupuser | Select -ExpandProperty Caption
If ($Admins -notcontains 'UNCFSU\$jlbaker01')
{
Return $false
}
Else
{
Return $true
}
