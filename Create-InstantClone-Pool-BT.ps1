Get-Module -Name VMWare* | Import-Module
Connect-HVServer -Server "viewbt-int01" -user 'bigben' -Password 'G0St33l3r$' -Domain 'uncfsu.edu'
New-HVPool -InstantClone -PoolName "BT-BusFinStaff" -PoolDisplayName "Business and Finance Staff" -Description "Pool for B&F Staff"`
-UserAssignment FLOATING -ParentVM 'BTIC-Base-Win10-1709' -SnapshotVM 'Gold Image v6' -VmFolder 'NXBT' -HostOrCluster  'Butler VDI'`
-ResourcePool 'Business and Finance' -NamingMethod PATTERN -NamingPattern "BTBusFin-{n:fixed=2}" -Datastores 'nxbt-c01' -NetBiosName 'uncfsu'`
-DomainAdmin vcadmin -MaximumCount 8 -ProvisioningTime ON_DEMAND -ConnectionServerRestrictions 'Internal'`
-AdContainer "OU=Business and Finance,OU=Instant Clones,OU=Virtual Desktops,OU=FSU" -MinimumCount "3"`
-NumUnassignedMachinesKeptPoweredOn 2 -HvServer "viewbt-int01"
Set-HVPool -PoolName "BT-BusFinStaff" -enableHTMLAccess $true
New-HVEntitlement -User "uncfsu.edu\VDI-Test-Users" -ResourceName ST-BusFinStaff -ResourceType Desktop -Type Group

