$Comps = Get-Content D:\1sort.txt
$ErrorActionPreference = "SilentlyContinue"
ForEach ($comp in $Comps)
{
$CompLength = $Comp.Length + 1
$CanonicalName = Get-ADComputer -Identity $Comp -Properties CanonicalName  | Select -ExpandProperty CanonicalName
$IP = Get-ADComputer -Identity $Comp -Properties * | select -ExpandProperty IPV4Address
$PassSet = Get-ADComputer -Identity $Comp -Properties * | select -ExpandProperty passwordlastset
$OS = Get-ADComputer -Identity $Comp -Properties * | select -ExpandProperty OperatingSystem
#Write-Host $Comp "|" $CanonicalNamez
$OU = $CanonicalName.Substring(0,$CanonicalName.Length-$CompLength)
#Write-Host $Comp "|" $IP "|" $PassSet "|" $OS
$CompsnoClient = $Comp + "|" + $IP + "|" + $PassSet + "|" + $OS
Out-File -InputObject $CompsnoClient d:\1sortcomps.txt -Append
}
