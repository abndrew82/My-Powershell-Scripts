$a = Get-ADComputer -Filter * -SearchBase "OU=Cook Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select Name
$a.count
