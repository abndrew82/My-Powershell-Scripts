##Get List of Comps from AD Group
$Laptops = Get-ADGroupMember COEDEAN-EOnline.Laptops
ForEach ($Computer in $Laptops)
{
Get-ADComputer -Identity $Computer -Properties * | select Name, Location, IPv4Address
}