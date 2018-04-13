$User = '$asenn'
$File = "C:\ProgramData\secure.txt"
$MyCredential=New-Object -TypeName System.Management.Automation.PSCredential `
 -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
#$User = 'uncfsu\$asenn'
#$PWord = ConvertTo-SecureString -String "IL0v3MyWife1017" -AsPlainText -Force
#$Creds = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord
$Data = Invoke-Command -Computername ViewBT-Int01 -Credential $MyCredential -ScriptBlock {
Add-PSSnapin Vmware.view.broker
Get-RemoteSession | Select Username, pool_id, DNSName, duration
}
$Data2 = Invoke-Command -Computername ViewST-Int01 -Credential $MyCredential -ScriptBlock {
Add-PSSnapin Vmware.view.broker
Get-RemoteSession | Select Username, pool_id, DNSName, duration
}
$Output = $Data + $Data2 | Sort-Object DNSName
$Output | Out-GridView