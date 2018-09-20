$test = "L-JFDECARO-02"
Write-Host $test
$newtest = $test.Substring(2,$test.Length-5)
Write-Host $newtest
if ((Get-ADUser $newtest -Properties memberof).memberof -like "CN=WT-CCEE-14CE Faculty,OU=Managed Groups,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu")
{
$true
}
Else
{
$false
}