$ReturnData = @()
$Servers = @("viewbt-int01", "viewst-int01")
Foreach ($Server in $Servers)
{
Connect-HVServer -Server $Server -Domain uncfsu -User bigben -Password G0St33l3r$
$Pools = Get-HVPool -PoolType AUTOMATED | Select -ExpandProperty Base | Select -ExpandProperty Name
ForEach ($Pool in $Pools)
{
$Baseimage = Get-HVPool -PoolName $Pool | Select -ExpandProperty AutomatedDesktopData | Select -ExpandProperty VirtualCenterNamesData | Select -ExpandProperty Parentvmpath
$Snapshot = Get-HVPool -PoolName $Pool | Select -ExpandProperty AutomatedDesktopData | Select -ExpandProperty VirtualCenterNamesData | Select -ExpandProperty SnapshotPath
$ReturnData += New-Object PSObject -Property @{Server=$Server; PoolName=$Pool; BaseImage=$Baseimage; SnapShot=$Snapshot}
}
}
$ReturnData | select Server, PoolName, BaseImage, SnapShot | Sort-Object BaseImage | Out-GridView

