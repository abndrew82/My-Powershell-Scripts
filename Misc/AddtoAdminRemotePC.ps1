$Comps = Get-Content \\fsu27524s\share\fspersist.txt
ForEach ($ComputerName in $Comps)
{
$DomainName = "uncfsu"
#$ComputerName = Read-Host "Computer name:"
$groupname = "ITS"
$AdminGroup = [ADSI]"WinNT://$ComputerName/Administrators,group"
$Group = [ADSI]"WinNT://$DomainName/$groupname,group"
$AdminGroup.Add($Group.Path)
}