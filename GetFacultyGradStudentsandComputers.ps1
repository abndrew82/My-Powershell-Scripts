##Get list of Faculty and place it in a text file
$faculty = Get-Content C:\Users\apsenn.admin\Desktop\CCEE-Gad\faculty.txt
#Process through the Faculty List
ForEach ($facultymember in $faculty)
{
#Create CSV File with Professors Name
$ErrorActionPreference = "SilentlyContinue"
#Create a directory for each faculty member only if it does not already exist
If (!(Test-Path -Path C:\Users\apsenn.admin\Desktop\CCEE-Gad\FacMembers\$facultymember))
{
New-Item -ItemType directory -Path C:\Users\apsenn.admin\Desktop\CCEE-Gad\FacMembers\$facultymember
}
##Set AD Group name for Grad Student Users and pull group membership
$gradadmin = "CCEE-Grad Students." + $facultymember + ".administrators"
#Get group membership for each faculty .administrator group and put it in csv
Get-ADGroupMember -Identity $gradadmin | Select Name | Sort Name | Export-Csv "C:\Users\apsenn.admin\Desktop\CCEE-Gad\Facmembers\$facultymember\$facultymember.csv"
#Delete all empty CSV files
Get-ChildItem C:\Users\apsenn.admin\Desktop\CCEE-Gad\Facmembers\* -Recurse | where {$_.length -eq 0} | remove-Item
#Set Group Name for Faculty .Desktops Group
$group = "CCEE-Grad Students." + $facultymember + ".Desktops"
$laptopgroup = "CCEE-Grad Students." + $facultymember + ".Laptops"
#Get Membership of all the faculty .desktop groups and add it to the CSV
Get-ADGroupMember $group | select Name | Export-Csv C:\Users\apsenn.admin\Desktop\CCEE-Gad\FacMembers\$facultymember\$facultymember.csv -Append
Get-ADGroupMember $laptopgroup | select Name | Export-Csv C:\Users\apsenn.admin\Desktop\CCEE-Gad\FacMembers\$facultymember\$facultymember.csv -Append
}
#Delete all empty Sub Folders from Facmembers
$SearchRoot = "C:\Users\apsenn.admin\Desktop\CCEE-Gad\Facmembers"

$EmptyFolders = Get-ChildItem -Path $SearchRoot -Directory |
Where-Object {(Get-ChildItem -Path $_.FullName -Recurse) -eq $null}

$EmptyFolders | Remove-Item