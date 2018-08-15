param (
[parameter(Mandatory=$True)]
    [string]$NewName = '',
    [string]$Oldname = ''
)
$Compstuff = "Computer will be renamed from " + $Oldname + " to " + $NewName
$User = "uncfsu\sccmadmin"
$PWord = ConvertTo-SecureString -String "C0nf1gm3!" -AsPlainText -Force
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord	
Out-File $env:TEMP\Renametest.txt -inputobject $Compstuff
Try {
Rename-Computer -ComputerName $Oldname -NewName $NewName -DomainCredential $Credential -PassThru -Restart -Force
}
Catch
{
Write-Host "Failed for some reason"
}