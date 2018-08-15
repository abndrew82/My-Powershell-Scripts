Import-Module -Name vm*
$BTServer = Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$STServer = Connect-HVServer -Server viewst-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$Pools = Get-HVPool -HvServer $BTServer
ForEach ($Pool in $Pools)
{
If ($Pool.Type -eq "AUTOMATED")
{
$Machines = Get-HVMachine -PoolName $Pool.Base.Name -HvServer $BTServer | Where-Object {$_.Base.BasicState -eq "Connected"}
ForEach ($Machine in $Machines)
{
$SessionData = get-HVlocalsession -HvServer $BTServer
ForEach ($sesdata in $SessionData)
{
Write-Host $sesdata.NamesData.DesktopName " | " $sesdata.SessionData.StartTime
}
}
}
}