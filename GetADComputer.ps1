##Get List of Comps
$Laptops = Get-Content C:\Users\apsenn.admin\Downloads\mymobiledevices.txt
ForEach ($Computer in $Laptops)
{
Get-ADComputer -Identity $Computer -Properties * | select Location
}