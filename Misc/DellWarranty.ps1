#===========================================================================================
# AUTHOR:         Natascia Heil
# Script Name:    GetDellWarrantyInfo.ps1
# DATE:           09/09/2016
# Version:        1.0
# COMMENT:        – Script to check Warranty information for a computer from the
#                 Dell Warranty Status API
# Example:        .\GetDellWarrantyInfo.ps1 -ServiceTag ‘1a2b3c’ -ApiKey “sdfj7122394057sdfiouwer” -Dev $true
#===========================================================================================
Param(
[Parameter(Mandatory=$true)]
[String]$ServiceTag,
[Parameter(Mandatory=$true)]
[String]$ApiKey,
[Parameter(Mandatory=$true)]
[Bool]$Dev
)
#Build URL
If ($Dev)
{
$URL1 = “https://sandbox.api.dell.com/support/assetinfo/v4/getassetwarranty/$ServiceTag"
}
else
{
$URL1 = “https://sandbox.api.dell.com/support/assetinfo/v4/getassetwarranty/$ServiceTag"
}
$URL2 = “?apikey=$Apikey”
$URL = $URL1 + $URL2
# Get Data
$Request = Invoke-RestMethod -URI $URL -Method GET -contenttype 'Application/xml'
# Extract Warranty Info
$Warranty=$Request.AssetWarrantyDTO.AssetWarrantyResponse.AssetWarrantyResponse.AssetEntitlementData.AssetEntitlement|where ServiceLevelDescription -NE ‘Dell Digitial Delivery’
# Read first entry if available
If ($Warranty -is [Object])
{
$SLA=$Warranty[0].ServiceLevelDescription
$EndDate=$Warranty[0].EndDate
Write-Host $SLA
Write-Host $EndDate
}
else
{
$SLA=’Expired’
Write-Host $SLA
}
