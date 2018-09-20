$ErrorActionPreference = "SilentlyContinue"
$OUs = Get-Content C:\Users\asenn\Documents\OUs.txt
ForEach ($OU in $OUs)
{
#Write-Host $OU
$SCCM = Get-CMDevice -CollectionName $OU | Select -ExpandProperty Name
$AD =Get-ADComputer -Filter * -SearchBase "OU=$OU,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
Compare-Object $SCCM $AD
}


