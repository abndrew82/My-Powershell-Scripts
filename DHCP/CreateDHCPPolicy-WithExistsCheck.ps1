Param(
[Parameter(Mandatory=$true)]
[String]
$ScopeID
)
$PolicyTest01 = Get-DhcpServerv4Policy -ComputerName DHCP01B -ScopeId $ScopeID | Where-Object {$_.Name -like "*Right File*"} | select -ExpandProperty Name
If ($PolicyTest01 -ne $null)
{
Write-Host "Policy Already Exists on DHCP01B for $ScopeID"
}
Else
{
Write-Output "Butler Side"
Write-Output "Creating UEFI Vendor Policy"
Add-DhcpServerv4Policy -ComputerName DHCP01B -ScopeId $ScopeID  -Condition And -VendorClass EQ, "PXEClient (UEFI x64)*" -Name "Right File Name for x64 UEFI" -Description "Policy for send right boot file for UEFI" 
Write-Output "Creating BIOS Vendor Policy"
Add-DhcpServerv4Policy -ComputerName DHCP01B -ScopeId $ScopeID  -Condition And -VendorClass EQ, "PXEClient (BIOS x64)*" -Name "Right File Name for BIOS x64" -Description "Policy will send right boot file name for Bios x64"
Write-Output "Setting UEFI Policy Options"
Set-DhcpServerv4OptionValue -ComputerName DHCP01B -PolicyName "Right File Name for x64 UEFI" -ScopeId $ScopeID -OptionId 66 -Value 10.4.3.16
Set-DhcpServerv4OptionValue -ComputerName DHCP01B -PolicyName "Right File Name for x64 UEFI" -ScopeId $ScopeID -OptionId 67 -Value "smsboot\x64\wdsmgfw.efi"
Write-Output "Setting BIOS Policy Options"
Set-DhcpServerv4OptionValue -ComputerName DHCP01B -PolicyName "Right File Name for BIOS x64" -ScopeId $ScopeID -OptionId 66 -Value 10.4.3.16
Set-DhcpServerv4OptionValue -ComputerName DHCP01B -PolicyName "Right File Name for BIOS x64" -ScopeId $ScopeID -OptionId 67 -Value "smsboot\x64\wdsnbp.com"
}
$PolicyTest02 = Get-DhcpServerv4Policy -ComputerName DHCP02A -ScopeId $ScopeID | Where-Object {$_.Name -like "*Right File*"} | select -ExpandProperty Name
If ($PolicyTest02 -ne $null)
{
Write-Host "Policy Already Exists on DHCP02A for $ScopeID"
}
Else
{
Write-Output "Sci Tech Side"
Write-Output "Creating UEFI Vendor Policy 02"
Add-DhcpServerv4Policy -ComputerName DHCP02A -ScopeId $ScopeID  -Condition And -VendorClass EQ, "PXEClient (UEFI x64)*" -Name "Right File Name for x64 UEFI" -Description "Policy for send right boot file for UEFI" 
Write-Output "Creating BIOS Vendor Policy 02"
Add-DhcpServerv4Policy -ComputerName DHCP02A -ScopeId $ScopeID  -Condition And -VendorClass EQ, "PXEClient (BIOS x64)*" -Name "Right File Name for BIOS x64" -Description "Policy will send right boot file name for Bios x64"
Write-Output "Setting UEFI Policy Options 02"
Set-DhcpServerv4OptionValue -ComputerName DHCP02A -PolicyName "Right File Name for x64 UEFI" -ScopeId $ScopeID -OptionId 66 -Value 10.4.3.16
Set-DhcpServerv4OptionValue -ComputerName DHCP02A -PolicyName "Right File Name for x64 UEFI" -ScopeId $ScopeID -OptionId 67 -Value "smsboot\x64\wdsmgfw.efi"
Write-Output "Setting BIOS Policy Options 02"
Set-DhcpServerv4OptionValue -ComputerName DHCP02A -PolicyName "Right File Name for BIOS x64" -ScopeId $ScopeID -OptionId 66 -Value 10.4.3.16
Set-DhcpServerv4OptionValue -ComputerName DHCP02A -PolicyName "Right File Name for BIOS x64" -ScopeId $ScopeID -OptionId 67 -Value "smsboot\x64\wdsnbp.com"
}