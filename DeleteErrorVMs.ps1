Import-Module -Name vm*
$hvserver1=Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password "G0St33l3r$"
$spec = New-Object VMware.Hv.machinedeletespec
$Services1= $hvServer1.ExtensionData
$spec.deleteFromDisk=$TRUE
$VMS = Get-HVMachine -State Error
$selectdesktop=@()
foreach ($vm in $VMs)
{
$selectdesktop += $VM.Base.Name
Write-Output $VM.Base.Name
$services1.machine.machine_delete($VM.id)
}
