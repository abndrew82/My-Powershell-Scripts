$Computers = Get-Content G:\NoClient.txt
ForEach ($Computer in $Computers)
{
Try {
$Status = Get-ADComputer -Identity $Computer -Properties Enabled | Select -ExpandProperty Enabled
$ADName = Get-ADComputer -Identity $Computer | Select -ExpandProperty DistinguishedName
Write-Host $Computer "|" $Status "|" $ADName
}
Catch {}
}