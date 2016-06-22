##Get List of Faculty Grad Student Groups 
$faculty = Get-Content C:\Users\apsenn.admin\Desktop\CCEE-Gad\faculty.txt
#Process through the Faculty List
ForEach ($facultymember in $faculty)
{
$ErrorActionPreference = "SilentlyContinue"
##Set AD Group name for Grad Student .computers groups
$graddesktops = "CCEE-Grad Students." + $facultymember + ".Computers"
Write-Host $graddesktops
##Add each Grad Student .Comptuers group to the Microsoft Office 2010 CCEE Group
Add-ADGroupMember CCEE-SW-Microsoft-Office-2010 $graddesktops
}
