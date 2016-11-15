#Get Members of the Group recursivly to pull all computers in the groups
$AllComps = get-adcomputer -Filter {ObjectClass -Like "Computer"} -SearchBase 'DC=uncfsu,DC=edu' | Select -ExpandProperty Name
#For Each computer get Computer Name and IP Address, OS, and Check if Old AD Record and output that to a txt file
ForEach ($Computer in $AllComps)
{
$Name = Get-ADComputer -Identity $Computer -Properties * | Select -ExpandProperty Name
$IP = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty IPV4Address
$PassSet = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty passwordlastset
$OS = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty OperatingSystem
#Write-Host $Name " | " $IP
$Compinfo = $Name + " | " + $IP + " | " + $OS + " | " + $PassSet
Out-File -InputObject $Compinfo d:\oldcomps.txt -Append
ForEach ($Pass in $PassSet)
{
If ($Pass -lt '6/1/2015')
{
$OLDCOMPS = $Name + " | " + $IP + " | " + $OS + " | " +  $PassSet + " | " + "OLD COMPUTER"
Out-File -InputObject $OLDCOMPS D:\OldComps2.txt -Append
}
}
}