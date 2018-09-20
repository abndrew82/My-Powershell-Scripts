$From = “SCCM Admin <SCCMAdmin@uncfsu.edu>”
$To = @("Andrew <asenn@uncfsu.edu>")
$SmtpServer = “webmail.uncfsu.edu”
$Subject = “Computer Account Count Difference”
$CompsOU = Get-ADComputer -Filter * -SearchBase "CN=Computers,DC=uncfsu,DC=edu"
$COU = "There are " + $CompsOU.Count + " In the Computers OU"
$1Sort = Get-ADComputer -Filter * -SearchBase "OU=1 - Sort,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu"
$1SortOU = "There are " + $1Sort.Count + " In the 1 Sort OU"
$Disabled = Get-ADComputer -Filter * -SearchBase "OU=Disabled Computers,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu"
$DisabledOU = "There are " + $Disabled.Count + " In the Disabled Computers OU"
$AllFSU = Get-ADComputer -Filter * -SearchBase "DC=uncfsu,DC=edu"
$AllOUS =  "There are " + $AllFSU.Count + " Total Computers in the FSU Domain"
$AllServers = Get-ADComputer -Filter * -SearchBase "OU=Servers,OU=FSU,DC=uncfsu,DC=edu"
$ServersOU = "There are " + $AllServers.Count + " Total Servers in the Servers OU"
$YesterdayCompsOU = Get-Content C:\Windows\Temp\Compsou.txt
$YesterdayDifference = $CompsOU.Count - $YesterdayCompsOU
$Yesterday1SortOU = Get-Content C:\Windows\Temp\1Sortou.txt
$YesterdayDifference2 = $1Sort.Count - $Yesterday1SortOU
$YesterdayDisabledOU = Get-Content C:\Windows\Temp\Disabledou.txt
$YesterdayDifference3 = $Disabled.Count - $YesterdayDisabledOU
$YesterdayAllFSU = Get-Content C:\Windows\Temp\Allou.txt
$YesterdayDifference4 = $AllFSU.Count - $YesterdayAllFSU
$YesterdayServers = Get-Content C:\Windows\Temp\Serversou.txt
$YesterdayDifference5 = $AllServers.Count - $YesterdayServers
Out-File C:\Windows\Temp\Compsou.txt -InputObject $CompsOU.Count
Out-File C:\Windows\Temp\1Sortou.txt -InputObject $1Sort.Count
Out-File C:\Windows\Temp\Disabledou.txt -InputObject $Disabled.Count
Out-File C:\Windows\Temp\Allou.txt -InputObject $AllFSU.Count
Out-File C:\Windows\Temp\Serversou.txt -InputObject $AllServers.Count
$AllInfo = $COU + " A Difference of " + $YesterdayDifference + " Computers" +
"`n" + $1SortOU + " A Difference of " + $YesterdayDifference2 + " Computers" +
"`n" + $DisabledOU + " A Difference of " + $YesterdayDifference3 +  " Computers" +
"`n" + $AllOUS + " A Difference of " + $YesterdayDifference4 +  " Computers" +
"`n" + $ServersOU + " A Difference of " + $YesterdayDifference5 + " Computers"
$Message = $AllInfo
Send-MailMessage -Subject $Subject -Body $Message -From $From -To $To -SmtpServer $SmtpServer
