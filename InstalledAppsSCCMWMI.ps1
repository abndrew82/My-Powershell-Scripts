Get-WmiObject -Namespace root\cimv2\sms -Class SMS_InstalledSoftware `
| Select ProductName, ProductVersion | Sort-Object