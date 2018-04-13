$ErrorActionPreference = "SilentlyContinue"
$Computers = Get-CMDevice -CollectionName "Asenn-test-boxes" | Select -ExpandProperty Name
ForEach ($Computer in $Computers)
{
$TestConn = Test-Connection -ComputerName $Computer -Count 1 -quiet
If ($TestConn -eq $True)
{
$Status = "Online"
Write-Host $Computer "|" $Status
}
ElseIf ($TestConn -eq $false)
{
$Status = "Offline"
Write-Host $Computer "|" $Status
}
}