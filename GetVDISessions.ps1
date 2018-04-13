$User = 'uncfsu\$asenn'
$PWord = ConvertTo-SecureString -String "IL0v3MyWife1017" -AsPlainText -Force
$Creds = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord
Invoke-Command -Computername Viewbt-int01 -Credential $creds -ScriptBlock { 
Add-PSSnapin Vmware.view.broker
$Sessions = Get-RemoteSession | Select -ExpandProperty session_id
ForEach ($Session in $Sessions)
{
$User = Get-RemoteSession -Session_id $Session | Select -ExpandProperty Username
$poolid = Get-RemoteSession -Session_id $Session | Select -ExpandProperty pool_id
$DNSName = Get-RemoteSession -Session_id $Session| Select -ExpandProperty DNSName
$ConServer = "View-ST"
Write-Host $User "|" $poolid "|" $DNSName "|" $ConServer
}
}
Invoke-Command -Computername Viewst-int01 -Credential $creds -ScriptBlock { 
Add-PSSnapin Vmware.view.broker
$Sessions = Get-RemoteSession | Select -ExpandProperty session_id
ForEach ($Session in $Sessions)
{
$User = Get-RemoteSession -Session_id $Session | Select -ExpandProperty Username
$poolid = Get-RemoteSession -Session_id $Session | Select -ExpandProperty pool_id
$DNSName = Get-RemoteSession -Session_id $Session| Select -ExpandProperty DNSName
$ConServer = "View-BT"
Write-Host $User "|" $poolid "|" $DNSName "|" $ConServer
}
}