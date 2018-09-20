Import-Module "c:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1" # Import the ConfigurationManager.psd1 module 
Set-Location "FS1:" # Set the current location to be the site code.
$main = $Null 
$i = 0
$TimeDate = Date
#$head = (Get-Content C:\Users\asenn\Documents\head2.html) -replace '%4',(get-date).DateTime
#$tail = Get-Content C:\Users\asenn\Documents\tail.html
$style = 'style5'
$ErrorActionPreference = "SilentlyContinue"
$Computers = Get-CMDevice -CollectionName "LSA 125" | Select -ExpandProperty Name
$CompsSorted = $Computers | Sort-Object
ForEach ($Computer in $CompsSorted)
{
$i++
$TestConn = Test-Connection -ComputerName $Computer -Count 1 -quiet
If ($TestConn -eq $True)
{
$Status = "Online"
$Memory = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | ForEach-Object {[math]::truncate($_.TotalPhysicalMemory / 1GB)}
$Memory = $Memory + 1
$Memory = "$Memory GB"
$Manufacturer = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | Select -ExpandProperty Manufacturer
$Model = Get-WmiObject Win32_ComputerSystem -ComputerName $Computer | Select -ExpandProperty Model
$LoggedonUser = Get-WmiObject –ComputerName $Computer –Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
}
ElseIf ($TestConn -eq $false)
{
$Status = "Offline"
$Memory = ""
$Manufacturer = ""
$Model = ""
$LoggedonUser = ""
}
$tile = @"
  <tr>	
    <td>$Computer</td>
    <td>$Status</td>
    <td>$Manufacturer</td>
    <td>$Model</td>
    <td>$Memory</td>
	<td>$LoggedonUser</td>
  </tr>
"@
$main += $tile
}
$Html = $main
$html > C:\Users\asenn\Documents\LSA125MoreInfo.html