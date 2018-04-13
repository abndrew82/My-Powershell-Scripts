$SecretKey = "adcf9e05-e15c-4b58-b977-2dd246dbfbbd"
$CompName = "FSU27524S"
$ComputerDescription = "Andrews Desktop"
# Construct web service proxy
try {
    $URI = "http://bios01.uncfsu.edu/ConfigMgrWebService/ConfigMgr.asmx"
    $WebService = New-WebServiceProxy -Uri $URI -ErrorAction Stop
}
catch [System.Exception] {
    Write-Warning -Message "An error occured while attempting to calling web service. Error message: $($_.Exception.Message)" ; exit 2
}

# Add computer to group
#$Invocation = $WebService.SetADComputerDescription($SecretKey, $CompName, $ComputerDescription)
$Invocation = $WebService.GetADComputer($SecretKey, $CompName)
$Invocation | Select -ExpandProperty DistinguishedName
#switch ($Invocation) {
#    $true {
#       Write-Host "YAY"
#    }
#    $false {
#        Write-Host "NOOOO"
#    }
#}