$ErrorActionPreference = "SilentlyContinue"
Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1' # Import the ConfigurationManager.psd1 module 
Set-Location 'FS1:' # Set the current location to be the site code.
$Comps = Get-CMDeviceCollectionDirectMembershipRule -CollectionName "NoClient" | Select -ExpandProperty RuleName
ForEach ($Comp in $Comps)
{
$TestConn = Test-Connection -ComputerName $Comp -Count 2 -Quiet
$CompIP = Get-ADComputer -Identity $Comp -Properties IPV4Address | Select -ExpandProperty IPV4Address
$CompPW = Get-ADComputer -Identity $Comp -Properties passwordlastset | Select -ExpandProperty passwordlastset
$complastlogon = Get-ADComputer -Identity $Comp -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$AllCompINfo = $Comp + "|" + $CompIP + "|" + $CompPW + "|" + $complastlogon + "|" + $TestConn
Write-Host $Comp + "|" + $CompIP + "|" + $CompPW + "|" + $complastlogon + "|" + $TestConn
Out-File c:\windows\temp\Output.txt -InputObject $AllCompINfo -Append
}