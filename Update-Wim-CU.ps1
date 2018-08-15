$ISO = "F:\Share\SW_DVD5_Win_Pro_Ent_Edu_N_10_1803_64BIT_English_-2_MLF_X21-79647.ISO"
$CU = "F:\1803\windows10.0-kb4103721-x64_fcc746cd817e212ad32a5606b3db5a3333e030f8.msu"
$MountFolder = "F:\1803\mount"
$RefImage = "F:\1803\1803EDU.Wim"
 
# Verify that the ISO and CU files existnote
#if (!(Test-Path -path $ISO)) {Write-Warning "Could not find Windows Server 2016 ISO file. Aborting...";Break}
#if (!(Test-Path -path $CU)) {Write-Warning "Could not find Cumulative Update for Windows Server 2016. Aborting...";Break}
 
# Mount the Windows Server 2016 ISO
Mount-DiskImage -ImagePath $ISO
$ISOImage = Get-DiskImage -ImagePath $ISO | Get-Volume
$ISODrive = [string]$ISOImage.DriveLetter+":"
 
# Extract the Windows Server 2016 Standard index to a new WIM
#Export-WindowsImage -SourceImagePath "$ISODrive\Sources\install.wim" -SourceName "Windows Server 2016 SERVERSTANDARD" -DestinationImagePath $RefImage
 
# Add the KB3201845 CU to the Windows Server 2016 Standardimage
if (!(Test-Path -path $MountFolder)) {New-Item -path $MountFolder -ItemType Directory}
Mount-WindowsImage -ImagePath $RefImage -Index 1 -Path $MountFolder
Add-WindowsPackage -PackagePath $CU -Path $MountFolder
 
# Add .NET Framework 3.5.1 to the Windows Server 2016 Standard image
Add-WindowsPackage -PackagePath "D:\sources\sxs\microsoft-windows-netfx3-ondemand-package~31bf3856ad364e35~amd64~~.cab" -Path $MountFolder
 
# Dismount the Windows Server 2016 Standard image
DisMount-WindowsImage -Path $MountFolder -Save
 
# Dismount the Windows Server 2016 ISO
Dismount-DiskImage -ImagePath $ISO