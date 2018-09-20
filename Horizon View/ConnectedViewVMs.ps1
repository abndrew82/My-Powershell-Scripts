Import-Module -Name vm*
Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password "G0St33l3r$"
$VMS = Get-HVMachine -State CONNECTED
$selectdesktop=@()
foreach ($vm in $VMs)
{
#$selectdesktop += $VM.Base.Name
 
$data = $VM.Base.Name + " | " + $VM.Base.Type + " | " + $VM.Base.OperatingSystem
Write-Host $data
}
