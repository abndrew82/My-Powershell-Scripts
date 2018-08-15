Dism /Export-Image /SourceImageFile:"F:\Share\WIM-Modifications\June18-Master\sources\install.wim" /SourceIndex:7 /DestinationImageFile:"F:\Share\WIM-Modifications\install.wim"
Dism /Get-Imageinfo /ImageFile:F:\Share\WIM-Modifications\June18-Master\sources\install.wim
Copy-Item F:\Share\WIM-Modifications\install.wim F:\Share\WIM-Modifications\June18-Master\sources
Dism /Mount-Image /ImageFile:F:\Share\WIM-Modifications\install.wim /Index:1 /MountDir:"F:\Share\WIM-Modifications\Offline" /Optimize

#Dism /Add-Package /Image:"E:\Source\OS\Windows10\EN 1803\offline" /PackagePath="E:\Source\Updates\Windows 10 1803\af8d9d4c-a4e9-4435-b08e-9f93d8d2b2b0\Windows10.0-KB4100403-x64.cab" /PackagePath="E:\Source\Updates\Windows 10 1803\df72c532-6259-4c38-9dba-0d952760b50c\Windows10.0-KB4103729-X64.cab"

Mount-WindowsImage -ImagePath F:\Share\WIM-Modifications\install.wim -Index 1 -Path F:\Share\WIM-Modifications\Offline
$Updates = Get-ChildItem -Path F:\Share\WIM-Modifications -Name *.msu
ForEach ($Update in $Updates)
{
Add-WindowsPackage -PackagePath F:\Share\WIM-Modifications\$Update -Path F:\Share\WIM-Modifications\Offline
}
Add-WindowsPackage -PackagePath F:\Share\WIM-Modifications\June18-Master\sources\sxs\microsoft-windows-netfx3-ondemand-package~31bf3856ad364e35~amd64~~.cab -Path F:\Share\WIM-Modifications\Offline
Add-WindowsPackage -PackagePath F:\Share\WIM-Modifications\June18-Master\sources\sxs\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab -Path F:\Share\WIM-Modifications\Offline

Get-WindowsPackage -Path F:\Share\WIM-Modifications\Offline | Format-Table
DisMount-WindowsImage -Path F:\Share\WIM-Modifications\Offline -Save


Dism /Mount-Image /ImageFile:F:\Share\WIM-Modifications\install.wim /Index:1 /MountDir:"F:\Share\WIM-Modifications\Offline" /Optimize

Dism /image:"F:\Share\WIM-Modifications\Offline" /Cleanup-Image /StartComponentCleanup /ResetBase

Dism /Unmount-Image /MountDir:"F:\Share\WIM-Modifications\Offline" /Commit

Remove-Item -Path F:\Share\WIM-Modifications\June18-InPlace\sources\install.wim

Export-WindowsImage -SourceImagePath F:\Share\WIM-Modifications\install.wim -SourceIndex 1 -DestinationImagePath F:\Share\WIM-Modifications\June18-InPlace\sources\install.wim


Get-Help Get-WindowsPackage -Examples
