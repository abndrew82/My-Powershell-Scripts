Connect-MsolService
(Get-MsolDevice -All).count
Get-MsolDevice -All | Select DisplayName, DeviceTrustType
Get-MsolDevice -All | Where-Object {$_.DeviceTrustType -eq "Azure AD Joined"} | Select DisplayName, DeviceTrustType