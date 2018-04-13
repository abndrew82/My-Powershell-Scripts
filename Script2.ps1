$Comps = Get-ADComputer -Filter * -SearchBase 'OU=Workstations,OU=FSU,DC=uncfsu,DC=edu' | Select -ExpandProperty Name
$ReturnData = @()
ForEach ($Comp in $Comps)
{
$SCCMComp = Get-CMDevice -Name $Comp | Select -ExpandProperty Name
If ($SCCMComp -ne $Comp)
{
$Name = Get-ADComputer -Identity $Comp -Properties Name | Select -ExpandProperty Name
$IP = Get-ADComputer -Identity $Comp -Properties IPV4Address | select -ExpandProperty IPV4Address
$OS = Get-ADComputer -Identity $Comp -Properties OperatingSystem | select -ExpandProperty OperatingSystem
$PassSet = Get-ADComputer -Identity $Comp -Properties passwordlastset | select -ExpandProperty passwordlastset
$ADLogon = Get-ADComputer -Identity $Comp -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$TestConn = Test-Connection -ComputerName $Comp -Count 2 -Quiet
#Write-Host $Name "|" $IP "|" $OS "|" $PassSet "|" $ADLogon
$ReturnData += New-Object psobject -Property @{"Computer Name" = $Name; "AD IP" = $IP; "AD Password Set" = $PassSet; "AD Last Logon" = $ADLogon; "Operating System" = $OS; "Pingable" = $TestConn}
}
}
$ReturnData | Select "Computer Name", "AD IP", "AD Password Set", "Operating System", "AD Last Logon", "Pingable" | Sort-Object "Computer Name" | Out-GridView
