$Deployments = Get-CMApplicationDeployment -Name 'Python 3.5.0' | Where-Object {$_.OfferTypeID -eq 0} | Select -ExpandProperty CollectionName
ForEach ($Deployment in $Deployments)
{
New-CMApplicationDeployment -Name 'Python 3.6.3' -DeployAction Install -DeployPurpose Required -CollectionName $Deployment
}
