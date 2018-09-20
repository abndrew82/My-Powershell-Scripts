<#
Written by Ryan Ephgrave for ConfigMgr 2012 PS Right Click Tools
#>

#region Import Scriptblocks & Declare Variables & Get Arguments
$GetDirectory = $MyInvocation.MyCommand.path
$Directory = Split-Path $GetDirectory
$Popup = New-Object -ComObject wscript.shell
Import-Module "$Directory\Functions-Universal.ps1"
Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
$CompName = $args[0]
$ResourceID = $args[1]
$Server = $args[2]
$Namespace = $args[3]
#endregion
$CompName = Get-ResourceName -CompName $CompName -ResourceID $ResourceID -Server $Server -Namespace $Namespace
Run-Analytics -ToolName "Device - Change Cache Size"

#Region Functions
Function CacheStartButtonClick {
	$CacheSyncTable.Window.TopMost = $false
	$Script:NewCacheSize = $CacheSyncTable.Txt_CacheSize.Text
	if ($NewCacheSize -ne "" -and [System.Int32]::TryParse($NewCacheSize, [ref]$refnum)) {
		$Answer = $Popup.Popup("Do you want to change the cache size to $NewCacheSize MB?",0,"Are you sure?",1)
		if ($Answer -eq 1) {
			$Script:CompleteScript = $true
			$CacheSyncTable.Window.Close()
		}
	}
	else {$Popup.Popup("Error - Please enter a number",0,"Error",16)}
}

Function On_Close {
	$ProcessID = [System.Diagnostics.Process]::GetCurrentProcess()
	$ProcID = $ProcessID.ID
	& taskkill /PID $ProcID /T /F
}

Function Window_Activated {
	$CacheSyncTable.Window.ShowInTaskbar = $true
	$CacheSyncTable.Window.TopMost = $false
}

$Change_Cache_Size = {
	$CompName = $args[0]
	$NewCacheSize = $args[1]
		$Error.Clear()
		$CacheUsed = 0
		$strQuery = "select ContentSize from CacheInfoEx"
		Get-WmiObject -ComputerName $CompName -Query $strQuery -Namespace root\ccm\SoftMgmtAgent | ForEach-Object {
			if ($_.ContentSize -ne $null) {
				$TempNum = 0
				$TempNum = $_.ContentSize
				$TempNum = $TempNum / 1024
				$CacheUsed = $CacheUsed + $TempNum
			}
		}
		$cachesize = Get-WmiObject -ComputerName $CompName -Class CacheConfig -Namespace root\ccm\softmgmtagent
		foreach ($instance in $cachesize) {$OldCache = $instance.Size}
		$Error.Clear()
		$Script = "`$CCM = New-Object -com UIResource.UIResourceMGR;`$ccmCache = `$ccm.GetCacheInfo();`$ccmCache.TotalSize = $NewCacheSize"
        $ScriptBytes = [System.Text.Encoding]::Unicode.GetBytes($Script)
        $EncodedCommand = [Convert]::ToBase64String($ScriptBytes)
        ([WMIClass]"\\$CompName\root\cimv2:Win32_Process").Create("powershell.exe -encodedcommand $EncodedCommand") | Out-Null
        #$cachesize.Size = "$NewCacheSize"
		#$cachesize.Put() | Out-Null
		if($Error[0]){$strOutput = $CompName + "|Error|" + $Error}
		else{$strOutput = $CompName + "|Successful|" + $NewCacheSize + "|" + $OldCache + "|" + $CacheUsed}
	else {$strOutput = "$Compname|Off"}
	Write-Output $strOutput
}


#endregion



#Region Change the Cache Size
$ConnectionResults = Test-RCTConnection -ComputerName $CompName
If ($ConnectionResults -eq "Success") {
	$cachesize = Get-WmiObject -ComputerName $CompName -Class CacheConfig -Namespace root\ccm\softmgmtagent
	foreach ($instance in $cachesize) {$CurrentCacheSize = $instance.Size}

	$refnum=0
	$CompleteScript = $false
	$CacheSyncTable = [HashTable]::Synchronized(@{})
	[XML]$Cachexaml = @'
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  	     Title="FSU Install Info" Height="142" Width="392" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" Topmost="True" ShowInTaskbar="False">
  	 <Grid>
  	     <Label x:Name="Lbl_Top" Content="" VerticalAlignment="Top" HorizontalContentAlignment="Center" Margin="10,10,10,10"/>
  	     <Label Content="Please enter the new cache size in MB:" VerticalAlignment="Top" Margin="10,40,153,0"/>
  	     <TextBox x:Name="Txt_CacheSize" HorizontalAlignment="Right" Height="23" VerticalAlignment="Top" Width="120" Margin="10,43,10,10"/>
  	     <Button x:Name="Btn_Start" Content="Start" HorizontalAlignment="Center" VerticalAlignment="Bottom" Width="75" Margin="10,70,10,10"/>
  	 </Grid>
</Window>
'@

    $CacheXMLReader = (New-Object System.Xml.XmlNodeReader $Cachexaml)
    $CacheSyncTable.Window = [Windows.Markup.XamlReader]::Load($CacheXMLReader)
    $CacheSyncTable.Window.Add_Activated({Window_Activated})
    $CacheSyncTable.Window.Icon = "$Directory\NowMicroPointer.ico"
    $CacheSyncTable.Window.Title = "$CompName - Change Cache Size"
    $CacheSyncTable.Lbl_Top = $CacheSyncTable.Window.FindName("Lbl_Top")
    $CacheSyncTable.Lbl_Top.Content = "Current Cache Size: $CurrentCacheSize"
    $CacheSyncTable.Txt_CacheSize = $CacheSyncTable.Window.FindName("Txt_CacheSize")
    $CacheSyncTable.Btn_Start = $CacheSyncTable.Window.FindName("Btn_Start")
    $CacheSyncTable.Btn_Start.Add_Click({CacheStartButtonClick})
    $CacheSyncTable.Window.ShowDialog() | Out-Null

    if ($CompleteScript -eq $false) {On_Close}
    $ChangeCacheArgList = @()
    $ChangeCacheArgList += @("$CompName")
    $ChangeCacheArgList += @("$NewCacheSize")
    $strOutput = Invoke-Command -ArgumentList $ChangeCacheArgList -ScriptBlock $Change_Cache_Size

    #Region Process output
    $arrOutput = $strOutput.split("|")
    if ($arrOutput[1] -eq "Off") {$Popup.Popup("$CompName is not online",0,"Error",16)}
    elseif ($arrOutput[1] -eq "Successful") {$Popup.Popup("Successfully changed the cache of $CompName",0,"Successful",0)}
    else {
	    $errMsg = $arrOutput[2]
	    $Popup.Popup("Error running $strActionName on $CompName`n$errMsg",0,"Error",16)
    }
    #endregion
}
else {
    $Popup.Popup($ConnectionResults,0,"Error",16)
}
#endregion