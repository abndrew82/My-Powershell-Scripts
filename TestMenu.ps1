Import-Module C:\Users\asenn\Documents\GitHub\My-Powershell-Scripts\Write-Menu.ps1
$Choice = Write-Menu -Title "Yes vs No" -Entries @('Yes', 'No')
If ($Choice -eq "Yes")
{write-Host "yeah Baby"}
Elseif ($Choice -eq "No")
{Write-Host "NO NO Baby"}
