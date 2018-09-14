Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Push-Location WUF:
$a = Get-CMDeviceCollection | Select -ExpandProperty Name
ForEach ($b in $a)
{
If ($b -like "*COEDEAN*")
{
#Write-Host $b
#Out-File C:\Users\apsenn.admin\Desktop\Powershell-Out\Collections.txt -InputObject $b -Append | sort Name
$CollectName = Get-CMDeviceCollection -Name $b | Select -ExpandProperty Name
$collectMemb = Get-CMDeviceCollection -Name $b | Select -ExpandProperty LocalMemberCount
#Write-Host $CollectName "|" $collectMemb
If ($collectMemb -lt "1")
{Write-Host $CollectName "|" $collectMemb}
}
}