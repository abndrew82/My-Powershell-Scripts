Get-Module -Name VMWare* | Import-Module
Connect-HVServer -Server "viewst-int01" -user 'bigben' -Password 'G0St33l3r$' -Domain 'uncfsu.edu'
New-HVPool -InstantClone -PoolName "ST-BusFinStaff" -PoolDisplayName "Business and Finance Staff" -Description "Pool for B&F Staff"`
-UserAssignment FLOATING -ParentVM 'STIC-Base-Win10-1709' -SnapshotVM 'Gold Image v6' -VmFolder 'NXST' -HostOrCluster  'Science and Tech VDI'`
-ResourcePool 'Business and Finance' -NamingMethod PATTERN -NamingPattern "STBusFin-{n:fixed=2}" -Datastores 'nxst-c01' -NetBiosName 'uncfsu'`
-DomainAdmin vcadmin -MaximumCount 8 -ProvisioningTime UP_FRONT -ConnectionServerRestrictions 'Internal'`
-AdContainer "OU=Business and Finance,OU=Instant Clones,OU=Virtual Desktops,OU=FSU" -MinimumCount "3"`
-NumUnassignedMachinesKeptPoweredOn 2 -HvServer "viewst-int01"
Set-HVPool -PoolName "ST-BusFinStaff" -enableHTMLAccess $true
New-HVEntitlement -User "uncfsu.edu\VDI-Test-Users" -ResourceName ST-BusFinStaff -ResourceType Desktop -Type Group