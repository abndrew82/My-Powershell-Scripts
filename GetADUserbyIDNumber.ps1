##Import Unity IDs into a varriable
$ids = Get-Content C:\Users\apsenn\Downloads\unityids.txt
##For each unity id number get the Users unityid, get the number, username, firstname, and lastname
ForEach ($id in $ids)
{
Get-ADUser -Filter {ncsuCampusID -eq $id} -Properties * | Select ncsuCampusID, name, GivenName, SurName | Export-Csv C:\Users\apsenn\Downloads\idtounity.csv -Append
}