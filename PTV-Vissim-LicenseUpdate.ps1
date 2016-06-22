$FilePath = "C$\Program Files (x86)\PTV Vision\PTV Vissim 7\Exe\"
#Write-Host $FilePath
$comps = Get-Content X:\share\apsenn\My-Powershell-Scripts\415comps.txt
Write-Host \\$Comps\$FilePath
ForEach ($comp in $comps)
{
$fullpath = "\\" + $comp + "\" + $FilePath
#Write-Host $fullpath
xcopy /F /Y X:\Share\apsenn\ptv\2016\110061_VISSIM700_900960053_60user_win32_2016_06_30_Init\VISSIM70.OVL $fullpath
}