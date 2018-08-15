Import-Module -Name vm*
Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password "G0St33l3r$"
$VMS = Get-HVMachine -State Error
$selectdesktop=@()
foreach ($vm in $VMs)
{
$selectdesktop += $VM.Base.Name
 #Write-Output $VM.Base.Name
}
Write-Output $selectdesktop