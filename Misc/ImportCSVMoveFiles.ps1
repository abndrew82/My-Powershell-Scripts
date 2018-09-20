$Destination = "D:\dataplace"
$datafilepath = Import-Csv D:\Alumni.csv | Select -ExpandProperty FiletoMove
ForEach ($Path in $datafilepath)
{
Write-Host $Path
#Move-Item -Path $data -Destination $Destination -Force
}