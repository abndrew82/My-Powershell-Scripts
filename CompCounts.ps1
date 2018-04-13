$TotalComps = Get-ADComputer -Filter {enabled -eq $True} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Total Computer Accounts =" $TotalComps.Count
$Windows7 = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Windows 7*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows 7 OS =" $Windows7.Count
$Windows81 = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Windows 8*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows 8/8.1 OS =" $Windows81.Count
$Windows10 = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Windows 10*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows 10 OS =" $Windows10.Count
$WindowsServer = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Server*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows Server OS =" $WindowsServer.Count
$WindowsServer = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Server 2003*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows Server 2003 =" $WindowsServer.Count
$WindowsServer = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Server*2008*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows Server 2008 =" $WindowsServer.Count
$WindowsServer = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Server 2012*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows Server 2012 =" $WindowsServer.Count
$WindowsServer = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*Server 2016*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
write-Host "Windows Server 2016 =" $WindowsServer.Count





