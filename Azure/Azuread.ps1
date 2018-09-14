Connect-MsolService
Connect-AzureAD
Get-AzureADDevice | Select DisplayName | Sort-Object DisplayName
Get-AzureADDevice | Where-Object {$_.DisplayName -like "*DESKTOP*"}
Get-AzureADDevice -ObjectId "755ed890-dc6a-4b91-b061-d60d77c29a2c"
Get-MsolDevice -All | Where-Object {$_.DeviceTrustType -eq "Azure AD Joined" } | Select DisplayName, Enabled, DeviceTrustType, DeviceTrustLevel | Sort-Object dISPLAYNAME
DESKTOP-23NC2QJ
Get-MsolDevice -All | Where-Object {$_.Displayname -eq "DESKTOP-23NC2QJ"} 