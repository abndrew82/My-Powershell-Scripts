$Computers = Get-ADComputer -Filter * -SearchBase "OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
ForEach ($Computer in $Computers)
{
If ($Computer -like "FSU*I*" -or $Computer -Like "FSU*D*" -or $Computer -Like "FSU*G*")
{
#Write-Host $Computer
$FSUTag = $Computer.Substring(3,5)
Write-Host $Computer "|" $FSUTag
}
}