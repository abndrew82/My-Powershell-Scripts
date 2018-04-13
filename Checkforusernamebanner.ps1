#Get-ADUser -Filter {(sn -eq "Senn") -and (GivenName -eq "Andrew")}
$Surname = "Senn"
$FirstName = "Andrew"
$MiddleInitial = "J"
$bannerNumber = "830039039"
$User = Get-ADUser -Filter {(sn -eq $Surname) -and (GivenName -eq $FirstName) -and (extensionAttribute2 -eq $bannerNumber)} | select -ExpandProperty SamAccountName
#Get-ADUser -LDAPFilter "(sAMAccountName=$Name)"
If ($User -eq $Null) {"User does not exist in AD"}
Else {"User found in AD"}