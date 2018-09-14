$softwareScope = Read-Host -Prompt 'Enter the Software Scope (COEDEAN, CCEE, COE, NCSU)'
$Softwarelicense = Read-Host -Prompt 'Is the software SW or FW?'
$SoftwareVendor = Read-Host -Prompt 'Enter the Software Vendor?'
$SoftwareName = Read-Host -Prompt 'Enter the Name of the Software?'
$SoftwareVersion = Read-Host -Prompt 'Enter the Software Version?'
$GroupName = $softwareScope + "-" + $Softwarelicense + "-" + $SoftwareVendor + "-" + $SoftwareName + "-" + $SoftwareVersion
Write-Host $GroupName
If ($softwareScope -eq "COEDEAN")
{
$SoftwareOU = "OU=COEDEAN Software,OU=Software Packages,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
Write-Host "Make computer in COEDEAN" + "-" $SoftwareOU
New-ADGroup -Name $GroupName -Path 'OU=COEDEAN Software,OU=Software Packages,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu' -GroupScope Global -Description "SCCM Mandatory"
}
If ($softwareScope -eq "CCEE")
{
Write-Host "Make computer in CCEE"
New-ADGroup -Name $GroupName -Path 'OU=CCEE Software,OU=Software Packages,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu' -GroupScope Global -Description "SCCM Mandatory"
}
If ($softwareScope -eq "COE")
{
Write-Host "Make computer in COE"
New-ADGroup -Name $GroupName -Path 'OU=Software Packages,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu' -GroupScope Global -Description "SCCM Mandatory"
}
If ($softwareScope -eq "NCSU")
{
Write-Host "Make computer in NCSU"
New-ADGroup -Name $GroupName -Path 'OU=Software Packages,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu' -GroupScope Global -Description "SCCM Mandatory"
}
Else
{
Write-Host "Scope is Invalid"
}