Remove-Variable * -ErrorAction SilentlyContinue
Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location FS1:\
#$Computers = Get-Content F:\LSA125Computers.txt
$Computers = Get-Content -Path $PSScriptRoot\LSA125Computers.txt
$Title = "<h2>Computers with Logged on Users<p><b></h2><p>"
$header = ' <head><meta http-equiv="refresh" content="180"></head><table border="1">
<tr><td><b>Computer Name</b></td>
<td><b>Status</b></td>
<td><b># of Users</b></td>
</tr>'
$Footer ="</table>"
ForEach ($Computer in $Computers)
{
$Online = Test-Connection -ComputerName $Computer -Count 1 -Quiet
If ($Online -eq $true)
{
        $Procs = Get-CimInstance -ComputerName $Computer Win32_Process -Filter "name = 'explorer.exe'" | Select-Object -ExpandProperty Name 
        If ($Procs.Length -eq "2" -or $Procs.Length -eq "3" -or $Procs.Length -eq "4" -or $Procs.Length -eq "5" -or $Procs.Length -eq "6")
        {
         #Write-Host "$Computer has Multiple Users Logged on, The Number of Users is" $Procs.Length
         $Count = $Procs.Length
         $Data += "<tr><td><b>$Computer</b></td><td><b>has Multiple Users Logged on</b></td><td><b><center>$Count</center></b></td></tr>"
        }
        ElseIf ($Procs.Length -eq "12")
        {
        $Count = "1"
        #Write-Host "$Computer has a Single User Logged on"
        $Data += "<tr><td>$Computer</td><td>has a Single User Logged on</td><td><center>$Count</center></td></tr>"
        }
}
else {
    #Write-Host "$Computer is Offline"
    $Data += "<tr><td>$Computer</td><td>Is Offline</td><td><center>0</center></td></tr>"
}
$html = $Title + $header + $Data + $Footer
Out-file $env:TEMP\LSAon.html -InputObject $html -Force
}