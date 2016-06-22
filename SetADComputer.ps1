##Get List of Comps
$Laptops = Get-Content C:\Users\apsenn.admin\Downloads\mymobiledevices.txt
ForEach ($Computer in $Laptops)
{
Set-ADComputer -Identity $Computer -Location "Mobile Test"
}