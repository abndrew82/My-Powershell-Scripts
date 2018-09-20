$groups = Get-Content C:\Scripts\UserGroups.txt
$ErrorActionPreference = "SilentlyContinue"
FOREACH ($group in $groups)
{
$groupmembers = Get-ADGroupMember -Identity $group
FOREACH ($groupmember in $groupmembers)
{
Get-ADUser -Identity $groupmember -Properties Name,GivenName,Surname | Select Name,GivenName,Surname | Export-Csv C:\Scripts\userfoldertest\$group.csv -Append
}
}
