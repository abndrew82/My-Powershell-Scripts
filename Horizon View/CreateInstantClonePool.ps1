param (
[parameter(Mandatory=$True)]
    [string]$PoolID = '',
[parameter(Mandatory=$True)]
    [string]$CompName = '',
[parameter(Mandatory=$True)]
    [string]$OU = '',
[parameter(Mandatory=$True)]
    [string]$PoolName = '',
[parameter(Mandatory=$True)]
    [string]$TotalDesktops = ''
)
Get-Module -Name VMWare* | Import-Module
##Connect to Butler Horizon Server##
Connect-HVServer -Server "viewbt-int01" -user 'bigben' -Password 'G0St33l3r$' -Domain 'uncfsu.edu'
##Generate Number for On Demand##
$OnDemand = $TotalDesktops/2
##Create Instant Clone Pool##
New-HVPool -InstantClone -PoolName "BT-$PoolID" -PoolDisplayName "$PoolName"`
-Description $PoolDesc -UserAssignment FLOATING -ParentVM 'BTIC-Base-Win10-1709'`
-SnapshotVM 'Gold Image v6' -VmFolder 'NXBT' -HostOrCluster  'Butler VDI'`
-ResourcePool $PoolName -NamingMethod PATTERN -NamingPattern "$CompName-{n:fixed=2}"`
-Datastores 'nxbt-c01' -NetBiosName 'uncfsu' -DomainAdmin vcadmin -MaximumCount "$TotalDesktops"`
-ProvisioningTime ON_DEMAND -ConnectionServerRestrictions 'Internal' -AdContainer "$OU"`
-MinimumCount $OnDemand -NumUnassignedMachinesKeptPoweredOn $OnDemand
##Enable HTML Access on Previously Created Pool##
Set-HVPool -PoolName "BT-$PoolID" -enableHTMLAccess $true
##Entitle VDI Test Users for the New Pool##
New-HVEntitlement -User "uncfsu.edu\VDI-Test-Users" -ResourceName "BT-$PoolID" -ResourceType Desktop -Type Group
##Disconnect from Butler Horizon Server##
Disconnect-HVServer -Server "viewbt-int01" -Force -Confirm:$false
##Connect to SciTech Horizon Server##
Connect-HVServer -Server "viewst-int01" -user 'bigben' -Password 'G0St33l3r$' -Domain 'uncfsu.edu'
##Create Instant Clone Pool##
New-HVPool -InstantClone -PoolName "ST-$PoolID" -PoolDisplayName "$PoolName"`
-Description $PoolDesc -UserAssignment FLOATING -ParentVM 'STIC-Base-Win10-1709'`
-SnapshotVM 'Gold Image v6' -VmFolder 'NXST' -HostOrCluster  'Science and Tech VDI'`
-ResourcePool $PoolName -NamingMethod PATTERN -NamingPattern "$CompName-{n:fixed=2}"`
-Datastores 'nxst-c01' -NetBiosName 'uncfsu' -DomainAdmin vcadmin -MaximumCount "$TotalDesktops"`
-ProvisioningTime ON_DEMAND -ConnectionServerRestrictions 'Internal' -AdContainer "$OU"`
-MinimumCount $OnDemand -NumUnassignedMachinesKeptPoweredOn $OnDemand
##Enable HTML Access on Previously Created Pool##
Set-HVPool -PoolName "ST-$PoolID" -enableHTMLAccess $true
##Entitle VDI Test Users for the New Pool##
New-HVEntitlement -User "uncfsu.edu\VDI-Test-Users" -ResourceName "ST-$PoolID" -ResourceType Desktop -Type Group
##Disconnect from Butler Horizon Server##
Disconnect-HVServer -Server "viewst-int01" -Force -Confirm:$false