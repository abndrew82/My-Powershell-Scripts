$comps = Get-Content C:\Users\apsenn.admin\Documents\Mann319.txt
ForEach ($Computer in $comps)
{
Set-ADComputer $Computer -Location "Mann 319"
}