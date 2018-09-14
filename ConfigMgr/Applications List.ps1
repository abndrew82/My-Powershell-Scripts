$Apps = Get-CMApplication | Select -ExpandProperty LocalizedDisplayName
$ErrorActionPreference = "SilentlyContinue"
$ReturnData = @()
ForEach ($App in $Apps)
{
$SoftwareVersion = Get-CMApplication -Name $App | Select -ExpandProperty SoftwareVersion
$NumberOfDeployments = Get-CMApplication -Name $App | Select -ExpandProperty NumberOfDeployments
$NumberOfDeploymentTypes = Get-CMApplication -Name $App | Select -ExpandProperty NumberOfDeploymentTypes
$NumberOfDevicesWithApp = Get-CMApplication -Name $App | Select -ExpandProperty NumberOfDevicesWithApp
$NumberOfDevicesWithFailure = Get-CMApplication -Name $App | Select -ExpandProperty NumberOfDevicesWithFailure
$ReturnData += New-Object PSObject -Property @{SoftwareName=$App; SoftwareVersion=$SoftwareVersion; NumberofDeployments=$NumberOfDeployments; NumberofDeploymentTypes=$NumberOfDeploymentTypes;
NumberofDevicesWithApp=$NumberOfDevicesWithApp; NumberofDevicesWithFailure=$NumberOfDevicesWithFailure}
#Write-Host $App "|" $SoftwareVersion "|" $NumberOfDeployments "|" $NumberOfDeploymentTypes "|" $NumberOfDevicesWithApp "|" $NumberOfDevicesWithFailure
}
$ReturnData | Select SoftwareName, SoftwareVersion, NumberofDeployments, NumberofDeploymentTypes, NumberofDevicesWithApp, NumberofDevicesWithFailure| Out-GridView