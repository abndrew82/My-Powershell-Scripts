$ComputerName = Read-Host "Please Enter a Computer Name"
$SiteCode = "FS1"
$SiteServer = "FSUSCCM"
$ResourceID = Get-CMDevice -Name $ComputerName | Select -ExpandProperty ResourceID
C:\Users\asenn\Documents\GitHub\My-Powershell-Scripts\ShowCollectionDetails_v1_1p.ps1 -ResourceId $ResourceID -SiteCode $SiteCode -SiteServer $SiteServer