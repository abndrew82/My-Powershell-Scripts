﻿$BannerNumber = Get-Content \\fsu27524s\share\termemail.txt | Where-Object {$_  -match '\b(830(?:\d{6}))\b' } | ForEach-Object { $Matches[0] }  # misses multiple matches on same line
Get-ADUser -Filter * -Properties extensionAttribute2 | Where-Object {$_.extensionAttribute2 -eq $BannerNumber} | Select-Object -ExpandProperty SamAccountName