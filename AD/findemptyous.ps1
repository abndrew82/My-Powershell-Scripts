﻿Get-ADOrganizationalUnit -Filter 'Name -like "*"' -SearchBase "OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu"  | Where { -not(Get-ADObject -Filter 'Name -like "*"' -SearchBase $_.DistinguishedName -SearchScope OneLevel -ResultSetSize 1 -ErrorAction SilentlyContinue)} | select DistinguishedName