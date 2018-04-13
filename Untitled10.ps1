	$Seluser = 'uncfsu.edu\$asenn'
	$User = '$asenn'
	$File = "C:\ProgramData\secure.txt"
	$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential `
							   -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
$session = Invoke-Command -Computername viewbt-int01 -Credential $MyCredential -ScriptBlock {param($Seluser)
		Add-PSSnapin Vmware.view.broker
		Get-RemoteSession -Username $Seluser | Select -ExpandProperty session_id
	} -ArgumentList $Seluser
$session

