$DriverPacks = Get-Content C:\Users\asenn\Documents\driverpackages.txt
ForEach ($DrivePack in $DriverPacks)
{
$Path = Get-CMDriverPackage -Name $DrivePack | Select -ExpandProperty PkgSourcePath
$ID = Get-CMDriverPackage -Name $DrivePack | Select -ExpandProperty PackageID
$Size = Get-CMDriverPackage -Name $DrivePack | Select -ExpandProperty PackageSize
$Size = $Size / 1GB
Write-Host $DrivePack "|" $ID "|" $Path "|" $Size
$Packs =  $DrivePack + "|" + $ID + "|" + $Size + "|" + $Path
#Out-File D:\DriverpacksDelete.txt -InputObject $Packs -Append
}