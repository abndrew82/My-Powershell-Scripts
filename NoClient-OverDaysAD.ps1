$Devices = Get-CMDevice -CollectionName "No Client Comps - For Automation" | Select -ExpandProperty Name
$Devices.count
ForEach ($Device in $Devices)
{
$Today = (Get-Date)
$ADLogonDate = Get-ADComputer -Identity $Device -Properties lastLogondate | Select -ExpandProperty lastLogondate
$LogonDiff = $Today - $ADLogonDate
If ($LogonDiff -gt "120")
{
Write-Host $Device "|" $LogonDiff
}
}
