$messageuser = $datagridview1.CurrentCell.Value
$importObject = Import-Clixml -Path .\savedCreds.xml
$secureString = ConvertTo-SecureString -String $importObject.Password -Key $key
$savedCreds = New-Object System.Management.Automation.PSCredential($importObject.UserName, $secureString)
	Write-Host $messageuser
	$Session = Invoke-Command -Computername viewbt-int01 -Credential $savedCreds -ScriptBlock {
		param ($messageuser)
		Add-PSSnapin Vmware.view.broker
		Get-RemoteSession -Username $messageuser | select -ExpandProperty DNSName
	} -ArgumentList $messageuser
	$Session
	$Message = "WASSSSUUUPPPP"
	Write-Host $messageuser
$user = [string]$messageuser
$Char = $user.IndexOf("\")
$Trimmed = $user.Substring($Char+1)
	$args = "/Server:$Session $trimmed $Message"
Write-Host $args
$importObject = Import-Clixml -Path .\savedCreds.xml
$secureString = ConvertTo-SecureString -String $importObject.Password -Key $key
$savedCreds = New-Object System.Management.Automation.PSCredential($importObject.UserName, $secureString)
	Start-Process -FilePath msg.exe -ArgumentList $Args -WorkingDirectory 'C:\Windows\System32'