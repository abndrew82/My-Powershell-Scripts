$Comps = Get-CMDevice -CollectionName "Windows 7 x86" | Select -ExpandProperty Name
ForEach ($Comp in $Comps)
{
$Compname = Get-ADComputer -Identity $Comp -Properties ms-Mcs-AdmPwd | Select -ExpandProperty Name
$PW = Get-ADComputer -Identity $Comp -Properties ms-Mcs-AdmPwd | Select -ExpandProperty ms-Mcs-AdmPwd
Write-host $Compname "|" $PW
}