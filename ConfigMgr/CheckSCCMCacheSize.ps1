﻿$cachesize = Get-WmiObject -namespace root\ccm\SoftMgmtAgent -class CacheConfig
If ($cachesize.size -ge "40960")
{
Exit 0
}
Else
{
Exit 999
}
