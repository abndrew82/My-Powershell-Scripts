	$Computers = Get-Content C:\Users\asenn\Documents\testcomplist.txt
	foreach ($Comp in $Computers)
	{
		$ADIP = Get-ADComputer -Identity $Comp -Properties IPV4Address | select -ExpandProperty IPV4Address
		$ADPW = Get-ADComputer -Identity $Comp -Properties PasswordLastSet | select -ExpandProperty PasswordLastSet
		$ADOU = Get-ADComputer -Identity $Comp -Properties DistinguishedName | select -ExpandProperty DistinguishedName
		$Info = $Comp + "|" + $ADIP + "|" + $ADPW + "|" + $ADOU
		$ReturnData += New-Object PSObject -Property @{Comp=$Comp; adip=$ADIP; ADPW=$ADPW; ADOU=$ADOU}
		
	}
$ReturnData | select Comp, ADIP, ADPW, ADOU | Sort-Object Comp | Out-GridView