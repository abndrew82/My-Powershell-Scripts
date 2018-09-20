	$row = $datagridview1.SelectedRows
	$SessionID = $row.cells[7].Value
    $Server = $row.cells[4].Value
	$User = '$asenn'
	$File = "C:\ProgramData\secure.txt"

	$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential `
							   -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
     $Session = Invoke-Command -Computername viewst-int01 -Credential $MyCredential -ScriptBlock { `
		param ($SessionID)
		Add-PSSnapin Vmware.view.broker
		Write-Host $SessionID
		Send-SessionDisconnect -Session_id $SessionID
	} -ArgumentList $SessionID
	$Session