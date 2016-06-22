#Parameter so that script can be run with Professor name, or asked for on run
Param (
       [parameter(Mandatory=$True,HelpMessage='Enter Professors Unity ID')]
       [string]$profname = ''
       )
#Script will Create structure if it does not exist and output at end
$ADPath = "OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
#Check if Professor already has an OU Structure
If ([adsi]::Exists("LDAP://OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{
Write-Host "Professor already has a Grad Student OU"
} Else {
#Create OU If does not exist
New-ADOrganizationalUnit -Name $ProfName -Path $ADPath
$NewOU = "OU=$ProfName,$ADPath"
#Create Desktops OU
New-ADOrganizationalUnit -Name "Desktops" -Path $NewOU
#Create Laptops OU
New-ADOrganizationalUnit -Name "Laptops" -Path $NewOU
$AdminGroupName = "CCEE-Grad Students." + $ProfName + ".Administrators"
#Create .adminstrators Group for Professor
New-ADGroup -Name $AdminGroupName -Path $NewOU -GroupCategory Security -GroupScope Global
#Add Professor to his .administrators Group
Add-ADGroupMember -Identity $AdminGroupName -Member $ProfName
$ComputerGroup = "CCEE-Grad Students." + $ProfName + ".Computers"
#Create Computers Group under OU
New-ADGroup -Name $ComputerGroup -Path $NewOU -GroupCategory Security -GroupScope Global
$DesktopGroup = "CCEE-Grad Students." + $ProfName + ".Desktops"
#Create Desktops Group under OU
New-ADGroup -Name $DesktopGroup -Path $NewOU -GroupCategory Security -GroupScope Global
$LaptopGroup = "CCEE-Grad Students." + $ProfName + ".Laptops"
#Create Laptops group under OU
New-ADGroup -Name $LaptopGroup -Path $NewOU -GroupCategory Security -GroupScope Global
$UserGroup = "CCEE-Grad Students." + $ProfName + ".Users"
#Create .users group under OU
New-ADGroup -Name $UserGroup -Path $NewOU -GroupCategory Security -GroupScope Global
#Adds Access for ITECS Helpdesk to computers
Add-ADGroupMember -Identity $UserGroup -Member "CCEE-Grad Students.Users"
#Make Desktops and Labtops Members of the Computers Group
Add-ADGroupMember -Identity $ComputerGroup -Member $DesktopGroup
Add-ADGroupMember -Identity $ComputerGroup -Member $LaptopGroup
#Check if OU Actually Created
If ([adsi]::Exists("LDAP://OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{ Write-Host "Professor OU Created" }

If ([adsi]::Exists("LDAP://OU=Desktops,OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{ Write-Host "Professor Desktops OU Created" }

If ([adsi]::Exists("LDAP://OU=Laptops,OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{ Write-Host "Professor Laptops OU Created" }

$USERGROUPCN = "CN=" + $UserGroup + "," + "OU=" + $profname + ",OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
If ([adsi]::Exists("LDAP://$USERGROUPCN"))
{ Write-Host "Professor Users group created" }

$COMPUTERSGROUPCN = "CN=" + $UserGroup + "," + "OU=" + $profname + ",OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
If ([adsi]::Exists("LDAP://$COMPUTERSGROUPCN"))
{ Write-Host "Professor Computers group created" }

$DESKTOPSGROUPCN = "CN=" + $UserGroup + "," + "OU=" + $profname + ",OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
If ([adsi]::Exists("LDAP://$DESKTOPSGROUPCN"))
{ Write-Host "Professor Desktops group created" }

$LAPTOPSGROUPCN = "CN=" + $UserGroup + "," + "OU=" + $profname + ",OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
If ([adsi]::Exists("LDAP://$LAPTOPSGROUPCN"))
{ Write-Host "Professor Laptops group created" }

$ADMINISTRATORGROUPCN = "CN=" + $UserGroup + "," + "OU=" + $profname + ",OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
If ([adsi]::Exists("LDAP://$ADMINISTRATORGROUPCN"))
{ Write-Host "Professor .Administrators group created" }
}