Import-Module -Name vm*
$BTServer = Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$STServer = Connect-HVServer -Server viewst-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$Pools = Get-HVPool -HvServer $BTServer
ForEach ($Pool in $Pools)
{
If ($Pool.Type -eq "AUTOMATED")
{
$Machines = Get-HVMachine -PoolName $Pool.Base.Name -HvServer $BTServer
ForEach ($Machine in $Machines)
{
If ($Machine.Base.BasicState -ne "Connected")
{
Write-Host $Pool.Base.Name " | " $Machine.Base.Name
}
}
}
}
$Pools2 = Get-HVPool -HvServer $STServer
ForEach ($Pool2 in $Pools2)
{
If ($Pool2.Type -eq "AUTOMATED")
{
$Machines2 = Get-HVMachine -PoolName $Pool2.Base.Name -HvServer $STServer
ForEach ($Machine2 in $Machines2)
{
If ($Machine2.Base.BasicState -ne "Connected")
{
Write-Host $Pool2.Base.Name " | " $Machine2.Base.Name
}
}
}
}