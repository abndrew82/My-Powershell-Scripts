$DomainName = "uncfsu"
$groupname = '$jlbaker01'
$AdminGroup = [ADSI]"WinNT://$Env:COMPUTERNAME/Administrators,group"
$Group = [ADSI]"WinNT://$DomainName/$groupname,user"
$AdminGroup.Add($Group.Path)

$username = '$jlbaker01'
$group = [ADSI]("WinNT://"+$env:COMPUTERNAME+"/administrators,group")
$group.add("WinNT://$env:USERDOMAIN/$username,user")