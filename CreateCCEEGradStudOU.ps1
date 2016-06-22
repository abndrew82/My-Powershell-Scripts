#Script to create CCEE Grad Student OU's with Professors name
$ProfName = Read-Host 'Enter Professors Unity ID?'
$ADPath = "OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"
New-ADOrganizationalUnit -Name $ProfName -Path $ADPath
If ([adsi]::Exists("LDAP://OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{
Write-Host "Professor OU Created"
} else {
Write-Host "Professor OU Not Created"
}
$NewOU = "OU=$ProfName,$ADPath"
Write-Host $NewOU
#Create the Desktops OU
New-ADOrganizationalUnit -Name "Desktops" -Path $NewOU
If ([adsi]::Exists("LDAP://OU=Desktops,OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{
Write-Host "Desktops OU Created"
} else {
Write-Host "Desktops OU Not Created"
}
$DesktopOU = "OU=Desktops,$NewOU"
Write-Host $DesktopOU
#Create the Laptops OU
New-ADOrganizationalUnit -Name "Laptops" -Path $NewOU
If ([adsi]::Exists("LDAP://OU=Desktops,OU=$ProfName,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"))
{
Write-Host "Laptops OU Created"
} else {
Write-Host "Laptops OU Not Created"
}
$LaptopOU = "OU=Laptops,$NewOU"
Write-Host $LaptopOU
#Create the Groups (.administrators, .Computers, .Desktops, .Laptops, .Users)
$AdminGroupName = "CCEE-Grad Students." + $ProfName + ".Administrators"
Write-Host $AdminGroupName
New-ADGroup -Name $AdminGroupName -Path $NewOU -GroupCategory Security -GroupScope Global
Add-ADGroupMember -Identity $AdminGroupName -Member $ProfName
$ComputerGroup = "CCEE-Grad Students." + $ProfName + ".Computers"
Write-Host $ComputerGroup
New-ADGroup -Name $ComputerGroup -Path $NewOU -GroupCategory Security -GroupScope Global
$DesktopGroup = "CCEE-Grad Students." + $ProfName + ".Desktops"
Write-Host $DesktopGroup
New-ADGroup -Name $DesktopGroup -Path $NewOU -GroupCategory Security -GroupScope Global
$LaptopGroup = "CCEE-Grad Students." + $ProfName + ".Laptops"
Write-Host $LaptopGroup
New-ADGroup -Name $LaptopGroup -Path $NewOU -GroupCategory Security -GroupScope Global
$UserGroup = "CCEE-Grad Students." + $ProfName + ".Users"
Write-Host $UserGroup
New-ADGroup -Name $UserGroup -Path $NewOU -GroupCategory Security -GroupScope Global
Add-ADGroupMember -Identity $UserGroup -Member "CCEE-Grad Students.Users"
#Make Desktops and Labtops Members of the Computers Group
Add-ADGroupMember -Identity $ComputerGroup -Member $DesktopGroup
Add-ADGroupMember -Identity $ComputerGroup -Member $LaptopGroup