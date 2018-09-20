$Comps = Get-CMDevice -CollectionId FS100100 | select -ExpandProperty Name
$ErrorActionPreference = "SilentlyContinue"
$ReturnData = @()

ForEach ($Comp in $Comps)
{
$LastActive = Get-CMDevice -Name $Comp | Select -ExpandProperty LastActiveTime
$LastLogon = Get-ADComputer -Identity $Comp -Properties LastLogondate | select -ExpandProperty LastLogondate
$StartDate=(GET-DATE)
$Timespan = NEW-TIMESPAN –Start $LastActive –End $StartDate | Select -ExpandProperty Days
$ReturnData += New-Object PSObject -Property @{CompName=$Comp; LastADLogon=$LastLogon; LastActive=$LastActive; StartDate=$StartDate; Timespan=$Timespan}
}
$ReturnData | Select CompName, LastADLogon, LastActive, Timespan| Out-GridView