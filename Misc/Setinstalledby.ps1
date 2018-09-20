Param (
       [parameter(Mandatory=$True,HelpMessage='Username')]
       [string]$username = '',
       [parameter(Mandatory=$True,HelpMessage='FSUTag')]
       [string]$fsutag = 'No'
       )
New-ItemProperty -Path "HKLM:\Software\FSUSCCM" -Name "Installed By" -Type String -Value $username
New-ItemProperty -Path "HKLM:\Software\FSUSCCM" -Name "FSU Tag" -Type String -Value $fsutag