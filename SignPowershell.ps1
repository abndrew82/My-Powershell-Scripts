﻿$cert = @(Get-ChildItem cert:\CurrentUser\My -codesigning)[0]
Set-AuthenticodeSignature X:\Share\apsenn\My-Powershell-Scripts\FindNetBootGuidinAD.ps1 $cert -TimestampServer "http://timestamp.verisign.com/scripts/timstamp.dll"