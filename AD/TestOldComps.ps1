$ErrorActionPreference = "SilentlyContinue"
$ReturnData = @()
#Get Members of the Group recursivly to pull all computers in the groups
$AllComps = get-adcomputer -Filter {ObjectClass -Like "Computer"} -SearchBase 'OU=Workstations,OU=FSU,DC=uncfsu,DC=edu' | Select -ExpandProperty Name
#For Each computer get Computer Name and IP Address, OS, and Check if Old AD Record and output that to a txt file
ForEach ($Computer in $AllComps)
{
$PassSet = Get-ADComputer -Identity $Computer -Properties passwordlastset | select -ExpandProperty passwordlastset
$ADLogon = Get-ADComputer -Identity $Computer -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
If ($ADLogon -lt '3/21/2016')
{
$Name = Get-ADComputer -Identity $Computer -Properties Name | Select -ExpandProperty Name
$IP = Get-ADComputer -Identity $Computer -Properties IPV4Address | select -ExpandProperty IPV4Address
$OS = Get-ADComputer -Identity $Computer -Properties OperatingSystem | select -ExpandProperty OperatingSystem
$ADLogon = Get-ADComputer -Identity $Computer -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
#$ReturnData += New-Object psobject -Property @{"Computer Name" = $Name; "AD IP" = $IP; "AD Password Set" = $Pass; "Operating System" = $OS}
Write-Host $Name "|" $IP "|" $PassSet "|" $OS "|" $ADLogon
}
#$ReturnData | Select "Computer Name", "AD IP", "AD Password Set", "Operating System" | Sort-Object "Computer Name" | Out-GridView
}

