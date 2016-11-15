Param (
       [parameter(Mandatory=$True,HelpMessage='OU to Search in CN,DC format')]
       [string]$SearchOU = ''
       )
$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "$SearchOU" -Properties Name -Server dc05.uncfsu.edu | Select -ExpandProperty Name
ForEach ($Comp in $Comps)
{
$SCCMCOMPS = Get-CMDevice -Name $Comp | Select -ExpandProperty SMSID
ForEach ($SCCMCOMP in $SCCMCOMPS)
{
If ($SCCMCOMP -ne $null)
{
$CompIP = Get-ADComputer -Identity $Comp -Properties IPV4Address | Select -ExpandProperty IPV4Address
$CompDN = Get-ADComputer -Identity $Comp -Properties DistinguishedName | Select -ExpandProperty DistinguishedName
If ($CompIP -like "*10.128*" -or $CompIP -like "*10.129*" -or $CompIP -like "*10.130*" -or $CompIP -like "*10.131*")
{
Write-Host $Comp "|" $CompIP "|" "Facilities and Receiving" "|" $SCCMCOMP
$fac = $Comp + "|" + $CompIP + "|" + "Facilities and Receiving" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Fac -Append
}
ElseIf ($CompIP -like "*10.132*" -or $CompIP -like "*10.133*" -or $CompIP -like "*10.134*" -or $CompIP -like "*10.135*")
{
Write-Host $Comp "|" $CompIP "|" "Cook Hall" "|" $SCCMCOMP
$Cook = $Comp + "|" + $CompIP + "|" + "Cook Hall" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Cook -Append
}
ElseIf ($CompIP -like "*10.136*" -or $CompIP -like "*10.137*" -or $CompIP -like "*10.138*" -or $CompIP -like "*10.139*")
{
Write-Host $Comp "|" $CompIP "|" "Alumni Building" "|" $SCCMCOMP
$Alum = $Comp + "|" + $CompIP + "|" + "Alumni Building" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Alum -Append
}
ElseIf ($CompIP -like "*10.140*" -or $CompIP -like "*10.141*" -or $CompIP -like "*10.142*" -or $CompIP -like "*10.143 *")
{
Write-Host $Comp "|" $CompIP "|" "Spaudling" "|" $SCCMCOMP
$Spaudling = $Comp + "|" + $CompIP + "|" + "Spaudling" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Spaudling -Append
}
ElseIf ($CompIP -like "*10.144*" -or $CompIP -like "*10.145*" -or $CompIP -like "*10.146*" -or $CompIP -like "*10.147*")
{
Write-Host $Comp "|" $CompIP "|" "Seabrook" "|" $SCCMCOMP
$Seabrook = $Comp + "|" + $CompIP + "|" + "Seabrook" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Seabrook -Append
}
ElseIf ($CompIP -like "*10.148*" -or $CompIP -like "*10.149*" -or $CompIP -like "*10.150*" -or $CompIP -like "*10.151*")
{
Write-Host $Comp "|" $CompIP "|" "Lyons Science" "|" $SCCMCOMP
$LS = $Comp + "|" + $CompIP + "|" + "Lyons Science" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $LS -Append
}
ElseIf ($CompIP -like "*10.152*" -or $CompIP -like "*10.153*" -or $CompIP -like "*10.154*" -or $CompIP -like "*10.155*")
{
Write-Host $Comp "|" $CompIP "|" "Lyons Annex" "|" $SCCMCOMP
$LSA = $Comp + "|" + $CompIP + "|" + "Lyons Annex" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $LSA -Append
}
ElseIf ($CompIP -like "*10.156*" -or $CompIP -like "*10.157*" -or $CompIP -like "*10.158*" -or $CompIP -like "*10.159*")
{
Write-Host $Comp "|" $CompIP "|" "Science and Technology" "|" $SCCMCOMP
$SciTEch = $Comp + "|" + $CompIP + "|" + "Science and Technology" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $SciTEch -Append
}
ElseIf ($CompIP -like "*10.160*" -or $CompIP -like "*10.161*" -or $CompIP -like "*10.162*" -or $CompIP -like "*10.163*")
{
Write-Host $Comp "|" $CompIP "|" "Rosenthal" "|" $SCCMCOMP
$Rosenthal = $Comp + "|" + $CompIP + "|" + "Rosenthal" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Rosenthal -Append
}
ElseIf ($CompIP -like "*10.164*" -or $CompIP -like "*10.165*" -or $CompIP -like "*10.166*" -or $CompIP -like "*10.167*")
{
Write-Host $Comp "|" $CompIP "|" "Helen T Chick" "|" $SCCMCOMP
$HTC = $Comp + "|" + $CompIP + "|" + "Helen T Chick" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $HTC -Append
}
ElseIf ($CompIP -like "*10.168*" -or $CompIP -like "*10.169*" -or $CompIP -like "*10.170*" -or $CompIP -like "*10.171*")
{
Write-Host $Comp "|" $CompIP "|" "Telecommunications" "|" $SCCMCOMP
$Tele = $Comp + "|" + $CompIP + "|" + "Telecommunications" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Tele -Append
}
ElseIf ($CompIP -like "*10.172*" -or $CompIP -like "*10.173*" -or $CompIP -like "*10.174*" -or $CompIP -like "*10.175*")
{
Write-Host $Comp "|" $CompIP "|" "Taylor Social Science" "|" $SCCMCOMP
$TSS = $Comp + "|" + $CompIP + "|" + "Taylor Social Science" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $TSS -Append
}
ElseIf ($CompIP -like "*10.176*" -or $CompIP -like "*10.177*" -or $CompIP -like "*10.178*" -or $CompIP -like "*10.179*")
{
Write-Host $Comp "|" $CompIP "|" "JKSA" "|" $SCCMCOMP
$JKSA = $Comp + "|" + $CompIP + "|" + "JKSA" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $JKSA -Append
}
ElseIf ($CompIP -like "*10.180*" -or $CompIP -like "*10.181*" -or $CompIP -like "*10.182*" -or $CompIP -like "*10.183*")
{
Write-Host $Comp "|" $CompIP "|" "Lauretta Taylor" "|" $SCCMCOMP
$LTB = $Comp + "|" + $CompIP + "|" + "Lauretta Taylor" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $LTB -Append
}
ElseIf ($CompIP -like "*10.184*" -or $CompIP -like "*10.185*" -or $CompIP -like "*10.186*" -or $CompIP -like "*10.187*")
{
Write-Host $Comp "|" $CompIP "|" "Mitchell" "|" $SCCMCOMP
$Mitchell = $Comp + "|" + $CompIP + "|" + "Mitchell" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Mitchell -Append
}
ElseIf ($CompIP -like "*10.188*" -or $CompIP -like "*10.189*" -or $CompIP -like "*10.190*" -or $CompIP -like "*10.191*")
{
Write-Host $Comp "|" $CompIP "|" "Williams Hall" "|" $SCCMCOMP
$Williams = $Comp + "|" + $CompIP + "|" + "Williams Hall" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Williams -Append
}
ElseIf ($CompIP -like "*10.192*" -or $CompIP -like "*10.193*" -or $CompIP -like "*10.194*" -or $CompIP -like "*10.195*")
{
Write-Host $Comp "|" $CompIP "|" "Lily Gym" "|" $SCCMCOMP
$Lily = $Comp + "|" + $CompIP + "|" + "Lily Gym" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Lily -Append
}
ElseIf ($CompIP -like "*10.196*" -or $CompIP -like "*10.197*" -or $CompIP -like "*10.198*" -or $CompIP -like "*10.199*")
{
Write-Host $Comp "|" $CompIP "|" "Capel Arena" "|" $SCCMCOMP
$Capel = $Comp + "|" + $CompIP + "|" + "Capel Arena" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Capel -Append
}
ElseIf ($CompIP -like "*10.200*" -or $CompIP -like "*10.201*" -or $CompIP -like "*10.202*" -or $CompIP -like "*10.203*")
{
Write-Host $Comp "|" $CompIP "|" "Bronco Square" "|" $SCCMCOMP
$Bronco = $Comp + "|" + $CompIP + "|" + "Bronco Square" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Bronco -Append
}
ElseIf ($CompIP -like "*10.16.*" -or $CompIP -like "*10.17.*" -or $CompIP -like "*10.18.*" -or $CompIP -like "*10.19.*")
{
Write-Host $Comp "|" $CompIP "|" "SBE" "|" $SCCMCOMP
$SBE = $Comp + "|" + $CompIP + "|" + "SBE" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $SBE -Append
}
ElseIf ($CompIP -like "*10.20.*" -or $CompIP -like "*10.21.*" -or $CompIP -like "*10.22.*" -or $CompIP -like "*10.23.*")
{
Write-Host $Comp "|" $CompIP "|" "Butler" "|" $SCCMCOMP
$Butler = $Comp + "|" + $CompIP + "|" + "Butler Building" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Butler -Append
}
ElseIf ($CompIP -like "*10.24.*" -or $CompIP -like "*10.25.*" -or $CompIP -like "*10.26.*" -or $CompIP -like "*10.27.*")
{
Write-Host $Comp "|" $CompIP "|" "Collins" "|" $SCCMCOMP
$Collins = $Comp + "|" + $CompIP + "|" + "Collins" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Collins -Append
}
ElseIf ($CompIP -like "*10.28.*" -or $CompIP -like "*10.29.*" -or $CompIP -like "*10.30.*" -or $CompIP -like "*10.31.*")
{
Write-Host $Comp "|" $CompIP "|" "Barber" "|" $SCCMCOMP
$Barber = $Comp + "|" + $CompIP + "|" + "Barber Building" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Barber -Append
}
ElseIf ($CompIP -like "*10.32.*" -or $CompIP -like "*10.33.*" -or $CompIP -like "*10.34.*" -or $CompIP -like "*10.35.*")
{
Write-Host $Comp "|" $CompIP "|" "RJSC" "|" $SCCMCOMP
$RJSC = $Comp + "|" + $CompIP + "|" + "RJSC" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $RJSC -Append
}
ElseIf ($CompIP -like "*10.36.*" -or $CompIP -like "*10.37.*" -or $CompIP -like "*10.38.*" -or $CompIP -like "*10.39.*")
{
Write-Host $Comp "|" $CompIP "|" "Ft. Bragg" "|" $SCCMCOMP
$Bragg = $Comp + "|" + $CompIP + "|" + "Ft. Bragg" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Bragg -Append
}
ElseIf ($CompIP -like "*10.40.*" -or $CompIP -like "*10.41.*" -or $CompIP -like "*10.42.*" -or $CompIP -like "*10.43.*")
{
Write-Host $Comp "|" $CompIP "|" "Continuing Education" "|" $SCCMCOMP
$ContEd = $Comp + "|" + $CompIP + "|" + "Continuing Education" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $ContEd -Append
}
ElseIf ($CompIP -like "*10.44.*" -or $CompIP -like "*10.45.*" -or $CompIP -like "*10.46.*" -or $CompIP -like "*10.47.*")
{
Write-Host $Comp "|" $CompIP "|" "Nursing" "|" $SCCMCOMP
$Nursing = $Comp + "|" + $CompIP + "|" + "Nursing" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Nursing -Append
}
ElseIf ($CompIP -like "*10.48.*" -or $CompIP -like "*10.49.*" -or $CompIP -like "*10.50.*" -or $CompIP -like "*10.51.*")
{
Write-Host $Comp "|" $CompIP "|" "Chestnutt Library" "|" $SCCMCOMP
$Library = $Comp + "|" + $CompIP + "|" + "Chestnutt Library" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Library -Append
}
ElseIf ($CompIP -like "*10.1.114*" -or $CompIP -like "*10.1.115*")
{
Write-Host $Comp "|" $CompIP "|" "Lab Butler Distribution" "|" $SCCMCOMP
$LBD = $Comp + "|" + $CompIP + "|" + "Lab Butler Distribution" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $LBD -Append
}
ElseIf ($CompIP -like "*152.6.*" -or $CompIP -like "*192.168.*")
{
Write-Host $Comp "|" $CompIP "|" "FSU Secure, Server VLAN, or VM" "|" $SCCMCOMP
$FSUSec = $Comp + "|" + $CompIP + "|" + "FSU Secure, Server VLAN, or VM" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $FSUSec -Append
}
ElseIf ($CompIP -notlike "*10.16.*" -Or
$CompIP -notlike "*10.20.*" -Or
$CompIP -notlike "*10.24.*" -Or
$CompIP -notlike "*10.28.*" -Or
$CompIP -notlike "*10.32.*" -Or
$CompIP -notlike "*10.40.*" -Or
$CompIP -notlike "*10.44.*" -Or
$CompIP -notlike "*10.48.*" -Or
$CompIP -notlike "*10.128.*" -Or
$CompIP -notlike "*10.132.*" -Or
$CompIP -notlike "*10.136.*" -Or
$CompIP -notlike "*10.140.*" -Or
$CompIP -notlike "*10.144.*" -Or
$CompIP -notlike "*10.148.*" -Or
$CompIP -notlike "*10.152.*" -Or
$CompIP -notlike "*10.156.*" -Or
$CompIP -notlike "*10.160.*" -Or
$CompIP -notlike "*10.164.*" -Or
$CompIP -notlike "*10.168.*" -Or
$CompIP -notlike "*10.172.*" -Or
$CompIP -notlike "*10.176.*" -Or
$CompIP -notlike "*10.180.*" -Or
$CompIP -notlike "*10.184.*" -Or
$CompIP -notlike "*10.188.*" -Or
$CompIP -notlike "*10.192.*" -Or
$CompIP -notlike "*10.196.*" -Or
$CompIP -notlike "*10.200.*")
{
Write-Host $Comp "|" $CompIP "|" "Unknown VLAN" "|" $SCCMCOMP
$Unknown = $Comp + "|" + $CompIP + "|" + "Unknown VLAN" + "|" + $SCCMCOMP
Out-File D:\Testfile1.txt -InputObject $Unknown -Append
Clear-Variable $SearchOU
}
}
}
}