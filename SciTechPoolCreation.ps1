param (
[parameter(Mandatory=$True)]
    [string]$PoolID = '',
[parameter(Mandatory=$True)]
    [string]$CompName = '',
[parameter(Mandatory=$True)]
    [string]$ResourcePool = '',
[parameter(Mandatory=$True)]
    [string]$OU = '',
[parameter(Mandatory=$True)]
    [string]$TotalDesktops = ''
)
Get-ViewVC -ServerName view-st.uncfsu.edu | Add-AutomaticLinkedClonePool -Pool_id $PoolID -NamePrefix "$CompName-{n:fixed=2}" `
-Persistence NonPersistent -VmFolderPath "/NXST/vm" -ResourcePoolPath "/NXST/host/Science and Tech VDI/Resources/$ResourcePool" `
-ParentVmPath "/NXST/vm/Infrastructure/ST-Composer" -ParentSnapshotPath "/Gold Image v3/Gold Image v4" `
-DatastoreSpecs "[Conservative,OS,data]/NXST/host/Science and Tech VDI/nxst-c01" -UseUserDataDisk $false `
-OrganizationalUnit "OU=$OU,OU=Composer Clones,OU=Virtual Desktops,OU=FSU" -UseTempDisk $false -MinimumCount $TotalDesktops `
-MaximumCount $TotalDesktops -HeadroomCount 1 -PowerPolicy RemainOn -DeletePolicy RefreshonUse -SuspendProvisioningOnError $false `
-DefaultProtocol PCOIP -AllowProtocolOverride $True -AllowMultipleSessions $False -Composer_ad_id 6c7d277d-c921-4668-85e0-59227be1c39e