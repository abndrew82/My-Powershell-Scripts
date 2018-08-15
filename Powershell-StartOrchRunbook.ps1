Import-Module 'C:\Users\$asenn\Documents\SCOrchestratorServicePowerShellV1_2\OrchestratorServiceModule.psm1'
$ServiceURL = "http://scorch01a:81/Orchestrator2012/Orchestrator.svc/"
$GUID = "507dd5ee-64d6-4cb6-a31c-bf098477665e"
$ParamGUID = "a819f2f7-b0ad-4a70-bd90-ec739cdb5335"
$parameters = @{$ParamGUID = “FSU82052S”} 
$Runbook = Get-OrchestratorRunbook -ServiceUrl $ServiceURL -RunbookId $GUID
Start-OrchestratorRunbook -Runbook $Runbook -Parameters $parameters

