﻿Get-Content -Path C:\Users\asenn\Documents\connectoptions.txt
(Get-Content 'C:\Users\asenn\Documents\connectoptions.txt') | ForEach-Object {$_ -replace 'Fort Bragg','ITTS Training'} | Out-File 'C:\Users\asenn\Documents\connectoptions.txt'