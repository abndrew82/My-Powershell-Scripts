Import-Module -Name vm*
$baseStates = @('PROVISIONING_ERROR',
'ERROR',
'AGENT_UNREACHABLE',
'AGENT_ERR_STARTUP_IN_PROGRESS',
'AGENT_ERR_DISABLED',
'AGENT_ERR_INVALID_IP',
'AGENT_ERR_NEED_REBOOT',
'ALREADY_USED',
'AGENT_ERR_PROTOCOL_FAILURE',
'AGENT_ERR_DOMAIN_FAILURE',
'AGENT_CONFIG_ERROR',
'MAINTENANCE',
'UNKNOWN')
$hvserver1=Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password "G0St33l3r$"
$ErrorVMs = Get-HVMachine | Where-Object {$_.Base.BasicState -in $baseStates}
ForEach ($ErrorVM in $ErrorVMs)
{
$VMName = $ErrorVM.Base.Name
$VMError = $ErrorVM.Base.BasicState
$VMNameError = $VMName +" | "+ $VMError
Write-Output $VMNameError
}