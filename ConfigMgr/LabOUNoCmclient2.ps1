$LabComps = Get-ADComputer -Filter * -SearchBase "OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
#$ReturnData = @()
ForEach ($LabComp in $LabComps)
{
$CMName = Get-CMDevice -Name $LabComp | Select -ExpandProperty Name
If ($CMName -ne $null)
{
$CMClient = Get-CMDevice -Name $CMName | Select -ExpandProperty IsClient
If ($CMClient -ne $true)
{
$Name = Get-ADComputer -Identity $CMName -Properties Name | Select -ExpandProperty Name
$OS = Get-ADComputer -Identity $CMName -Properties OperatingSystem | select -ExpandProperty OperatingSystem
$PassSet = Get-ADComputer -Identity $CMName -Properties passwordlastset | select -ExpandProperty passwordlastset
$ADLogon = Get-ADComputer -Identity $CMName -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$AllCompInfo = $Name + "|" + $OS + "|" + $PassSet + "|" + $ADLogon
Out-File 'C:\Users\$asenn\Documents\WorkstationOU2.txt' -InputObject $AllCompInfo -Append
}
}
}