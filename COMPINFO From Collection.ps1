$Comps = Get-CMDevice -CollectionId "FS100106" | Select -ExpandProperty Name
ForEach ($Comp in $Comps)
{
$TestConn = Test-Connection -ComputerName $Comp -Count 2 -Quiet
$CompIP = Get-ADComputer -Identity $Comp -Properties IPV4Address | Select -ExpandProperty IPV4Address
$CompPW = Get-ADComputer -Identity $Comp -Properties passwordlastset | Select -ExpandProperty passwordlastset
$complastlogon = Get-ADComputer -Identity $Comp -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$AllCompINfo = $Comp + "|" + $CompIP + "|" + $CompPW + "|" + $complastlogon + "|" + $TestConn
Write-Host $Comp "|" $CompIP  "|"  $CompPW  "|"  $complastlogon  "|"  $TestConn
Out-File c:\windows\temp\NamedWrongOutput.txt -InputObject $AllCompINfo -Append
}