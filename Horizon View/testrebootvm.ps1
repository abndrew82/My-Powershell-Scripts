$hvserver1=Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password "G0St33l3r$"
$Services1= $hvServer1.ExtensionData
$VMS = Get-HVMachine
$selectdesktop=@()
foreach ($vm in $VMs)
{
If ($VM.Base.BasicState -eq "PROVISIONING_ERROR")
{
Write-Host "$VM.Base.Name is in Provisioning Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}
ElseIf ($Vm.Base.BasicState -eq "Error")
{
Write-Host "$VM.Base.Name is in Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_UNREACHABLE")
{
Write-Host "$VM.Base.Name is in Agent Unreachable Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_ERR_STARTUP_IN_PROGRESS")
{
Write-Host "$VM.Base.Name is in Agent Startup Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_ERR_DISABLED")
{
Write-Host "$VM.Base.Name is in Agent Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_ERR_INVALID_IP")
{
Write-Host "$VM.Base.Name is in Agent Invalid IP Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_ERR_NEED_REBOOT")
{
Write-Host "$VM.Base.Name is in Agent Need Reboot Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_ERR_PROTOCOL_FAILURE")
{
Write-Host "$VM.Base.Name is in Agent Protocol Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_ERR_DOMAIN_FAILURE")
{
Write-Host "$VM.Base.Name is in Agent Domain Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "AGENT_CONFIG_ERROR")
{
Write-Host "$VM.Base.Name is in Agent Config Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "MAINTENANCE")
{
Write-Host "$VM.Base.Name is in Maintenance Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

ElseIf ($Vm.Base.BasicState -eq "UNKNOWN")
{
Write-Host "$VM.Base.Name is in Unknown Error state, attempting REBOOT"
$Services1.Machine.Machine_Restart($vm.Id)
}

}

