Param(
[Parameter(Mandatory=$true)]
[String]
$NewName
,
[Parameter(Mandatory=$true)]
[String]
$UserName
,
[Parameter(Mandatory=$true)]
[String]
$Password
)
$PWord = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Moveto = "\\fsu27524s\d$\CAM$CameraNumber"
Write-Host $Moveto
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $UserName, $PWord
#Rename-Computer -NewName $NewName -DomainCredential $Credential -PassThru -Restart -Force