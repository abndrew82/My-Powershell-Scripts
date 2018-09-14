$Logs = Get-ChildItem \\btstorage\LoginMon\*
$Logs.Count
ForEach ($Log in $Logs)
{
$data = Get-Content $log | Select-String -Pattern "LogSummary] Logon Time:"
$Logname = $log.ToString()
$Logontime = $data.ToString()
$Logon = $Logontime.Split(" ")[6]
$pos = $Logname.IndexOf("-")
$DesktopPool = $Logname.Substring(0, $pos)
$Data = $DesktopPool + "|" + $Logon
Write-Host $DesktopPool "|" $Logon
Out-File -InputObject $data f:\alldesktops.txt -Append
}