$Comps = Get-Content C:\Users\asenn\Downloads\CorrectNames.txt
ForEach ($Comp in $comps)
{
$ConnTest = Test-Connection $Comp -Quiet
If ($ConnTest -eq "True")
{
$Fsutag = Invoke-command -computer $Comp {Get-ItemProperty "HKLM:\Software\UNCFSU" | Select -ExpandProperty "FSU Tag"} -ErrorAction SilentlyContinue
Write-Host $comp  "|"  $Fsutag
}
Else
{
Write-Host $Comp "|" " Computer Offline"
}
}