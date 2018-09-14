Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Push-Location WUF:
$a = Get-CMResource -Fast
ForEach ($b in $a)
{
If ($b.name -like "*bus*" -and $b.ClientVersion -ne "5.00.8239.1203")
#{Write-Host $b.Name "|" $b.ResourceId}
{
Write-Host $b.name
}
}