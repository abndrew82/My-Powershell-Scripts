$ConfigInstallPath = $env:SMS_ADMIN_UI_PATH | Out-String
$ConfigInstallPath = $ConfigInstallPath.Trim()
$XMLPath = $ConfigInstallPath -replace "\\bin\\i386", "\XmlStorage\ConsoleRoot"
$ActionsPath = $ConfigInstallPath -replace "\\bin\\i386", "\XmlStorage\Extensions\Actions"
Get-ChildItem "$XMLPath" -Filter "*.xml" -Recurse | ForEach-Object {
	$FullFileName = $_.FullName
	$FileContent = Get-Content $FullFileName
	foreach ($line in $FileContent) {
		if ($line.ToUpper().Contains("NAMESPACEGUID=")) {
			$SplitLine = $line.Split("`"")
			$GUID = $SplitLine[1]
 
			$FilePath = "$ActionsPath\$GUID"
			New-Item -ItemType Directory -Path $FilePath -ErrorAction SilentlyContinue | Out-Null
			$strOutput = "<ActionDescription Class=`"Executable`" DisplayName=`"$GUID`" MnemonicDisplayName=`"$GUID`" Description=`"$GUID`">`n"
			$strOutput = $strOutput + "<ShowOn><string>ContextMenu</string></ShowOn>`n"
			$strOutput = $strOutput + "<Executable><FilePath>cmd.exe</FilePath>`n"
			$strOutput = $strOutput + "<Parameters> /c Powershell.exe Add-Type -AssemblyName 'System.Windows.Forms';[Windows.Forms.Clipboard]::SetText('$GUID')</Parameters></Executable>`n"
			$strOutput = $strOutput + "</ActionDescription>"
			$strOutput > "$FilePath\File.xml"
		}
	}
}