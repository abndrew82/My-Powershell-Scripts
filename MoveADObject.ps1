$Compname = hostname
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$DestOU = $tsenv.Value("MachineObjectOU")
$CompOU = Get-ADComputer -Identity $Compname | Select -ExpandProperty DistinguishedName
$ToTrim = "CN=" + $Compname + ","
$TrimAmount = $ToTrim.Length
$OU = $CompOU.Substring($TrimAmount)
Write-Host $OU
If ($OU -eq $DestOU)
{
exit 0
}
Else
{
Move-ADObject -Identity $Compname -TargetPath $DestOU
}
