#Connect-MsolService
$ActiveUnits = Get-MsolAccountSku | Where {$_.AccountSkuId -eq "broncosuncfsu:ENTERPRISEPACK_FACULTY"} | Select -ExpandProperty ActiveUnits
$Consumed = Get-MsolAccountSku | Where {$_.AccountSkuId -eq "broncosuncfsu:ENTERPRISEPACK_FACULTY"} | Select -ExpandProperty ConsumedUnits
$AvailableUnits = $ActiveUnits - $Consumed
If ($AvailableUnits -ge "6666")
{
Write-Host "YEAH"  $AvailableUnits "Are Available"
}
Else
{
Write-Host "NO NO NO NO" $AvailableUnits  "Are Available"
}