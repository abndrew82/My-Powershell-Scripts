Invoke-Command -ComputerName viewbt-int01 -ScriptBlock {Connect-HVServer -Server viewbt-int01.uncfsu.edu -Domain uncfsu -User bigben -Password G0St33l3r$
$VMS = Get-HVMachine | Where-Object {$_.Base.BasicState -eq "Available"}
ForEach ($VM in $VMS)
{
$Name = $VM.Base.Name
}
}