Get-Module -Name VMWare* | Import-Module
Connect-HVServer -Server "viewst-int01" -user 'bigben' -Password 'G0St33l3r$' -Domain 'uncfsu.edu'
New-HVPool -InstantClone -PoolName "TestPool" -PoolDisplayName "Test Pool" -Description "Testing Powershell"`
-UserAssignment FLOATING -ParentVM 'STIC-Base-Win10-1709' -SnapshotVM 'Gold Image v5' -VmFolder 'NXST' -HostOrCluster  'Science and Tech VDI'`
-ResourcePool 'SBE 328' -NamingMethod PATTERN -NamingPattern "TestPool-{n:fixed=2}" -Datastores 'nxst-c01' -NetBiosName 'uncfsu'`
-DomainAdmin vcadmin -MaximumCount 6 -ProvisioningTime UP_FRONT -ConnectionServerRestrictions 'Internal'`
-AdContainer 'OU=SBE 328,OU=Instant Clones,OU=Virtual Desktops,OU=FSU'
New-HVEntitlement -User 'uncfsu.edu\VDI-Users' -Type Group -ResourceName TestPool -ResourceType Desktop