Connect-VIServer view-bt -User 
Get-VM | Select Name, @{N="IP Address";E={@($_.guest.IPAddress -join '|')}} | Select-String -Pattern 169.254
Get-VM | Select Name, @{N="IP Address";E={@($_.guest.IPAddress -join '|')}} | Out-File f:\VMIPs.txt
Get-VM | Select Name, @{N="IP Address";E={@($_.guest.IPAddress -join '|')}} | Select-String -Pattern btfinaid-03
Get-VM | Select Name, @{N="IP Address";E={@($_.guest.IPAddress -join '|')}} | Select-String -Pattern btsbe231

###"BTLSA125-04"####