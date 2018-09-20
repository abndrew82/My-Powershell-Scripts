Import-Module -Name vm*
$BTServer = Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$STServer = Connect-HVServer -Server viewst-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$SessionData = get-HVlocalsession -HvServer $BTServer
ForEach ($sesdata in $SessionData | Where-Object {$_.sessiondata.sessionstate -ne "Disconnected"})
{
Write-Host $sesdata.NamesData.DesktopName " | " $sesdata.SessionData.StartTime " | " $sesdata.SessionData.SessionState " | " $sesdata.SessionData.SessionProtocol " | " $sesdata.NamesData.UserName
}
$SessionData = get-HVlocalsession -HvServer $STServer
ForEach ($sesdata in $SessionData | Where-Object {$_.sessiondata.sessionstate -ne "Disconnected"})
{
Write-Host $sesdata.NamesData.DesktopName " | " $sesdata.SessionData.StartTime " | " $sesdata.SessionData.SessionState " | " $sesdata.SessionData.SessionProtocol " | " $sesdata.NamesData.UserName
}
