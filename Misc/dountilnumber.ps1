$ErrorActionPreference = "SilentlyContinue"
$i = 1
Do
{
$ConnectOptions = Get-ChildItem C:\Users\asenn\Documents -Name Connect-VDI*.txt
ForEach ($Option in $ConnectOptions)
{
Start-Process -FilePath 'C:\Program Files (x86)\VMware\VMware Horizon View Client\vmware-view.exe' -ArgumentList "--file c:\Users\asenn\Documents\$Option"
sleep 10
$i++
}
}
Until ($i -eq "10")


