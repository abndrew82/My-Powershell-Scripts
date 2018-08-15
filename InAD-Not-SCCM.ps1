$ReturnData = @()
$Computers = Get-ADComputer -Filter * -SearchBase "OU=LABS,OU=FSU,DC=uncfsu,DC=edu" | Select -ExpandProperty Name

ForEach ($Computer in $Computers)
{
$InSCCM = Get-CMDevice -Name $Computer | Select -ExpandProperty Name
If ($InSCCM -eq $null)
{
#Write-host $Computer "Not there"
$ADLogon = Get-ADComputer -Identity $Computer -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$ADOU = Get-ADComputer -Identity $Computer | Select -ExpandProperty DistinguishedName
$Pingable = Test-Connection -ComputerName $Computer -Count 1 -Quiet -ErrorAction SilentlyContinue
$ReturnData += New-Object PSObject -Property @{Comp=$Computer; Pingable=$Pingable; LastADLogon=$ADLogon; ADOU=$ADOU}
}
Else 
{
#$CMDevice = Get-CMDevice -Name $Computer | Select -ExpandProperty ResourceID
#Write-Host $Computer "|" $CMDevice
}
#$ReturnData += New-Object PSObject -Property @{Comp=$Computer; Pingable=$Pingable; LastADLogon=$ADLogon; ADOU=$ADOU}
}
$ReturnData | select Comp, Pingable, LastADLogon, ADOU | Sort-Object Comp | Out-GridView