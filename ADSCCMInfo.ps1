Param (
       [parameter(Mandatory=$True,HelpMessage='OU to Search in CN,DC format')]
       [string]$SearchOU = ''
       )
$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "$SearchOU" -Properties Name -Server dc05.uncfsu.edu | Select -ExpandProperty Name
ForEach ($Comp in $Comps)
{
$SCCMActive = Get-CMDevice -Name $Comp | Select -ExpandProperty IsActive
$SCCMID = Get-CMDevice -Name $Comp | Select -ExpandProperty SMSID
$SCCMDate = Get-CMDevice -Name $Comp | Select -ExpandProperty LastActiveTime
$CompIP = Get-ADComputer -Identity $Comp -Properties IPV4Address | Select -ExpandProperty IPV4Address
$CompPW = Get-ADComputer -Identity $Comp -Properties passwordlastset | Select -ExpandProperty passwordlastset
#$AllCompINfo = $Comp + "|" + $CompIP + "|" + $CompPW + "|" + $SCCMActive + "|" + $SCCMID + "|" + $SCCMDate
#Out-File d:\All1SortOUinfo.txt -InputObject $AllCompINfo -Append
#Write-Host $Comp "|" $CompIP "|" $CompPW "|" $SCCMActive "|" $SCCMID "|" $SCCMDate
If ($CompPW -lt '6/1/2013' -and $SCCMActive -eq $null)
{
#Write-Host $Comp "|" $CompIP "|" $CompPW "|" $SCCMActive "|" $SCCMID "|" $SCCMDate
$AllCompINfo = $Comp + "|" + $CompIP + "|" + $CompPW + "|" + $SCCMActive + "|" + $SCCMID + "|" + $SCCMDate
}
}