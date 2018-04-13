$Comps = Get-Content 'c:\Users\$asenn\Desktop\NoClientComps.txt'
$ReturnData = @()
ForEach ($Computer in $Comps)
{
$Name = Get-ADComputer -Identity $Computer -Properties Name | Select -ExpandProperty Name
$IP = Get-ADComputer -Identity $Computer -Properties IPV4Address | select -ExpandProperty IPV4Address
$OS = Get-ADComputer -Identity $Computer -Properties OperatingSystem | select -ExpandProperty OperatingSystem
$PassSet = Get-ADComputer -Identity $Computer -Properties passwordlastset | select -ExpandProperty passwordlastset
$ADLogon = Get-ADComputer -Identity $Computer -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$TestConn = Test-Connection -ComputerName $Computer -Count 2 -Quiet
#Write-Host $Name "|" $IP "|" $OS "|" $PassSet "|" $ADLogon
$SCCM = Get-CMDevice -Name $Computer | Select -ExpandProperty Name
If ($SCCM -ne $null)
{
$InSCCM = "True"
}
Else
{
$InSCCM = "False"
}
$ReturnData += New-Object psobject -Property @{"Computer Name" = $Name; "AD IP" = $IP; "AD Password Set" = $PassSet; "AD Last Logon" = $ADLogon; "Operating System" = $OS; "Pingable" = $TestConn; "In SCCM" = $InSCCM; "SCCM Name" = $SCCM}
}
$ReturnData | Select "Computer Name", "AD IP", "AD Password Set", "Operating System", "AD Last Logon", "Pingable", "In SCCM", "SCCM Name" | Sort-Object "Computer Name" | Out-GridView