Import-Module "c:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1" # Import the ConfigurationManager.psd1 module 
Set-Location "FS1:" # Set the current location to be the site code.
#zero out variables before beginning (helps for working on file in ISE
$main = $Null 
$i = 0
$TimeDate = Date
$head = (Get-Content C:\Users\asenn\Documents\head.html) -replace '%4',(get-date).DateTime
$tail = Get-Content D:\HTML5-Dashboard\tail.html
$Command1 = "OU Counts"
$Command2 = "SCCM Counts"
$style = 'style5'
$Commands = $Command1, $Command2
ForEach ($Command in $Commands)
{
$i++
If ($Command -eq "OU Counts")
{
$style = 'style1'
$Name = "OU Counts"
$CompsOU = Get-ADComputer -Filter {enabled -eq $True} -SearchBase "CN=Computers,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$1SortOU = Get-ADComputer -Filter {enabled -eq $True} -SearchBase "OU=1 - Sort,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$DisabledOU = Get-ADComputer -Filter {enabled -ne $True} -SearchBase "OU=Disabled Computers,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$TotalAll = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -notlike "*Server*")} -SearchBase "DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$TotalServers = Get-ADComputer -Filter {enabled -eq $True} -SearchBase "OU=Servers,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$Macs = Get-ADComputer -Filter {(enabled -eq $True) -and (OperatingSystem -like "*MAC*")} -SearchBase "OU=Workstations - MAC OSX,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$Workstations = Get-ADComputer -Filter {enabled -eq $True} -SearchBase "OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$Labs = Get-ADComputer -Filter {enabled -eq $True} -SearchBase "OU=Labs,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name
$MacCount = $Macs.Count
$WorkstationsCount = $Workstations.Count
$LabsCount = $Labs.Count
$TotalComps = $CompsOU.Count
$Total1Sort = $1SortOU.Count
$TotalDisabled = $DisabledOU.Count
$Total = $TotalAll.Count
$ServerCount = $TotalServers.Count
}
ElseIf ($Command -eq "SCCM Counts")
{
$style = 'style2'
$Name = "SCCM #'s"
$GetCount =  Get-CMDevice
$TotalCount = $GetCount.Count
$AllBuildings = Get-CMDevice -CollectionId "FS100117"
$AllLabs = Get-CMDevice -CollectionId "FS100110"
$AllServers = Get-CMDevice -CollectionId "FS100115"
$ActiveSystems = Get-CMDevice -CollectionId "FS100113"
$Laptops = Get-CMDevice -CollectionId "FS100204"
$Dells = Get-CMDevice -CollectionId "FS10008D"
$SCCM7 = Get-CMDevice -CollectionId "FS100128"
$SCCM8 = Get-CMDevice -CollectionId "FS10004E"
$SCCM10 = Get-CMDevice -CollectionId "FS10019B"
$SCCM2008 = Get-CMDevice -CollectionId "FS100051"
$SCCM2012 = Get-CMDevice -CollectionId "FS100053"
$SCCM2016 = Get-CMDevice -CollectionId "FS100217"
$HPS = Get-CMDevice -CollectionId "FS100094"
$DellCount = $Dells.Count
$HPCount = $HPS.Count
$ActiveCount = $ActiveSystems.Count
$laptopcount = $Laptops.count
$ServerCount2 = $AllServers.Count
$7Count = $SCCM7.Count
$8Count = $SCCM8.Count
$10Count = $SCCM10.Count
$2008Count = $SCCM2008.Count
$2012Count = $SCCM2012.Count
$2016Count = $SCCM2016.Count
$Count2 = $AllBuildings.Count
$Count3 = $AllLabs.Count
}
}
$Page = @"
<body bgcolor="#0067B1">
<b>Last Update: $TimeDate</b>
<center><h1>Active Directory</h1></center>
<center>
 <table border=1 style="display: inline-block;" align="center" bgcolor="#B0B7BC">
  <tr>
    <th><font color="#00A94F"><font size="6">OU</font></th>
    <th><font color="#00A94F"><font size="6"># of Computers</font></th>
  </tr>
  <font  size="4">
  <tr>
    <td>All AD</td>
    <td>$Total</td>
  </tr>
  <tr>
    <td>1 Sort</td>
    <td>$Total1Sort</td>
  </tr>
  <tr>
    <td>Computers</td>
    <td>$TotalComps</td>
  </tr>
  <tr>
    <td>Disabled</td>
    <td>$TotalDisabled</td>
  </tr>  
  <tr>
    <td>Servers</td>
    <td>$ServerCount</td>
  </tr>  
  <tr>
    <td>Macintosh's</td>
    <td>$MacCount</td>
  </tr>  
  <tr>
    <td>Workstations</td>
    <td>$WorkstationsCount</td>
  </tr>  
  <tr>
    <td>Labs</td>
    <td>$LabsCount</td>
  </tr>  
  </font>
