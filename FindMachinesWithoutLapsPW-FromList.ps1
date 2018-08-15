$ReturnData = @()
$NoLaps = Get-Content 'C:\Users\$asenn\Documents\2016NonCompliant.txt'
ForEach ($NoLap in $NoLaps)
{
Try
{
$ADLogon = Get-ADComputer -Identity $NoLap -Properties LastLogonDate | Select -ExpandProperty LastLogonDate -ErrorAction SilentlyContinue
$ADOU = Get-ADComputer -Identity $NoLap | Select -ExpandProperty DistinguishedName -ErrorAction SilentlyContinue
$SCCMClient = Get-CMDevice -Name $NoLap | Select-Object -ExpandProperty Client -ErrorAction SilentlyContinue
If ($SCCMClient -eq "1")
{
$SCCMClient = "Yes"
$SCCMUser = Get-CMDevice -Name $NoLap | Select-Object -ExpandProperty LastLogonUserName -ErrorAction SilentlyContinue
$OS = Get-cmdevice -Name $NoLap  | Select -ExpandProperty OperatingSystemNameandVersion -ErrorAction SilentlyContinue
$Pingable = Test-Connection -ComputerName $NoLap -Count 1 -Quiet -ErrorAction SilentlyContinue
}
Else
{
$SCCMClient = "No"
$SCCMUser = "NA"
$SCCMActivity = "NA"
}
}
Catch
{
$Pingable = "False"
$ADLogon = "AD Record Does not Exist"
$ADOU = "AD Record Does not Exist"
}
$ReturnData += New-Object PSObject -Property @{Comp=$NoLap; Pingable=$Pingable; SCCMClient=$SCCMClient; PrimUser=$SCCMUser; SCCMActive=$SCCMActivity; LastADLogon=$ADLogon; ADOU=$ADOU; OS=$OS}
}
$ReturnData | select Comp, Pingable, SCCMClient, PrimUser, SCCMActive, LastADLogon, ADOU, OS | Sort-Object Comp | Out-GridView