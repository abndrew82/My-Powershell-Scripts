##Export the Education Image##
Dism /Export-Image /SourceImageFile:"E:\Source\OS\Windows10\EN 1803\March18-Master\sources\install.wim" /SourceIndex:3 /DestinationImageFile:"E:\Source\OS\Windows10\EN 1803\install.wim"
##Get Indexes / Versions##
Dism /Get-ImageInfo /ImageFile:"E:\Source\OS\Windows10\EN 1803\install.wim"
##Mount the Image##
Dism /Mount-Image /ImageFile:"E:\Source\OS\Windows10\EN 1803\install.wim" /Index:1 /MountDir:"E:\Source\OS\Windows10\EN 1803\offline" /Optimize
##Inject the Updates##
Dism /Add-Package /Image:"E:\Source\OS\Windows10\EN 1803\offline" /PackagePath="E:\Source\Updates\Windows 10 1803\937c715f-a49e-4480-8b0c-e8f417e15164\Windows10.0-KB4100347-x64.cab"
##Get List of Packages##
Dism /Image:"E:\Source\OS\Windows10\EN 1803\Offline" /Get-Packages /Format:Table
##Clean Up Image##
Dism /Image:"E:\Source\OS\Windows10\EN 1803\offline" /Cleanup-Image /StartComponentCleanup /ResetBase
##Unmount the Image##
Dism /Unmount-Image /MountDir:"E:\Source\OS\Windows10\EN 1803\offline" /Commit
##Export the Image##
Dism /Export-Image /SourceImageFile:"E:\Source\OS\Windows10\EN 1803\install.wim" /SourceIndex:1 /DestinationImageFile:"E:\Source\OS\Windows10\EN 1803\May18-BareMetal\install.wim"
##Delete the old image##
del "E:\Source\OS\Windows10\EN 1803\install.wim"