Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Push-Location -Path FS1:
$a = Get-ADComputer -LDAPFilter "(name=*)" -SearchBase "CN=Computers,DC=uncfsu,DC=edu" -Properties * | Select -ExpandProperty Name
$a.Count