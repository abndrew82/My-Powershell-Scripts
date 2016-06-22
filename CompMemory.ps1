$x = read-host -prompt "Please enter the machine name: "  

$colItems = get-wmiobject -class "Win32_ComputerSystem" -namespace "root\CIMV2" -computername $x

foreach ($objItem in $colItems){
$displayGB = [math]::round($objItem.TotalPhysicalMemory/1024/1024/1024, 0)
write-host "Total Physical Memory: " $displayGB "GB"
write-host "Model: " $objItem.Model
}

$colItems = get-wmiobject -class "Win32_Processor" -namespace "root\CIMV2" -computername $x
foreach ($objItem in $colItems){
write-host "System Name: " $objItem.SystemName
}