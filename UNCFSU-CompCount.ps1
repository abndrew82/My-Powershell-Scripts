$a = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "DC=uncfsu,DC=edu"
$a.count
$b = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "OU=FSU,DC=uncfsu,DC=edu"
$b.count
$c = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "OU=Workstations,OU=FSU,DC=uncfsu,DC=edu"
$c.count