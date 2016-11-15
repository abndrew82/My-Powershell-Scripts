Param (
       [parameter(Mandatory=$True,HelpMessage='Collection Name')]
       [string]$CollName = ''
       )
$ErrorActionPreference = "SilentlyContinue"
$alldeployments = Get-CMDeployment -CollectionName $CollName | Select -ExpandProperty ApplicationName
ForEach ($deployment in $alldeployments)
{
Remove-CMDeployment -ApplicationName $deployment -CollectionName $CollName -Force
Write-Host $deployment
}