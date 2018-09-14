$cm = New-Object -ComObject UIResource.UIResourceMgr
$cmcache = $cm.GetCacheInfo()
$cmcache.GetCacheElements() | Foreach-Object {
    $eid = $_.CacheElementId
    $cmcache.DeleteCacheElement($eid)
}