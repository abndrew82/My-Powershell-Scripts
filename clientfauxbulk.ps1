$str = 1
$end = 2
while ($str -le $end){
    if(-not(test-path C:\temp)){
        new-item -Path C:\temp -ItemType Directory -Force
    }
    $NewName = "FSUTest_$str"
    $newCert = New-SelfSignedCertificate `
        -KeyLength 2048 `
        -HashAlgorithm "SHA256" `
        -Provider  "Microsoft Enhanced RSA and AES Cryptographic Provider" `
        -KeyExportPolicy Exportable -KeySpec KeyExchange `
        -Subject 'SCCM Test Certificate' -KeyUsageProperty All -Verbose
     
        timeout 3
 
    $pwd = ConvertTo-SecureString -String 'Pa$$w0rd!' -Force -AsPlainText
 
    Export-PfxCertificate -cert cert:\localMachine\my\$($newCert.Thumbprint) -FilePath "c:\temp\Client_$NewName.pfx" -Password $pwd -Verbose
    Remove-Item -Path cert:\localMachine\my\$($newCert.Thumbprint) -Verbose
    C:\temp\ClientFaux\ClientFaux.exe $NewName c:\temp\Client_$NewName.pfx 'Pa$$w0rd!' 'FST' 'SCCMTest'
    $str+=1
}

$NewName = "FSUTest_2"
C:\temp\ClientFaux\ClientFaux.exe $NewName c:\temp\Client_$NewName.pfx 'Pa$$w0rd!' 'FST' 'SCCMTest'

