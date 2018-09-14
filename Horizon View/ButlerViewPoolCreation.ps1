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
#Get-ViewVC -ServerName view-bt.uncfsu.edu | Add-AutomaticLinkedClonePool
#Composer AD ID 82778797-e85f-4a37-bc85-a9d1c719a3c2
Get-ViewVC -ServerName view-bt.uncfsu.edu | Add-AutomaticLinkedClonePool -Pool_id $PoolID -NamePrefix "$CompName-{n:fixed=2}" `
-Persistence NonPersistent -VmFolderPath "/NXBT/vm" -ResourcePoolPath "/NXBT/host/Butler VDI/Resources/$ResourcePool" `
-ParentVmPath "/NXBT/vm/Win 10 - Composer" -ParentSnapshotPath "/Gold Image v7/Gold Image v8" `
-DatastoreSpecs "[Conservative,OS,data]/NXBT/host/Butler VDI/nxbt-c01" -UseUserDataDisk $false `
-OrganizationalUnit "OU=$OU,OU=Composer Clones,OU=Virtual Desktops,OU=FSU" -UseTempDisk $false -MinimumCount $TotalDesktops `
-MaximumCount $TotalDesktops -HeadroomCount 1 -PowerPolicy RemainOn -DeletePolicy RefreshonUse -SuspendProvisioningOnError $false `
-DefaultProtocol PCOIP -AllowProtocolOverride $True -AllowMultipleSessions $False -Composer_ad_id 82778797-e85f-4a37-bc85-a9d1c719a3c2