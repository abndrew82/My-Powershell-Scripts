$a = Get-CMAdministrativeUser | Select -ExpandProperty LogonName
ForEach ($b in $a)
{
$c = Get-CMAdministrativeUser -Name $b | Select -ExpandProperty CollectionNames
Write-Host $b "|" $c
}
