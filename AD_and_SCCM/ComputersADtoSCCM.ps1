$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "CN=Computers,DC=uncfsu,DC=edu" -Properties Name | Select -ExpandProperty Name
ForEach ($Comp in $Comps)
{
$IPAddress = Get-ADComputer -Identity $Comp -Properties IPV4Address | Select -ExpandProperty IPV4Address
$pwdlastset = Get-ADComputer -Identity $Comp -Properties passwordlastset | Select -ExpandProperty passwordlastset
$CMName = Get-CMDevice -Name $Comp | Select -ExpandProperty Name
$CMOnlineTime = Get-CMDevice -Name $Comp | Select -ExpandProperty CNLastOnlineTime
$CMActive = Get-CMDevice -Name $Comp | Select -ExpandProperty IsActive
$CMSMSID = Get-CMDevice -Name $Comp | Select -ExpandProperty SMSID
#Write-Host $Comp "|" $IPAddress "|" $CMName "|" $CMOnlineTime "|" $CMActive "|" $CMSMSID
$Data = $Comp + "|" + $IPAddress + "|" + $pwdlastset + "|" + $CMName + "|" + $CMOnlineTime + "|" + $CMActive + "|" + $CMSMSID
Out-file d:\ComputersOUinSCCM.txt -InputObject $Data -Append
}