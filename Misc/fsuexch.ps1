$LiveCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://FSUEXCH2K13-1J.uncfsu.edu/powershell/ -Credential $LiveCred -Authentication Kerberos -AllowRedirection
Import-PSSession -AllowClobber $Session