$FilePath = "C$\Program Files\PTV Vision\PTV Vistro 3\Exe\"
#Write-Host $FilePath
$comps = Get-Content X:\share\apsenn\My-Powershell-Scripts\415comps.txt
Write-Host \\$Comps\$FilePath
ForEach ($comp in $comps)
{
$fullpath = "\\" + $comp + "\" + $FilePath
#Write-Host $fullpath
xcopy /F /Y x:\share\apsenn\ptv\2016\110061_VISTRO300_900960053_60user_win32_2016_06_30_Init\Litt.chr $fullpath
}