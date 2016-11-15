$a = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "CN=Computers,DC=uncfsu,DC=edu" -Properties * | Select -ExpandProperty Name
ForEach ($b in $a)
{
Write-Host $b
}