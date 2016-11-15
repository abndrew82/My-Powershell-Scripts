$ErrorActionPreference = "SilentlyContinue"
$AllComps = get-adcomputer -Filter {ObjectClass -Like "Computer"} -SearchBase 'OU=Workstations,OU=FSU,DC=uncfsu,DC=edu' | Select -ExpandProperty Name
ForEach ($comp in $AllComps)
{
$Name = Get-ADComputer $comp -Properties Name | Select -ExpandProperty Name
$IP = Get-ADComputer $comp -Properties IPV4Address | Select -ExpandProperty IPV4Address
If ($ip -like "10.132.0.148")
{
Write-Host $Name "|" $IP
}
} 

