$Computers = Get-CMDevice | Select -ExpandProperty Name
ForEach ($Comp in $Computers)
{
Try {
$ADINfo = Get-ADComputer -Identity $Comp -Properties CanonicalName | Select -ExpandProperty CanonicalName
#Write-Host $Comp "|" $ADINfo
}
Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
{
Write-Host "$Comp not in AD"
}
}