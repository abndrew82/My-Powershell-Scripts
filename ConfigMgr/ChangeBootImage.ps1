$TSNames = Get-CMTaskSequence | Select -ExpandProperty Name
ForEach ($TSName in $TSNames)
{
If ($TSName -like "*Win*")
{
Set-CMTaskSequence -Name $TSName -UseBootImage $true -BootImageId "FS1002A4"
}
}