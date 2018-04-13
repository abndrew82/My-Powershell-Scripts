$Computers = Get-CMDevice -CollectionName "LSA 125" | Select -ExpandProperty Name
ForEach ($Computer in $Computers)
{
$BootMode = Get-WmiObject -ComputerName $Computer -Namespace Root\DCIM\SYSMAN -Class DCIM_BIOSENUMERATION | Where-Object {$_.AttributeName -eq "Boot Mode"} | Select -ExpandProperty CurrentValue
$Possible = Get-WmiObject -ComputerName $Computer -Namespace Root\DCIM\SYSMAN -Class DCIM_BIOSENUMERATION | Where-Object {$_.AttributeName -eq "Boot Mode"} | Select -ExpandProperty PossibleValues
$PossDesc = Get-WmiObject -ComputerName $Computer -Namespace Root\DCIM\SYSMAN -Class DCIM_BIOSENUMERATION | Where-Object {$_.AttributeName -eq "Boot Mode"} | Select -ExpandProperty PossibleValuesDescription
$Model = Get-WmiObject -ComputerName $Computer Win32_ComputerSystem | Select -ExpandProperty Model
write-Host $Computer "|" $BootMode "|" $Possible "|" $PossDesc "|" $Model
#If ($Possible -eq $null)
#{
#Write-Host $Computer
#}
}