$ReturnData = @()
$NoLaps = Get-ADComputer -Filter * -SearchBase "OU=FSU_Test_Computers, OU=FSU-Test,DC=uncfsu,DC=edu" -Properties ms-Mcs-AdmPwd | Where-Object {$_."ms-Mcs-AdmPwd" -eq $null} | Select -ExpandProperty Name
ForEach ($NoLap in $NoLaps)
{
$SCCMClient = Get-CMDevice -Name $NoLap | Select-Object -ExpandProperty Client -ErrorAction SilentlyContinue
If ($SCCMClient -eq "1")
{
$SCCMClient = "Yes"
$SCCMUser = Get-CMDevice -Name $NoLap | Select-Object -ExpandProperty LastLogonUserName -ErrorAction SilentlyContinue
$SCCMActivity = Get-CMDevice -Name $NoLap | Select-Object -ExpandProperty Active -ErrorAction SilentlyContinue
If ($SCCMActivity -eq "1")
{
$SCCMActivity = "Yes"
}
Else {$SCCMActivity = "No"}
}
Else
{
$SCCMClient = "No"
$SCCMUser = "NA"
$SCCMActivity = "NA"
}
$Pingable = Test-Connection -ComputerName $NoLap -Count 1 -Quiet -ErrorAction SilentlyContinue
$ADLogon = Get-ADComputer -Identity $NoLap -Properties LastLogonDate | Select -ExpandProperty LastLogonDate -ErrorAction SilentlyContinue
$ADOU = Get-ADComputer -Identity $NoLap | Select -ExpandProperty DistinguishedName -ErrorAction SilentlyContinue
$OS = Get-cmdevice -Name $NoLap  | Select -ExpandProperty OperatingSystemNameandVersion -ErrorAction SilentlyContinue
$ReturnData += New-Object PSObject -Property @{Comp=$NoLap; Pingable=$Pingable; SCCMClient=$SCCMClient; PrimUser=$SCCMUser; SCCMActive=$SCCMActivity; LastADLogon=$ADLogon; ADOU=$ADOU; OS=$OS}
}
$ReturnData | select Comp, Pingable, SCCMClient, PrimUser, SCCMActive, LastADLogon, ADOU, OS | Sort-Object Comp | Out-GridView