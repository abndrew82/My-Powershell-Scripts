$Computers = Get-Content C:\Users\asenn\Documents\SBE218.txt
ForEach ($Computer in $Computers)
{
$ProductName = Get-WmiObject -Namespace "root\cimv2" -Class Win32_Product -ComputerName $Computer -Filter "IdentifyingNumber LIKE '{028217A2-B0BC-4EB5-BCD5-A784BC22AC5F}'" | Select -ExpandProperty Name
$ProdIDNum = Get-WmiObject -Namespace "root\cimv2" -Class Win32_Product -ComputerName $Computer -Filter "IdentifyingNumber LIKE '{028217A2-B0BC-4EB5-BCD5-A784BC22AC5F}'" | Select -ExpandProperty IdentifyingNumber
Write-Host $Computer "|" $ProductName "|" $ProdIDNum
}