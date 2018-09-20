##Get list of Faculty Members from the CCEE Faculty Group
$faculty = Get-ADGroupMember -Recursive 'CCEE-Faculty' | Select -ExpandProperty Name
#Process through the Faculty List
ForEach ($facultymember in $faculty)
{
$ErrorActionPreference = "SilentlyContinue"
#Check if Faculty Member has Grad Student OU, if so continue
If ([adsi]::Exists("LDAP://OU=$facultymember,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{
#Create a directory for each faculty member only if it does not already exist
If (!(Test-Path -Path X:\Helpdesk\Scripts\CCEE-Faculty\$facultymember))
{
New-Item -ItemType directory -Path X:\Helpdesk\Scripts\CCEE-Faculty\$facultymember
}
##Set AD Group name for Grad Student Users and pull group membership
$gradadmin = "CCEE-Grad Students." + $facultymember + ".administrators"
#Get group membership for each faculty .administrator group and put it in csv
Get-ADGroupMember -Identity $gradadmin | Select Name | Sort Name | Export-Csv "X:\Helpdesk\Scripts\CCEE-Faculty\$facultymember\$facultymember.csv"
#Set Group Name for Faculty .Desktops Group
$group = "CCEE-Grad Students." + $facultymember + ".Desktops"
$laptopgroup = "CCEE-Grad Students." + $facultymember + ".Laptops"
#Get Membership of all the faculty .desktop groups and add it to the CSV
Get-ADGroupMember $group | select Name | Export-Csv X:\Helpdesk\Scripts\CCEE-Faculty\$facultymember\$facultymember.csv -Append
Get-ADGroupMember $laptopgroup | select Name | Export-Csv X:\Helpdesk\Scripts\CCEE-Faculty\$facultymember\$facultymember.csv -Append
}
}