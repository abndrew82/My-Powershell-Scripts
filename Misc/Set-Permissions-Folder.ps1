$Acl = Get-Acl F:\TestPermissions
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("Authenticated Users","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl F:\TestPermissions $Acl