New-HVPool -InstantClone -PoolName "ST-Test123" -PoolDisplayName "Test 123" -Description "Test 123 Pool"`
-UserAssignment FLOATING -ParentVM 'STIC-Base-Win10-1709' -SnapshotVM 'Gold Image v6' -VmFolder 'NXST' -HostOrCluster  'Science and Tech VDI'`
-ResourcePool 'Test 123' -NamingMethod PATTERN -NamingPattern "Test123-{n:fixed=2}" -Datastores 'nxst-c01' -NetBiosName 'uncfsu'`
-DomainAdmin vcadmin -MaximumCount 2 -ProvisioningTime UP_FRONT -ConnectionServerRestrictions 'Internal' -AdContainer "OU=Test Pool,OU=Instant Clones,OU=Virtual Desktops,OU=FSU"
