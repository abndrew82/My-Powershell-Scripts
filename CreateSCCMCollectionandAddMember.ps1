############################################################################################################################################################
##Look into how to only create the collection if it does not already exist, and where to best place it in the script with that information
##Currently moved it before the For Each as don't want it to try and create the collection for each, just add the members
##Could also just make collections first, then do the For Each area with different OSs and add computers to the created collections
############################################################################################################################################################

#Gather All AD Computers from Domain Computers Group
Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Push-Location -Path SEN:
$AllComps = Get-ADGroupMember "Domain Computers" -Recursive | Select -ExpandProperty Name
#Get Computer information of each Computer
#Create Collection for Windows 7 Computers
New-CMDeviceCollection -Name "Win 7 Test" -LimitingCollectionName "All Systems" -RefreshSchedule $DevSchedule -RefreshType Periodic
ForEach ($Comp in $AllComps)
{
$Name = Get-ADComputer -Identity $Comp -Properties * | Select -ExpandProperty Name
$OS = Get-ADComputer -Identity $Comp -Properties * | Select -ExpandProperty OperatingSystem
#Write-Host $Name " | " $OS
#Find which computers OS is Windows 7
If ($OS -like "*Windows 7*")
{
#Add Windows 7 Computers to the previously created Collection
$DevSchedule = New-CMSchedule -Start "05/05/2016 1:00 PM" -DayOfWeek Thursday -RecurCount 1
Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Win 7 Test" -ResourceId $(get-cmdevice -Name $Name).ResourceID
}
}