</table>
 <table border=1 style="display: inline-block;" align="center" bgcolor="#B0B7BC">
  <tr>
    <th><font color="#00A94F"><font size="6">Server OS Version</font></th>
    <th><font color="#00A94F"><font size="6">Count</font></th>
  </tr>
  <font  size="4">
  <tr>
    <td>Server 2003</td>
    <td>10</td>
  </tr>
  <tr>
    <td>Server 2008</td>
    <td>55</td>
  </tr>
  <tr>
    <td>Server 2012</td>
    <td>76</td>
  </tr>
  <tr>
    <td>Server 2016</td>
    <td>7</td>
  </tr> 
</table>
 <table border=1 style="display: inline-block;" align="center" bgcolor="#B0B7BC">
  <tr>
    <th><font color="#00A94F"><font size="6">Client OS Version</font></th>
    <th><font color="#00A94F"><font size="6">Count</font></th>
  </tr>
  <font  size="4">
  <tr>
    <td>Windows 7</td>
    <td>2285</td>
  </tr>
  <tr>
    <td>Windows 8/8.1</td>
    <td>15</td>
  </tr>
  <tr>
    <td>Windows 10</td>
    <td>121</td>
  </tr>
</table>
</center>
 
<br>
<center><h1>System Center</h1></center>
<center>
 <table border=1 style="display: inline-block;" align="center" bgcolor="#B0B7BC">
  <tr>
    <th><font color="#00A94F"><font size="6">Collection</font></th>
    <th><font color="#00A94F"><font size="6"># of Computers</font></th>
  </tr>
  <font  size="4">
  <tr>
    <td>All Systems</td>
    <td>$TotalCount</td>
  </tr>
  <tr>
    <td>All FSU Systems</td>
    <td>$ActiveCount</td>
  </tr>
  <tr>
    <td>Servers</td>
    <td>$ServerCount2</td>
  </tr>
  <tr>
    <td>All FSU Buildings</td>
    <td>$Count2</td>
  </tr>  
  <tr>
    <td>All FSU Labs</td>
    <td>$Count3</td>
  </tr>  
  <tr>
    <td>Laptops</td>
    <td>$laptopcount</td>
  </tr>  
  <tr>
    <td>Dell's</td>
    <td>$DellCount</td>
  </tr>  
  <tr>
    <td>HP's</td>
    <td>$HPCount</td>
  </tr>  
  </font>
</table>
 <table border=1 style="display: inline-block;" align="center" bgcolor="#B0B7BC">
  <tr>
    <th><font color="#00A94F"><font size="6">Server OS Version</font></th>
    <th><font color="#00A94F"><font size="6">Count</font></th>
  </tr>
  <font  size="4">
  <tr>
    <td>Server 2008</td>
    <td>$2008Count</td>
  </tr>
  <tr>
    <td>Server 2012</td>
    <td>$2012Count</td>
  </tr>
  <tr>
    <td>Server 2016</td>
    <td>$2016Count</td>
  </tr>
</table>
 <table border=1 style="display: inline-block;" align="center" bgcolor="#B0B7BC">
  <tr>
    <th><font color="#00A94F"><font size="6">Client OS Version</font></th>
    <th><font color="#00A94F"><font size="6">Count</font></th>
  </tr>
  <font  size="4">
  <tr>
    <td>Windows 7</td>
    <td>$7Count</td>
  </tr>
  <tr>
    <td>Windows 8/8.1</td>
    <td>$8Count</td>
  </tr>
  <tr>
    <td>Windows 10</td>
    <td>$10Count</td>
  </tr>
</table>
</center>


"@
$Html = $head + $Page
$html > C:\Users\asenn\Documents\Dashboard.html