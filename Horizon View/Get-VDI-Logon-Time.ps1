$Logs = Get-ChildItem \\btstorage.uncfsu.edu\LoginMon\*
ForEach ($Log in $Logs)
{
Select-String -Path $Log -Pattern "LogSummary] Logon Time:"
}