<# 
    .SYNOPSIS 
    Lists all device collections in a given folder 
 
    .DESCRIPTION 
    Lists all device collections, path to each collection, and membership count for each collection in a given folder in System Center Configuration Manager 2012. Whether a collection is in the queried folder is determined by examining each collection and comparing the folder name to the path to the collection. That path is generated using the ParentContainerNodeID attribute of the collection and it's parents. 
    (Uses function adapted from a function by Tao Tyang - http://blog.tyang.org/2011/05/20/powershell-script-to-locate-sccm-objects-in-sccm-console/) 
    Because the script has to examine all collections on the site, processing may take some time. 
 
    .PARAMETER SiteServer 
    A site server for the query to run against 
 
    .PARAMETER SiteCode 
    Site code for Configuration Manager site 
     
    .PARAMETER ParentFolderName 
    Name of the folder that you want to list the collections from. Note that the script is looking for the existence of a a string in the name of the parent container, so a more detailed path is better than a generic one. i.e "Departments\Accounting" is better than just "Accounting" This is only applicable if you have folders in multiple locations with similar names. 
 
    .PARAMETER Recurse 
    If $true, the script will list all collections in the $ParentFolderName folder and any subfolders. If $false, the script will only list the collections in the $ParentFolderName folder. 
 
    .EXAMPLE 
    .\Get-CollectionsByFolder.ps1 -SiteServer "Server01" -SiteCode "CM1" -ParentFolderName "OS - Windows" 
     
    Path                               CollectionName                                                 MemberCount 
    ----                               --------------                                                 ----------- 
    OS - Windows                       Windows 2000 Professional                                                1 
    OS - Windows                       Windows 2000 Server                                                      1 
    OS - Windows                       Windows 7                                                              664 
    OS - Windows                       Windows Server 2003                                                     94 
    OS - Windows                       Windows Server 2008 and 2008 R2                                        143 
    OS - Windows                       Windows Server 2012                                                      2 
    OS - Windows                       Windows XP                                                             331     
     
    Returns all collections in the "OS - Windows" folder in SCCM 
     
    .EXAMPLE 
    .\Get-CollectionsByFolder.ps1 -SiteServer "Server01" -SiteCode "CM1" -ParentFolderName "Departments\IT" 
     
    Returns all collections in the IT subfolder of the Departments folder 
 
    .NOTES 
        NAME:  Get-CollectionsByFolder.ps1 
        AUTHOR: Charles Downing
        LASTEDIT: 02/25/2013 
        KEYWORDS: 
    .LINK 
    http://blog.tyang.org/2011/05/20/powershell-script-to-locate-sccm-objects-in-sccm-console/ 
#> 
 
Param ( 
    [Parameter(Position=0)][string]$SiteServer, 
    [Parameter(Position=1)][string]$SiteCode, 
    [Parameter(Position=2)][string]$ParentFolderName, 
    [Parameter(Position=3)][bool]$Recurse = $true 
) 
 
# function adapted from http://blog.tyang.org/2011/05/20/powershell-script-to-locate-sccm-objects-in-sccm-console/ 
Function Get-ConsolePath ($CentralSiteProvider, $CentralSiteCode, $SCCMObj, $objContainer) 
{ 
    $ContainerNodeID = $SCCMObj.ContainerNodeID 
    $strConsolePath = $null 
    $bIsTopLevel = $false 
    $strConsolePath = $objContainer.Name 
    $ParentContainerID = $objContainer.ParentContainerNodeID 
    if ($ParentContainerID -eq 0) 
    { 
        $bIsTopLevel = $true 
    }  
    else  
    { 
        Do 
        { 
            $objParentContainer = Get-WmiObject ` 
                -Namespace root\sms\site_$CentralSiteCode ` 
                -Query "Select * from SMS_ObjectContainerNode Where ContainerNodeID = '$ParentContainerID'" ` 
                -ComputerName $CentralSiteProvider 
            $strParentContainerName = $objParentContainer.Name 
            $strConsolePath = $strParentContainerName + "`\" + $strConsolePath 
            $ParentContainerID = $objParentContainer.ParentContainerNodeID 
            Remove-Variable objParentContainer, strParentContainerName 
            if ($ParentContainerID -eq 0)  
            { 
                $bIsTopLevel = $true 
            } 
             
        } until ($bIsTopLevel -eq $true) 
    } 
    Return $strConsolePath 
} 
 
# get collection name, folder path and device count for a given collection 
Function GetCollectionInfo ($parentName, $site, $coll, $server) 
{ 
    $MembershipQuery = Get-WmiObject -Namespace "root\sms\Site_$site" ` 
        -Query "select collectionid from SMS_CollectionMember_a where collectionid='$($coll.CollectionID)'" ` 
        -Computername "$server" 
         
    if( $MembershipQuery.Count -ne $null) 
    { 
        $count = $MembershipQuery.Count 
    } 
    else 
    { 
        $count = 1 
    } 
         
    $collInfo = New-Object PSObject -Property @{ 
        CollectionName = $coll.Name 
        Path = $path 
        MemberCount = $count 
    } 
    $collInfo 
} 
 
 
##### Entry Point ##### 
 
$collectionArr = @() 
$d = 0 
 
# Get list of all collections on a given SiteServer for the given SiteCode 
$collectionQuery = Get-WmiObject ` 
    -Namespace "root\sms\Site_$SiteCode" ` 
    -Query "select Name,CollectionID,LastChangeTime,LastMemberChangeTime,LastRefreshTime from SMS_Collection where collectionid like'$SiteCode%'" ` 
    -ComputerName "$SiteServer" 
     
# Loop to process each collection 
foreach ($collection in $collectionQuery) { 
    $d++ 
    Write-Progress -Activity "Processing Collections" ` 
        -Status "Processed: $d of $($collectionQuery.count) " ` 
        -PercentComplete (($d / $collectionQuery.Count)*100) 
 
    # Get containerItem object for the collection 
    $SCCMObj = Get-WmiObject -Namespace "root\sms\Site_$SiteCode" ` 
        -Query "Select * from SMS_ObjectContainerItem Where InstanceKey = '$($collection.CollectionID)'" ` 
        -ComputerName "$SiteServer" 
     
    if($SCCMObj -ne $null) 
    { 
        # Get containerNode object for the collection 
        $objContainer = Get-WmiObject -Namespace "root\sms\Site_$SiteCode" ` 
            -Query "Select * from SMS_ObjectContainerNode Where ContainerNodeID = '$($SCCMObj.ContainerNodeID)'" ` 
            -ComputerName "$SiteServer" 
         
        if($objContainer -ne $null) 
        { 
            # Get full folder path to collection 
            $path = Get-ConsolePath $SiteServer $SiteCode $SCCMObj $objContainer 
 
            # Recurse flag tells code to display everything in the ParentFolderName folder and below 
            if($Recurse) 
            { 
                # Push collection to the results array if ANY part of the path contains the folder name 
                if($path.contains($ParentFolderName)) 
                { 
                    $collectionArr += GetCollectionInfo $ParentFolderName $SiteCode $collection $SiteServer 
                } 
            } 
            else 
            { 
                # Push collection the results array only if the LAST part of the path is the folder name 
                if($path.EndsWith($ParentFolderName)) 
                { 
                    $collectionArr += GetCollectionInfo $ParentFolderName $SiteCode $collection $SiteServer 
                } 
            } 
        } 
    } 
} 
$collectionArr | Sort-Object -Property "CollectionName"