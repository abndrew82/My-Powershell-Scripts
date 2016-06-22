##Get list of Faculty and place it in a text file
#Get-ADGroupMember -Identity 'WT-CCEE-14CE Faculty' | Select Name | Sort Name | Out-file C:\Users\apsenn.admin\Desktop\CCEE-Gad\faculty.txt
## Pull list of Faculty from txt file
$faculty = Get-Content C:\Users\apsenn.admin\Desktop\CCEE-Gad\faculty.txt
#Process through the Faculty List
ForEach ($facultymember in $faculty)
{
#Create CSV File with Professors Name
##Set AD Group name for Grad Student Users and pull group membership
$ErrorActionPreference = "SilentlyContinue"
$gradadmin = "CCEE-Grad Students." + $facultymember + ".administrators"
Get-ADGroupMember -Identity $gradadmin | Select Name | Sort Name | Export-Csv "C:\Users\apsenn.admin\Desktop\CCEE-Gad\CSVs\$facultymember.csv" -Append
Get-ChildItem "C:\Users\apsenn.admin\Desktop\CCEE-Gad\CSVs" | where {$_.length -eq 0} | remove-Item
}