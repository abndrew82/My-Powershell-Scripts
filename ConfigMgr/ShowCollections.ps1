<#

.SYNOPSIS
   Script to check how many collections exist with auto incremental update on ConfigMgr 2012. 

.DESCRIPTION
   This script shows the number of collections with Auto incremental update in Config Mgr 2012 environment
   It also displays which collections and the current member count
   Microsoft best practice states that this should not exceed 200

   Created by Eirik Holgernes - eih@steria.no

.EXAMPLE
   .\ShowCollections.ps1 -CMSite <CMSite>

.EXAMPLE
   .\ShowCollections.ps1 -CMSite <CMSite> -ExportCSV <path>

.LINK
http://social.technet.microsoft.com/wiki/contents/articles/11215.system-center-2012-configuration-manager-best-practices.aspx

#>


Param (
[Parameter(Mandatory=$true)]
[ValidateNotNull()]
[String]$CMSite,
$ExportCSV=$null
)

if (!$cmsite) {

    Write-Error "Please specify a CMSite parameter"
    exit

}


Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'


cd $cmsite":"

# The following refresh types exist for ConfigMgr collections
# 6 = Incremental and Periodic Updates
# 4 = Incremental Updates Only
# 2 = Periodic Updates only
# 1 = Manual Update only

$refreshtypes = "4","6"
$CollectionsWithIncrement = Get-CMDeviceCollection | Where-Object {$_.RefreshType -in $refreshtypes}

$Collections = @()

foreach ($collection in $CollectionsWithIncrement) {
    $object = New-Object -TypeName PSobject
    $object| Add-Member -Name CollectionName -value $collection.Name -MemberType NoteProperty
    $object| Add-Member -Name CollectionID -value $collection.CollectionID -MemberType NoteProperty
    $object| Add-Member -Name MemberCount -value $collection.LocalMemberCount -MemberType NoteProperty
    $collections += $object
}

if ($ExportCSV -eq $null) {
        $collections | Out-GridView -Title "Collections with auto incremental update"
    } else {
        $collections | Export-Csv -Path $ExportCSV -NoTypeInformation
    }

$total = $CollectionsWithIncrement.count

Write-Host "You have $total collections with Incremental Update in your environment"