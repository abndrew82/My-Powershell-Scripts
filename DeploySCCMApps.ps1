#Get-CMApplication -Name "VLC Player" | New-CMApplicationDeployment -DeployAction Install -DeployPurpose Available -CollectionId "FS100291"
#Get-CMApplication | Select -ExpandProperty LocalizedDisplayName | Out-File C:\Users\asenn\Documents\apps.txt
$Apps = Get-Content C:\Users\asenn\Documents\apps.txt
ForEach ($App in $Apps)
{
New-CMApplicationDeployment -Name $App -DeployAction Install -DeployPurpose Available -CollectionId "FS100292"
}