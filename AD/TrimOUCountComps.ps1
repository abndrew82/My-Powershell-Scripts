$Comps = Get-Content C:\Users\asenn\Documents\Comps.txt
ForEach ($Comp in $Comps)
{
$OU = Get-ADComputer -Identity $Comp | Select -ExpandProperty DistinguishedName
$infomation = $Comp + "|" + $OU
Out-File C:\Users\asenn\Documents\compswithou.txt -InputObject $infomation -Append

}