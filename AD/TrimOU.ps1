$Compname = hostname
$CompOU = Get-ADComputer -Identity $Compname | Select -ExpandProperty DistinguishedName
$DestOU = "OU=Cook Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu"
#Write-Host $CompOU
$Compname.Length
$ToTrim = "CN=" + $Compname + ","
$TrimAmount = $ToTrim.Length
$OU = $CompOU.Substring($TrimAmount)
Write-Host $OU
If ($OU -eq $DestOU)
{
Write-Host "Yay already in right OU"
}
Else
{
Write-Host "Need to Move AD Object"
Move-ADObject -Identity $Compname -
}