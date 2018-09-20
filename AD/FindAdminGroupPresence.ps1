$gstudents = Get-Content C:\Users\apsenn.admin\Desktop\gradstudents.txt
ForEach ($grad in $gstudents)
{
$a = Get-ADUser $grad -Properties * | Select -ExpandProperty MemberOf
ForEach ($b in $a)
{
If ($b -like "*administrators*")
{
Write-Host $grad "|" $b
#$output = $grad + "|" + $b
#Out-file C:\Users\apsenn.admin\Desktop\Memberof.txt -InputObject $output -Append
}
}
}