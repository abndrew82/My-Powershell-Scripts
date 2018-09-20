Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location FS1:\
$Computers = Get-Content F:\LSA125Computers.txt
#$Computers = Get-Content -Path $PSScriptRoot\LSA125Computers.txt
ForEach ($Computer in $Computers)
{
$Online = Test-Connection -ComputerName $Computer -Count 1 -Quiet
If ($Online -eq $true)
{
        $Procs = Get-CimInstance -ComputerName $Computer Win32_Process -Filter "name = 'explorer.exe'" | Select-Object -ExpandProperty Name 
        If ($Procs.Length -eq "2" -or $Procs.Length -eq "3" -or $Procs.Length -eq "4" -or $Procs.Length -eq "5" -or $Procs.Length -eq "6")
        {
         Write-Host "$Computer has Multiple Users Logged on, The Number of Users is" $Procs.Length
        }
        ElseIf ($Procs.Length -eq "12")
        {
        Write-Host "$Computer has a Single User Logged on"
        }
}
else {
    Write-Host "$Computer is Offline"
}
}

