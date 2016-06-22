$Comps = Get-ADComputer -Filter * -SearchBase 'OU=Desktops,OU=Software Testing,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu'  -Properties Name | Select -ExpandProperty Name
ForEach ($comp in $comps)
{
$compname = Get-ADComputer $comp -Properties Name | Select -ExpandProperty Name
$compmac = Get-ADComputer $comp -Properties netbootguid | Select -ExpandProperty netbootguid
$arr = $compmac -split ' '
#Write-Host $arr[10] $arr[11] $arr[12] $arr[13] $arr[14] $arr[15]
$mac1 = “{0:x}” -f [Int]$arr[10]
$mac2 = “{0:x}” -f [Int]$arr[11]
$mac3 = “{0:x}” -f [Int]$arr[12]
$mac4 = “{0:x}” -f [Int]$arr[13]
$mac5 = “{0:x}” -f [Int]$arr[14]
$mac6 = “{0:x}” -f [Int]$arr[15]
If ($mac1 -eq "0" -and $mac2 -eq "0" -and $mac3 -eq "0" -and $mac4 -eq "0" -and $mac5 -eq "0" -and $mac6 -eq "0")
{
Write-Host $compname "|" "NetbootGuid is Empty"
}
ElseIf ($mac1 -eq "0")
{
$mac1 = "00"
}
ElseIf ($mac2 -eq "0")
{
$mac2 = "00"
}
ElseIf ($mac3 -eq "0")
{
$mac3 = "00"
}
ElseIf ($mac4 -eq "0")
{
$mac4 = "00"
}
ElseIf ($mac5 -eq "0")
{
$mac5 = "00"
}
ElseIf ($mac6 -eq "0")
{
$mac6 = "00"
}
Write-Host $compname "|" $mac1":"$mac2":"$mac3":"$mac4":"$mac5":"$mac6
}

