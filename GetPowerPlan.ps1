﻿Get-WmiObject -ComputerName FSU99732S -Class win32_powerplan -Namespace root\cimv2\power -Filter "isActive='true'"