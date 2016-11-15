Param (
       [parameter(Mandatory=$True,HelpMessage='OU to Search in and move records from in CN,DC format')]
       [string]$SearchOU = ''
       )
$ErrorActionPreference = "SilentlyContinue"
$Comps = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "$SearchOU" -Properties Name | Select -ExpandProperty Name
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
Move-ADObject -Identity "$CompDN" -TargetPath "OU=Facilities & Receiving,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.132*" -or $CompIP -like "*10.133*" -or $CompIP -like "*10.134*" -or $CompIP -like "*10.135*")
{
Write-Host $Comp "|" $CompIP "|" "Cook Hall" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath "OU=Cook Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.136*" -or $CompIP -like "*10.137*" -or $CompIP -like "*10.138*" -or $CompIP -like "*10.139*")
{
Write-Host $Comp "|" $CompIP "|" "Alumni Building" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Alumni Hall,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.140*" -or $CompIP -like "*10.141*" -or $CompIP -like "*10.142*" -or $CompIP -like "*10.143 *")
{
Write-Host $Comp "|" $CompIP "|" "Spaudling" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Spaulding Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.144*" -or $CompIP -like "*10.145*" -or $CompIP -like "*10.146*" -or $CompIP -like "*10.147*")
{
Write-Host $Comp "|" $CompIP "|" "Seabrook" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Seabrook Auditorium,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.148*" -or $CompIP -like "*10.149*" -or $CompIP -like "*10.150*" -or $CompIP -like "*10.151*")
{
Write-Host $Comp "|" $CompIP "|" "Lyons Science" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Lyons Science Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.152*" -or $CompIP -like "*10.153*" -or $CompIP -like "*10.154*" -or $CompIP -like "*10.155*")
{
Write-Host $Comp "|" $CompIP "|" "Lyons Annex" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Lyons Science Annex,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.156*" -or $CompIP -like "*10.157*" -or $CompIP -like "*10.158*" -or $CompIP -like "*10.159*")
{
Write-Host $Comp "|" $CompIP "|" "Science and Technology" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Sci & Tech Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.160*" -or $CompIP -like "*10.161*" -or $CompIP -like "*10.162*" -or $CompIP -like "*10.163*")
{
Write-Host $Comp "|" $CompIP "|" "Rosenthal" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Rosenthal Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.164*" -or $CompIP -like "*10.165*" -or $CompIP -like "*10.166*" -or $CompIP -like "*10.167*")
{
Write-Host $Comp "|" $CompIP "|" "Helen T Chick" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Helen T. Chick,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.168*" -or $CompIP -like "*10.169*" -or $CompIP -like "*10.170*" -or $CompIP -like "*10.171*")
{
Write-Host $Comp "|" $CompIP "|" "Telecommunications" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Telecom Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.172*" -or $CompIP -like "*10.173*" -or $CompIP -like "*10.174*" -or $CompIP -like "*10.175*")
{
Write-Host $Comp "|" $CompIP "|" "Taylor Social Science" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Taylor Science Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.176*" -or $CompIP -like "*10.177*" -or $CompIP -like "*10.178*" -or $CompIP -like "*10.179*")
{
Write-Host $Comp "|" $CompIP "|" "JKSA" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=JKSA Annex,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.180*" -or $CompIP -like "*10.181*" -or $CompIP -like "*10.182*" -or $CompIP -like "*10.183*")
{
Write-Host $Comp "|" $CompIP "|" "Lauretta Taylor" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=L. Taylor Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.184*" -or $CompIP -like "*10.185*" -or $CompIP -like "*10.186*" -or $CompIP -like "*10.187*")
{
Write-Host $Comp "|" $CompIP "|" "Mitchell" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Mitchell Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.188*" -or $CompIP -like "*10.189*" -or $CompIP -like "*10.190*" -or $CompIP -like "*10.191*")
{
Write-Host $Comp "|" $CompIP "|" "Williams Hall" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Williams Hall,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.192*" -or $CompIP -like "*10.193*" -or $CompIP -like "*10.194*" -or $CompIP -like "*10.195*")
{
Write-Host $Comp "|" $CompIP "|" "Lily Gym" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Lily Gym,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.196*" -or $CompIP -like "*10.197*" -or $CompIP -like "*10.198*" -or $CompIP -like "*10.199*")
{
Write-Host $Comp "|" $CompIP "|" "Capel Arena" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Capel Arena,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.200*" -or $CompIP -like "*10.201*" -or $CompIP -like "*10.202*" -or $CompIP -like "*10.203*")
{
Write-Host $Comp "|" $CompIP "|" "Bronco Square" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Bronco Square,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.16.*" -or $CompIP -like "*10.17.*" -or $CompIP -like "*10.18.*" -or $CompIP -like "*10.19.*")
{
Write-Host $Comp "|" $CompIP "|" "SBE" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=SBE Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.20.*" -or $CompIP -like "*10.21.*" -or $CompIP -like "*10.22.*" -or $CompIP -like "*10.23.*")
{
Write-Host $Comp "|" $CompIP "|" "Butler" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Butler Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.24.*" -or $CompIP -like "*10.25.*" -or $CompIP -like "*10.26.*" -or $CompIP -like "*10.27.*")
{
Write-Host $Comp "|" $CompIP "|" "Collins" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Collins Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.28.*" -or $CompIP -like "*10.29.*" -or $CompIP -like "*10.30.*" -or $CompIP -like "*10.31.*")
{
Write-Host $Comp "|" $CompIP "|" "Barber" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Barber Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.32.*" -or $CompIP -like "*10.33.*" -or $CompIP -like "*10.34.*" -or $CompIP -like "*10.35.*")
{
Write-Host $Comp "|" $CompIP "|" "RJSC" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=RJSC Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.36.*" -or $CompIP -like "*10.37.*" -or $CompIP -like "*10.38.*" -or $CompIP -like "*10.39.*")
{
Write-Host $Comp "|" $CompIP "|" "Ft. Bragg" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Fort Bragg,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.40.*" -or $CompIP -like "*10.41.*" -or $CompIP -like "*10.42.*" -or $CompIP -like "*10.43.*")
{
Write-Host $Comp "|" $CompIP "|" "Continuing Education" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Continuing Education,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.44.*" -or $CompIP -like "*10.45.*" -or $CompIP -like "*10.46.*" -or $CompIP -like "*10.47.*")
{
Write-Host $Comp "|" $CompIP "|" "Nursing" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Nursing Building,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
ElseIf ($CompIP -like "*10.48.*" -or $CompIP -like "*10.49.*" -or $CompIP -like "*10.50.*" -or $CompIP -like "*10.51.*")
{
Write-Host $Comp "|" $CompIP "|" "Chestnutt Library" "|" $SCCMCOMP
Move-ADObject -Identity $Comp -TargetPath " OU=Chestnutt Library,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
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
Move-ADObject -Identity $CompDN -TargetPath "OU=1 - Sort,OU=Workstations,OU=FSU,DC=uncfsu,DC=edu" -Server dc05.uncfsu.edu
}
}
}
}