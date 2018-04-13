$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-Content D:\cook.txt
ForEach ($Comp in $Comps)
{
$AssetTag = Get-WmiObject -ComputerName $Comp -Class Win32_SystemEnclosure | Select -ExpandProperty SMBIOSAssetTag
Write-Host $Comp "|" $AssetTag
$Output = $Comp + "," + $AssetTag
Out-File D:\CookComps.txt -InputObject $Output -Append
}