#Get Members of the Group recursivly to pull all computers in the groups
$AllComps = Get-ADGroupMember COEDEAN-ITECS.Computers -Recursive | Select -ExpandProperty Name
#For Each computer get Computer Name and IP Address, and output that to a txt file
ForEach ($Computer in $AllComps)
{
$Name = Get-ADComputer -Identity $Computer -Properties * | Select -ExpandProperty Name
$IP = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty IPV4Address
#Write-Host $Name " | " $IP
$Compinfo = $Name + " | " + $IP
Out-File -InputObject $Compinfo C:\Users\apsenn.admin\Desktop\ITECSComps.txt -Append
}