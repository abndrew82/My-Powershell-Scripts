$User = '$asenn'
$File = "C:\ProgramData\secure.txt"
$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential `
							   -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
$session = Invoke-Command -Computername viewbt-int01 -Credential $MyCredential -ScriptBlock {param($Seluser)
		Add-PSSnapin Vmware.view.broker
		Get-RemoteSession -Username 'uncfsu.edu\$asenn'  | Select -ExpandProperty username
	} -ArgumentList $Seluser
$session
$user = [string]$session
$Char = $user.IndexOf("\")
$Trimmed = $user.Substring($Char+1)
Write-Host $Trimmed
$Args = "/Server:AdminB-02 $Trimmed Wassssuuupp"
$User2 = '$asenn'
$File2 = "C:\ProgramData\secure.txt"
$MyCredential2 = New-Object -TypeName System.Management.Automation.PSCredential `
							   -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
Start-Process -FilePath msg.exe -Credential $MyCredential2 -ArgumentList $Args -WorkingDirectory 'C:\Windows\System32'