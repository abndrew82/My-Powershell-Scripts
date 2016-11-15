$ErrorActionPreference = "SilentlyContinue"
$comps = Get-Content D:\but386.txt
ForEach ($Comp in $comps)
{
$Bootdrive = Get-WmiObject -ComputerName $Comp  -Class win32_volume -Filter "BootVolume = 'True'" | Select -ExpandProperty DriveLetter
If ($Bootdrive -ne "C:")
{
#Write-Host "Boot Drive is not C"
Write-Host $Comp "|" $Bootdrive
}
Else
{
Write-Host $Comp "| " "Boot Drive is already C"
}
}