param (
[parameter(Mandatory=$True)]
    [string]$CompName = ''
)
Test-Connection -ComputerName $CompName