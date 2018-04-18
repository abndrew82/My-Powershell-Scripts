Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location FS1:\
$Windows10 = Get-CMDevice | Where-Object {$_.DeviceOS -like "*Workstation 10*"} | Select-Object -ExpandProperty Name
$Windows7 = Get-CMDevice | Where-Object {$_.DeviceOS -like "*Workstation 6.1*"} | Select-Object -ExpandProperty Name
$TotalsDevices = Get-CMDevice | Where-Object {$_.DeviceOS -notlike "*Server*" -and $_.DeviceOS -notlike "*mac*"} | Select-Object -ExpandProperty Name
$script:Thresholds = @{}
$Thresholds.Good = 90
$Thresholds.Warning = 80
$Thresholds.Inventory = @{} # Inventory thresholds are applicable to HW inventory, SW inventory and Heartbeat (DDR) only
$Thresholds.Inventory.Good = 85
$Thresholds.Inventory.Warning = 70
#endregion
function Set-PercentageColour {
    param(
    [int]$Value,
    [switch]$UseInventoryThresholds
    )

    If ($UseInventoryThresholds)
    {
        $Good = $Thresholds.Inventory.Good
        $Warning = $Thresholds.Inventory.Warning
    }
    Else
    {
        $Good = $Thresholds.Good
        $Warning = $Thresholds.Warning      
    }

    If ($Value -ge $Good)
    {
        $Hex = "#00ff00" # Green
    }

    If ($Value -ge $Warning -and $Value -lt $Good)
    {
        $Hex = "#ff9900" # Amber
    }

    If ($Value -lt $Warning)
    {
        $Hex = "#FF0000" # Red
    }

    Return $Hex
}
$Win10 = [Math]::Round($Windows10.Count / ($TotalsDevices.Count) * 100)
$Win7 = [Math]::Round($Windows7.Count / ($TotalsDevices.Count) * 100)
$Not10 = $TotalsDevices.Count - $Windows10.Count
$Not7 = $TotalsDevices.Count - $Windows7.Count
$html = @"
<h2>Percent of Computers running Windows 10</h2>
<table cellpadding="0" cellspacing="0" width="400">
<tr>
  <td style="background-color:$(Set-PercentageColour -Value $Win10);padding:10px;color:# #ff5733 ;" width="$($Win10)%">
    $($Win10)%
  </td>
  <td style="background-color:#eeeeee;padding-top:10px;padding-bottom:10px;color:#33bbff;" width="$($Not10)%">
  </td>
</tr>
</table>
"@

$html = $html + @"
<h2>Percentage of Computers running Windows 7</h2>
<table cellpadding="0" cellspacing="0" width="400">
<tr>
  <td style="background-color:$(Set-PercentageColour -Value $Win7);padding:10px;color:# #ff5733 ;" width="$($Win7)%">
    $($Win7)%
  </td>
  <td style="background-color:#eeeeee;padding-top:10px;padding-bottom:10px;color:#33bbff;" width="$($Not7)%">
  </td>
</tr>
</table>
"@

Out-File C:\Users\asenn\what.html -InputObject $html