﻿$a = Import-Csv D:\CompRename.csv -Header OldName, NewName
Foreach ($Computer in $a ) {Rename-Computer -ComputerName $Computer.OldName -NewName $Computer.NewName -DomainCredential Domain01\Admin01 -Force -Restart}