$Computers = Get-CMDevice -CollectionId "FS10021A" | Select -ExpandProperty Name | Sort-Object Name
ForEach ($Comp in $Computers)
{
$identfinder = Get-WmiObject -ComputerName $Comp -Class Win32_Product -Filter "Name like '%Identity%'" | Select -ExpandProperty Name
$Spirion = Get-WmiObject -ComputerName $Comp -Class Win32_Product -Filter "Name like '%Spirion%'" | Select -ExpandProperty Name
If ($identfinder -eq "Identity Finder")
{
$Name = Get-WmiObject -ComputerName $Comp -Class Win32_Product -Filter "Name like '%Identity%'" | Select -ExpandProperty Name
$Version = Get-WmiObject -ComputerName $Comp -Class Win32_Product -Filter "Name like '%Identity%'" | Select -ExpandProperty Version
Write-Host $Comp "|" $Name "|" $Version
}
ElseIf ($Spirion -eq "Spirion")
{
$Name = Get-WmiObject -ComputerName $Comp -Class Win32_Product -Filter "Name like '%Spirion%'" | Select -ExpandProperty Name
$Version = Get-WmiObject -ComputerName $Comp -Class Win32_Product -Filter "Name like '%Spirion%'" | Select -ExpandProperty Version
Write-Host $Comp "|" $Name "|" $Version
}
}