#Where to Save the File
$SavePath = "X:\share\apsenn\My-Powershell-Scripts"
#Ask user what file should be named
$FileName = Read-Host -Prompt 'Name for the Report'
##Get List of Comps from AD Group
$Laptops = Get-ADGroupMember "CCEE-Grad Students.agupta1.Desktops"
ForEach ($Computer in $Laptops)
{
#Get Comp Name Properties from List
$CompName = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty Name
#Get Comp Location Properties from List (Userd Later)
$CompLoc = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty Location
#Get Comp IP Properties from List
$CompIP = Get-ADComputer -Identity $Computer -Properties * | select -ExpandProperty IPV4Address
Write-Host $CompName "-" $CompIP
ForEach ($Comp in $CompIP)
{
#Process through List matching IPs to subnets for buildings
If ($Comp -like '*152.1.55*')
{
$Mann55 = $CompName + " | " + $CompIP + " | " + "Mann Hall .55"
Out-File -InputObject $Mann55 $SavePath\$FileName.txt -Append
}
ElseIf ($Comp -like '*152.1.64*')
{
$Bur64 = $CompName + " | " + $CompIP + " | " + "Burlington .64"
Out-File -InputObject $Bur64 $SavePath\$FileName.txt -Append
}
ElseIf ($Comp -like '*10.72.12*')
{
$Brough10 = $CompName + " | " + $CompIP + " | " + "Broughton 10"
Out-File -InputObject $Brough10 $SavePath\$FileName.txt -Append
}
} 
}