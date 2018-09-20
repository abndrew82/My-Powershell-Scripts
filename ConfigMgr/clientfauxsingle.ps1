$ClientName = "FSUTest_1"
$newCert = New-SelfSignedCertificate `
    -KeyLength 2048 `
    -HashAlgorithm "SHA256" `
    -Provider  "Microsoft Enhanced RSA and AES Cryptographic Provider" `
    -KeyExportPolicy Exportable -KeySpec KeyExchange `
    -Subject 'SCCM Test Certificate' -KeyUsageProperty All -Verbose
 
    start-sleep -Milliseconds 650
 
    $pwd = ConvertTo-SecureString -String 'Pa$$w0rd!' -Force -AsPlainText
 
Export-PfxCertificate -cert cert:\localMachine\my\$($newCert.Thumbprint) -FilePath C:\temp\ClientFaux\CMCert_$ClientName.pfx -Password $pwd -Verbose
Remove-Item -Path cert:\localMachine\my\$($newCert.Thumbprint) -Verbose
 
.\ClientFaux.exe $ClientName C:\temp\ClientFaux\CMCert_$ClientName.pfx 'Pa$$w0rd!' FST SCCMTest