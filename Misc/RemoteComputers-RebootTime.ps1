$Comps = Get-Content c:\Users\asenn\Documents\LSA125.txt
ForEach ($Comp in $Comps)
{
#$Boottime = Get-CimInstance -ComputerName $Comp -ClassName win32_operatingsystem | select csname, lastbootuptime
Get-CimInstance -ComputerName $Comp -ClassName win32_operatingsystem | select csname, lastbootuptime
#Out-File C:\Users\asenn\lsa125boot.txt -InputObject $Boottime -Append
}