$a = Get-ADComputer itecs-lt-14 -Properties DistinguishedName | Select -ExpandProperty DistinguishedName
$b = Get-ADComputer itecs-lt-14 -Properties MemberOf | Select -ExpandProperty MemberOf
#$arr = $b -split ',OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu'
#Write-Host $a "|" $arr[0] "|" $arr[1] "|" $arr[2]
Foreach ($software in $b)
{
#Write-Host $software
$pos = $software.IndexOf(",")
$front = $software.Substring(0, $pos)
$pos2 = $software.IndexOf("=")
$Actual = $front.Substring($pos2+1)
Write-Host $Actual
}