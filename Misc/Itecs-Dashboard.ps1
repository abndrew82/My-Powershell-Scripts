#region Source: Startup.pss
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
[void][Reflection.Assembly]::Load('mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][Reflection.Assembly]::Load('System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][Reflection.Assembly]::Load('System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
	Param ([String]$Commandline)
	#Note: This function starts the application
	#Note: $Commandline contains the complete argument string passed to the packager 
	#Note: To get the script directory in the Packager use: Split-Path $hostinvocation.MyCommand.path
	#Note: To get the console output in the Packager (Forms Mode) use: $ConsoleOutput (Type: System.Collections.ArrayList)
	#TODO: Initialize and add Function calls to forms
	
	if((Call-MainForm_psf) -eq "OK")
	{
		
	}
	
	$global:ExitCode = 0 #Set the exit code for the Packager
}






#endregion Source: Startup.pss

#region Source: MainForm.psf
function Call-MainForm_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$labelResults = New-Object 'System.Windows.Forms.Label'
	$buttonGetUserGroups = New-Object 'System.Windows.Forms.Button'
	$labelComputerTools = New-Object 'System.Windows.Forms.Label'
	$buttonRemoteAssist = New-Object 'System.Windows.Forms.Button'
	$listbox1 = New-Object 'System.Windows.Forms.ListBox'
	$buttonGetSoftware = New-Object 'System.Windows.Forms.Button'
	$labelComputerUserName = New-Object 'System.Windows.Forms.Label'
	$buttonBCR = New-Object 'System.Windows.Forms.Button'
	$buttonITRACS = New-Object 'System.Windows.Forms.Button'
	$buttonHostFinder = New-Object 'System.Windows.Forms.Button'
	$buttonLaunchADUC = New-Object 'System.Windows.Forms.Button'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	$buttonOpenLogs = New-Object 'System.Windows.Forms.Button'
	$buttonADK = New-Object 'System.Windows.Forms.Button'
	$buttonPing = New-Object 'System.Windows.Forms.Button'
	$buttonLaunchPrintServer = New-Object 'System.Windows.Forms.Button'
	$buttonNSLookup = New-Object 'System.Windows.Forms.Button'
	$buttonhosttool = New-Object 'System.Windows.Forms.Button'

	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
	
	}
	
	
	
	
	
	$buttonGetSoftware_Click={
		#TODO: Place custom script here
		import-module ActiveDirectory
		$compname=$textbox1.Text
		$software = Get-ADPrincipalGroupMembership (Get-ADComputer $compname).DistinguishedName | Select Name
		Load-ListBox -ListBox $listbox1 -Items $Software
	}
	
	$buttonOpenLogs_Click={
		#TODO: Place custom script here
		$compname=$textbox1.Text
		$logpath="\\" + $compname + "\ccmlogs$"
		$cachepath="\\" + $compname + "\ccmcache$"
		ii $logpath
		ii $cachepath
	}
	
	#ADK Button Click

	$buttonADK_Click={
		#TODO: Place custom script here
	start-process "chrome.exe" "https://www.wolftech.ncsu.edu/adtoolkit/wrap/computer_software"
	}	
	
	#BCR Button Click

	$buttonBCR_Click={
		#TODO: Place custom script here
	start-process "chrome.exe" "https://bcr.comtech.ncsu.edu/bcreport/view"
	}	
	
	#HostFinder Button Click

	$buttonHostFinder_Click={
		#TODO: Place custom script here
	start-process "chrome.exe" "https://tools.comtech.ncsu.edu/hostfinder/"
	}	
	
	#ITRACS Button Click

	$buttonITRACS_Click={
		#TODO: Place custom script here
	start-process "chrome.exe" "http://pla.comtech.ncsu.edu/public_pla/"
	}	
	
	
	#region Control Helper Functions
	function Load-ListBox 
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ListBox or CheckedListBox.
	
		.DESCRIPTION
			Use this function to dynamically load items into the ListBox control.
	
		.PARAMETER  ListBox
			The ListBox control you want to add items to.
	
		.PARAMETER  Items
			The object or objects you wish to load into the ListBox's Items collection.
	
		.PARAMETER  DisplayMember
			Indicates the property to display for the items in this control.
		
		.PARAMETER  Append
			Adds the item(s) to the ListBox without clearing the Items collection.
		
		.EXAMPLE
			Load-ListBox $ListBox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Load-ListBox $listBox1 "Red" -Append
			Load-ListBox $listBox1 "White" -Append
			Load-ListBox $listBox1 "Blue" -Append
		
		.EXAMPLE
			Load-ListBox $listBox1 (Get-Process) "ProcessName"
	#>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			[System.Windows.Forms.ListBox]$ListBox,
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			$Items,
		    [Parameter(Mandatory=$false)]
			[string]$DisplayMember,
			[switch]$Append
		)
		
		if(-not $Append)
		{
			$listBox.Items.Clear()	
		}
		
		if($Items -is [System.Windows.Forms.ListBox+ObjectCollection])
		{
			$listBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$listBox.BeginUpdate()
			foreach($obj in $Items)
			{
				$listBox.Items.Add($obj)
			}
			$listBox.EndUpdate()
		}
		else
		{
			$listBox.Items.Add($Items)	
		}
	
		$listBox.DisplayMember = $DisplayMember	
	}
	#endregion
	
	$buttonRemoteAssist_Click={
		#TODO: Place custom script here
		$compname = $textbox1.Text
		msra /offerra $compname
	}
	
	$buttonGetUserGroups_Click={
		#TODO: Place custom script here
		$username = $textbox1.Text
		$usergroups = Get-ADPrincipalGroupMembership -Identity $username | select Name
		Load-ListBox -ListBox $listbox1 -Items $usergroups
		
	}
	
		$buttonPing_Click={
		#TODO: Place custom script here
		$hostname = $textbox1.Text
		$pingresults = ping $hostname
		Load-ListBox -ListBox $listbox1 -Items $Pingresults
				
	}
	
		$buttonNSLookup_Click={
		#TODO: Place custom script here
		$nshostname = $textbox1.Text
		$nsresults = nslookup $nshostname
		Load-ListBox -ListBox $listbox1 -Items $nsresults
	}
	
		$buttonLaunchPrintServer_Click={
		#TODO: Place custom script here
		Start-Process \\engr99ps
		Start-Process \\engr-ps-198		
	}
	
		
		$buttonLaunchADUC_Click={
		#TODO: Place custom script here
		$AducPath="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Active Directory Users and Computers.lnk"
		Start-Process -FilePath  $AducPath
	}
	
		$buttonHostTool_Click={
		#TODO: Place custom script here
		if((Call-HostTool_psf) -eq 'OK')
		{
			
		}
	}
	
	
		# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$MainForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_listbox1 = $listbox1.SelectedItems
		$script:MainForm_textbox1 = $textbox1.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonGetUserGroups.remove_Click($buttonGetUserGroups_Click)
			$buttonRemoteAssist.remove_Click($buttonRemoteAssist_Click)
			$buttonGetSoftware.remove_Click($buttonGetSoftware_Click)
			$MainForm.remove_Load($OnLoadFormEvent)
			$MainForm.remove_Load($Form_StateCorrection_Load)
			$MainForm.remove_Closing($Form_StoreValues_Closing)
			$MainForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($labelResults)
	#$MainForm.Controls.Add($buttonGetUserGroups)
	$MainForm.Controls.Add($labelComputerTools)
	$MainForm.Controls.Add($buttonOpenLogs)
	$MainForm.Controls.Add($buttonLaunchADUC)
	$MainForm.Controls.Add($buttonRemoteAssist)
	$MainForm.Controls.Add($listbox1)
	#$MainForm.Controls.Add($buttonGetSoftware)
	$MainForm.Controls.Add($labelComputerUserName)
	$MainForm.Controls.Add($buttonhosttool)
	$MainForm.Controls.Add($buttonBCR)
	$MainForm.Controls.Add($buttonHostFinder)
	$MainFOrm.Controls.Add($buttonITRACS)
	$MainForm.Controls.Add($textbox1)
	$MainForm.Controls.Add($buttonLaunchPrintServer)
	$MainForm.Controls.Add($buttonADK)
	$MainForm.Controls.Add($buttonOpenLogs)
	$MainForm.Controls.Add($buttonPing)
	$MainForm.Controls.Add($buttonNSLookup)
	$MainForm.ClientSize = '826, 276'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = "ITECS Dashboard"
	$MainForm.add_Load($OnLoadFormEvent)
	#
	# labelResults
	#
	$labelResults.Location = '532, 3'
	$labelResults.Name = "labelResults"
	$labelResults.Size = '170, 23'
	$labelResults.TabIndex = 10
	$labelResults.Text = "Results"
	#
	# buttonGetUserGroups
	#
	#$buttonGetUserGroups.Location = '12, 90'
	#$buttonGetUserGroups.Name = "buttonGetUserGroups"
	#$buttonGetUserGroups.Size = '175, 23'
	#$buttonGetUserGroups.TabIndex = 9
	#$buttonGetUserGroups.Text = "Get User Groups"
	#$buttonGetUserGroups.UseVisualStyleBackColor = $True
	#$buttonGetUserGroups.add_Click($buttonGetUserGroups_Click)
	#
	# buttonPing
	#
	$buttonPing.Location = '12, 90'
	$buttonPing.Name = "buttonGetUserGroups"
	$buttonPing.Size = '175, 23'
	$buttonPing.TabIndex = 9
	$buttonPing.Text = "Ping Computer"
	$buttonPing.UseVisualStyleBackColor = $True
	$buttonPing.add_Click($buttonPing_Click)
	#
	# buttonNSLookup
	#
	$buttonNSLookup.Location = '12, 61'
	$buttonNSLookup.Name = "buttonGetUserGroups"
	$buttonNSLookup.Size = '175, 23'
	$buttonNSLookup.TabIndex = 9
	$buttonNSLookup.Text = "NSLookup Computer"
	$buttonNSLookup.UseVisualStyleBackColor = $True
	$buttonNSLookup.add_Click($buttonNSLookup_Click)
	#
	# buttonLaunchADUC
	#
	$buttonLaunchADUC.Location = '12, 148'
	$buttonLaunchADUC.Name = "buttonGetUserGroups"
	$buttonLaunchADUC.Size = '175, 23'
	$buttonLaunchADUC.TabIndex = 9
	$buttonLaunchADUC.Text = "Launch ADUC"
	$buttonLaunchADUC.UseVisualStyleBackColor = $True
	$buttonLaunchADUC.add_Click($buttonLaunchADUC_Click)
	#
	# labelComputerTools
	#
	$labelComputerTools.Location = '141, 3'
	$labelComputerTools.Name = "labelComputerTools"
	$labelComputerTools.Size = '100, 23'
	$labelComputerTools.TabIndex = 8
	$labelComputerTools.Text = "ITECS Dashboard"
	#
	# buttonRemoteAssist
	#
	$buttonRemoteAssist.Location = '195, 61'
	$buttonRemoteAssist.Name = "buttonRemoteAssist"
	$buttonRemoteAssist.Size = '177, 23'
	$buttonRemoteAssist.TabIndex = 4
	$buttonRemoteAssist.Text = "Remote Assist"
	$buttonRemoteAssist.UseVisualStyleBackColor = $True
	$buttonRemoteAssist.add_Click($buttonRemoteAssist_Click)
	#
	# buttonOpenLogs
	#
	$buttonOpenLogs.Location = '195, 90'
	$buttonOpenLogs.Name = "buttonOpenLogs"
	$buttonOpenLogs.Size = '177, 23'
	$buttonOpenLogs.TabIndex = 4
	$buttonOpenLogs.Text = "Open Logs"
	$buttonOpenLogs.UseVisualStyleBackColor = $True
	$buttonOpenLogs.add_Click($buttonOpenLogs_Click)
	#
	# buttonLaunchPrintServer
	#
	$buttonLaunchPrintServer.Location = '195, 119'
	$buttonLaunchPrintServer.Name = "buttonLaunchPrintServer"
	$buttonLaunchPrintServer.Size = '177, 23'
	$buttonLaunchPrintServer.TabIndex = 4
	$buttonLaunchPrintServer.Text = "Launch Print Servers"
	$buttonLaunchPrintServer.UseVisualStyleBackColor = $True
	$buttonLaunchPrintServer.add_Click($buttonLaunchPrintServer_Click)
	#
	# buttonBCR
	#
	$buttonBCR.Location = '195, 148'
	$buttonBCR.Name = "buttonBCR"
	$buttonBCR.Size = '177, 23'
	$buttonBCR.TabIndex = 4
	$buttonBCR.Text = "Launch the BCR"
	$buttonBCR.UseVisualStyleBackColor = $True
	$buttonBCR.add_Click($buttonBCR_Click)
	#
	# buttonHostFinder
	#
	$buttonHostFinder.Location = '12, 177'
	$buttonHostFinder.Name = "buttonHostFinder"
	$buttonHostFinder.Size = '177, 23'
	$buttonHostFinder.TabIndex = 4
	$buttonHostFinder.Text = "Launch Host Finder"
	$buttonHostFinder.UseVisualStyleBackColor = $True
	$buttonHostFinder.add_Click($buttonHostFinder_Click)
	#
	# buttonHostTool
	#
	$buttonHostTool.Location = '12, 207'
	$buttonHostTool.Name = "buttonHostFinder"
	$buttonHostTool.Size = '177, 23'
	$buttonHostTool.TabIndex = 4
	$buttonHostTool.Text = "Launch Host Tool"
	$buttonHostTool.UseVisualStyleBackColor = $True
	$buttonHostTool.add_Click($buttonHostTool_Click)
	#	
	# buttonITRACS
	#
	$buttonITRACS.Location = '195, 177'
	$buttonITRACS.Name = "buttonLaunchPrintServer"
	$buttonITRACS.Size = '177, 23'
	$buttonITRACS.TabIndex = 4
	$buttonITRACS.Text = "Launch ITRACS"
	$buttonITRACS.UseVisualStyleBackColor = $True
	$buttonITRACS.add_Click($buttonITRACS_Click)
	#
	# buttonADK
	#
	$buttonADK.Location = '12, 119'
	$buttonADK.Name = "buttonADK"
	$buttonADK.Size = '177, 23'
	$buttonADK.TabIndex = 4
	$buttonADK.Text = "Launch ADK"
	$buttonADK.UseVisualStyleBackColor = $True
	$buttonADK.add_Click($buttonADK_Click)
	#
	# listbox1
	#
	$listbox1.FormattingEnabled = $True
	$listbox1.Location = '418, 26'
	$listbox1.Name = "listbox1"
	$listbox1.Size = '380, 238'
	$listbox1.TabIndex = 3
	#
	# buttonGetSoftware
	#
	#$buttonGetSoftware.Location = '12, 61'
	#$buttonGetSoftware.Name = "buttonGetSoftware"
	#$buttonGetSoftware.Size = '177, 23'
	#$buttonGetSoftware.TabIndex = 2
	#$buttonGetSoftware.Text = "Get Software"
	#$buttonGetSoftware.UseVisualStyleBackColor = $True
	#$buttonGetSoftware.add_Click($buttonGetSoftware_Click)
	#
	# labelComputerUserName
	#
	$labelComputerUserName.Location = '12, 26'
	$labelComputerUserName.Name = "labelComputerUserName"
	$labelComputerUserName.Size = '123, 23'
	$labelComputerUserName.TabIndex = 1
	$labelComputerUserName.Text = "Computer Name:"
	#
	# textbox1
	#
	$textbox1.Location = '174, 26'
	$textbox1.Name = "textbox1"
	$textbox1.Size = '219, 20'
	$textbox1.TabIndex = 0
	$MainForm.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $MainForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$MainForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$MainForm.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $MainForm.ShowDialog()
}
#endregion Source: MainForm.psf

#region Source: HostTool.psf
function Call-HostTool_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$HostTool = New-Object 'System.Windows.Forms.Form'
	$labelhostlist = New-Object 'System.Windows.Forms.Label'
	$labelhostresults = New-Object 'System.Windows.Forms.Label'
	$listbox1 = New-Object 'System.Windows.Forms.ListBox'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
	
	}
		
	$button1_Click={
		#TODO: Place custom script here
		$hosts = $richtextbox1.Text.Split("`n")
		foreach ($hosts in $hosts)
		{
			$job1 = test-connection -Count 1 $hosts -quiet
			If ($job1 -eq "True")
			{
			$ip = [System.Net.Dns]::GetHostAddresses($hosts)
			$job2= $hosts + ", is up "
			$totalinfo= $job2 + ", with IP Address," + $ip
			Load-ListBox -ListBox $listbox1 -Items $totalinfo -Append
			#copy $path\outfile.txt $path\outfile2.csv
			#start-process excel.exe $path\outfile2.csv
			#ConvertTo-Csv -Delimiter ","
			#export-csv -InputObject $csvtest $path\csvtest.csv
			}
			Else
			{
			$hostdowninfo= $hosts + ", Is Down "
			$ErrorActionPreference = "SilentlyContinue"
			$downhostip = [System.Net.Dns]::GetHostAddresses($hosts)
			If (($downhostip -Like "152.*") -or ($downhostip -Like "10.*") -or ($downhostip -Like "172.*") -or ($downhostip -Like "192.*"))
			{
			$hostdownwithip = $hostdowninfo + ", with IP ," + $downhostip
			Load-ListBox -ListBox $listBox1 -Items $hostdownwithip -Append
			}
			Else
			{
			$hostdownwithoutip = $hostdowninfo + ", and has NO IP"
			Load-ListBox -ListBox $listBox1 -Items $hostdownwithoutip -Append
			}
			#$hostnoip = $hostdowninfo + ", and has no IP"
			#Load-ListBox -ListBox $listbox1 -Items $hostnoip -Append
			#$totaldowninf = $hostdowninfo + ", with ip " + $downhostip
			#Load-ListBox -ListBox $listbox1 -Items $totaldowninf -Append
			}
			$exportinfo = $listBox1.items
			$path = $env:USERPROFILE + "\Desktop"
			Out-File -InputObject $exportinfo $path\outfile.txt			
		}	
	}
	
	$button2_Click={
	#TODO: Place custom script here
	$HostTool.Close()
	}
	
	#region Control Helper Functions
	function Load-ListBox 
	{
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			[System.Windows.Forms.ListBox]$ListBox,
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			$Items,
		    [Parameter(Mandatory=$false)]
			[string]$DisplayMember,
			[switch]$Append
		)
		
		if(-not $Append)
		{
			$listBox.Items.Clear()	
		}
		
		if($Items -is [System.Windows.Forms.ListBox+ObjectCollection])
		{
			$listBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$listBox.BeginUpdate()
			foreach($obj in $Items)
			{
				$listBox.Items.Add($obj)
			}
			$listBox.EndUpdate()
		}
		else
		{
			$listBox.Items.Add($Items)	
		}
	
		$listBox.DisplayMember = $DisplayMember	
	}
	#endregion
		# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$HostTool.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:HostTool_listbox1 = $listbox1.SelectedItems
		$script:HostTool_richtextbox1 = $richtextbox1.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$button2.remove_Click($button2_Click)
			$button1.remove_Click($button1_Click)
			$HostTool.remove_Load($OnLoadFormEvent)
			$HostTool.remove_Load($Form_StateCorrection_Load)
			$HostTool.remove_Closing($Form_StoreValues_Closing)
			$HostTool.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$HostTool.SuspendLayout()
	#
	# HostTool
	#
	$HostTool.Controls.Add($listbox1)
	$HostTool.Controls.Add($button1)
	$HostTool.Controls.Add($button2)
	$HostTool.Controls.Add($labelhostlist)
	$HostTool.Controls.Add($labelhostresults)
	$HostTool.Controls.Add($richtextbox1)
	$HostTool.ClientSize = '654, 266'
	$HostTool.Name = "HostTool"
	$HostTool.StartPosition = 'CenterScreen'
	$HostTool.Text = "ITECS Host Lookup Tool"
	$HostTool.add_Load($OnLoadFormEvent)
	#
	# labelhostlist
	#
	$labelhostlist.Font = "Microsoft Sans Serif, 12pt, style=Bold"
	$labelhostlist.Location = '37, 20'
	$labelhostlist.Name = "labelhostlist"
	$labelhostlist.Size = '300, 23'
	$labelhostlist.TabIndex = 8
	$labelhostlist.Text = "List Hosts to test here"
	#
	# labelhostresults
	#
	$labelhostresults.Font = "Microsoft Sans Serif, 12pt, style=Bold"
	$labelhostresults.Location = '340, 20'
	$labelhostresults.Name = "labelhostlist"
	$labelhostresults.Size = '300, 23'
	$labelhostresults.TabIndex = 8
	$labelhostresults.Text = "Host Check Results"
	#	
	# listbox1
	#
	$listbox1.FormattingEnabled = $True
	$listbox1.Location = '263, 45'
	$listbox1.Name = "listbox1"
	$listbox1.Size = '379, 174'
	$listbox1.TabIndex = 3
	#
	# button1
	#
	$button1.Location = '37, 225'
	$button1.Name = "button1"
	$button1.Size = '200, 23'
	$button1.TabIndex = 1
	$button1.Text = "Test Connection"
	$button1.UseVisualStyleBackColor = $True
	$button1.add_Click($button1_Click)
	#
	# button2
	#
	$button2.Location = '350, 225'
	$button2.Name = "button2"
	$button2.Size = '200, 23'
	$button2.TabIndex = 1
	$button2.Text = "Close Host Tool"
	$button2.UseVisualStyleBackColor = $True
	$button2.add_Click($button2_Click)
	#	
	# richtextbox1
	#
	$richtextbox1.Location = '37, 45'
	$richtextbox1.Name = "richtextbox1"
	$richtextbox1.Size = '200, 174'
	$richtextbox1.TabIndex = 0
	$richtextbox1.Text = ""
	$HostTool.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $HostTool.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$HostTool.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$HostTool.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$HostTool.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $HostTool.ShowDialog()
}
#endregion Source: HostTool.psf


#Start the application
Main ($CommandLine)
# SIG # Begin signature block
# MIIYGgYJKoZIhvcNAQcCoIIYCzCCGAcCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUKmPBn0GR+8n33fpIgx464P/8
# k8KgghMDMIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
# AQUFADCBizELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTEUMBIG
# A1UEBxMLRHVyYmFudmlsbGUxDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUVGhh
# d3RlIENlcnRpZmljYXRpb24xHzAdBgNVBAMTFlRoYXd0ZSBUaW1lc3RhbXBpbmcg
# Q0EwHhcNMTIxMjIxMDAwMDAwWhcNMjAxMjMwMjM1OTU5WjBeMQswCQYDVQQGEwJV
# UzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFu
# dGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBALGss0lUS5ccEgrYJXmRIlcqb9y4JsRDc2vCvy5Q
# WvsUwnaOQwElQ7Sh4kX06Ld7w3TMIte0lAAC903tv7S3RCRrzV9FO9FEzkMScxeC
# i2m0K8uZHqxyGyZNcR+xMd37UWECU6aq9UksBXhFpS+JzueZ5/6M4lc/PcaS3Er4
# ezPkeQr78HWIQZz/xQNRmarXbJ+TaYdlKYOFwmAUxMjJOxTawIHwHw103pIiq8r3
# +3R8J+b3Sht/p8OeLa6K6qbmqicWfWH3mHERvOJQoUvlXfrlDqcsn6plINPYlujI
# fKVOSET/GeJEB5IL12iEgF1qeGRFzWBGflTBE3zFefHJwXECAwEAAaOB+jCB9zAd
# BgNVHQ4EFgQUX5r1blzMzHSa1N197z/b7EyALt0wMgYIKwYBBQUHAQEEJjAkMCIG
# CCsGAQUFBzABhhZodHRwOi8vb2NzcC50aGF3dGUuY29tMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC50aGF3dGUuY29tL1Ro
# YXd0ZVRpbWVzdGFtcGluZ0NBLmNybDATBgNVHSUEDDAKBggrBgEFBQcDCDAOBgNV
# HQ8BAf8EBAMCAQYwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0y
# MDQ4LTEwDQYJKoZIhvcNAQEFBQADgYEAAwmbj3nvf1kwqu9otfrjCR27T4IGXTdf
# plKfFo3qHJIJRG71betYfDDo+WmNI3MLEm9Hqa45EfgqsZuwGsOO61mWAK3ODE2y
# 0DGmCFwqevzieh1XTKhlGOl5QGIllm7HxzdqgyEIjkHq3dlXPx13SYcqFgZepjhq
# IhKjURmDfrYwggSjMIIDi6ADAgECAhAOz/Q4yP6/NW4E2GqYGxpQMA0GCSqGSIb3
# DQEBBQUAMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyMB4XDTEyMTAxODAwMDAwMFoXDTIwMTIyOTIzNTk1OVowYjELMAkGA1UE
# BhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMTQwMgYDVQQDEytT
# eW1hbnRlYyBUaW1lIFN0YW1waW5nIFNlcnZpY2VzIFNpZ25lciAtIEc0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAomMLOUS4uyOnREm7Dv+h8GEKU5Ow
# mNutLA9KxW7/hjxTVQ8VzgQ/K/2plpbZvmF5C1vJTIZ25eBDSyKV7sIrQ8Gf2Gi0
# jkBP7oU4uRHFI/JkWPAVMm9OV6GuiKQC1yoezUvh3WPVF4kyW7BemVqonShQDhfu
# ltthO0VRHc8SVguSR/yrrvZmPUescHLnkudfzRC5xINklBm9JYDh6NIipdC6Anqh
# d5NbZcPuF3S8QYYq3AhMjJKMkS2ed0QfaNaodHfbDlsyi1aLM73ZY8hJnTrFxeoz
# C9Lxoxv0i77Zs1eLO94Ep3oisiSuLsdwxb5OgyYI+wu9qU+ZCOEQKHKqzQIDAQAB
# o4IBVzCCAVMwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAO
# BgNVHQ8BAf8EBAMCB4AwcwYIKwYBBQUHAQEEZzBlMCoGCCsGAQUFBzABhh5odHRw
# Oi8vdHMtb2NzcC53cy5zeW1hbnRlYy5jb20wNwYIKwYBBQUHMAKGK2h0dHA6Ly90
# cy1haWEud3Muc3ltYW50ZWMuY29tL3Rzcy1jYS1nMi5jZXIwPAYDVR0fBDUwMzAx
# oC+gLYYraHR0cDovL3RzLWNybC53cy5zeW1hbnRlYy5jb20vdHNzLWNhLWcyLmNy
# bDAoBgNVHREEITAfpB0wGzEZMBcGA1UEAxMQVGltZVN0YW1wLTIwNDgtMjAdBgNV
# HQ4EFgQURsZpow5KFB7VTNpSYxc/Xja8DeYwHwYDVR0jBBgwFoAUX5r1blzMzHSa
# 1N197z/b7EyALt0wDQYJKoZIhvcNAQEFBQADggEBAHg7tJEqAEzwj2IwN3ijhCcH
# bxiy3iXcoNSUA6qGTiWfmkADHN3O43nLIWgG2rYytG2/9CwmYzPkSWRtDebDZw73
# BaQ1bHyJFsbpst+y6d0gxnEPzZV03LZc3r03H0N45ni1zSgEIKOq8UvEiCmRDoDR
# EfzdXHZuT14ORUZBbg2w6jiasTraCXEQ/Bx5tIB7rGn0/Zy2DBYr8X9bCT2bW+IW
# yhOBbQAuOA2oKY8s4bL0WqkBrxWcLC9JG9siu8P+eJRRw4axgohd8D20UaF5Mysu
# e7ncIAkTcetqGVvP6KUwVyyJST+5z3/Jvz4iaGNTmr1pdKzFHTx/kuDDvBzYBHUw
# ggUTMIID+6ADAgECAgoT+4/+AAAAAAAGMA0GCSqGSIb3DQEBBQUAMIG7MQswCQYD
# VQQGEwJVUzEXMBUGA1UECBMOTm9ydGggQ2Fyb2xpbmExEDAOBgNVBAcTB1JhbGVp
# Z2gxKDAmBgNVBAoTH05vcnRoIENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkxJTAj
# BgkqhkiG9w0BCQEWFnNlY3VyaXR5QGhlbHAubmNzdS5lZHUxMDAuBgNVBAMTJ05v
# cnRoIENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkgUm9vdCBDQTAeFw0xMTAzMTEx
# NTQ5NDRaFw0zNjAzMTExNTU5NDRaMIHBMQswCQYDVQQGEwJVUzEXMBUGA1UECBMO
# Tm9ydGggQ2Fyb2xpbmExEDAOBgNVBAcTB1JhbGVpZ2gxKDAmBgNVBAoTH05vcnRo
# IENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkxNjA0BgNVBAMTLU5vcnRoIENhcm9s
# aW5hIFN0YXRlIFVuaXZlcnNpdHkgRW50ZXJwcmlzZSBDQTElMCMGCSqGSIb3DQEJ
# ARYWc2VjdXJpdHlAaGVscC5uY3N1LmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEP
# ADCCAQoCggEBALJxm+FhUBDueygU9qgwC25Ty0POM5vCKkvF16pXnZvfw6j4ch5c
# mn04reIyHPklkQ9hJmsLeUqZ5A/EPyNuIYsDGVGT0cPvZie7cV3Wqe8DUwOReUpj
# 2uCs2+4b9xvpnI3BU7coh1N9xJ09iBBGy9I7bMxGXqF5pu4KmJaFJlQzfEFBYeAk
# I2+VMkvLXc0+ckaOQTsnevhvImnKNMFSbanr5R9oWnYn/l3VrkMlvNLVrCT8ELE1
# ClYGd2iUDmC5VJUKzZsZYdWl7PT1UxgXM+rV688rKUZjaWL15YSHl/wSIxSpAO+j
# 5YTwFJUlUh6yPrMW6q/9WA7MApjrjRRw/GsCAwEAAaOCAQ8wggELMBAGCSsGAQQB
# gjcVAQQDAgEAMB0GA1UdDgQWBBShlyYnwpIdWf41HwQWSswEyAxxijAZBgkrBgEE
# AYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB
# /wIBAzAfBgNVHSMEGDAWgBRXF6uwq+8pdNJY+Th9PSJtspXGsDA3BgNVHR8EMDAu
# MCygKqAohiZodHRwOi8vd3d3Lm5jc3UuZWR1L2NybC9OQ1NVUm9vdENBLmNybDBC
# BggrBgEFBQcBAQQ2MDQwMgYIKwYBBQUHMAKGJmh0dHA6Ly93d3cubmNzdS5lZHUv
# Y3JsL05DU1VSb290Q0EuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQCXA8kjyxvCbuWZ
# +bn0PYFRuPQqrhkpcKeP951bQMR+XYzueJCcNgzdMcOyQcxf45wYqyymUSrpknnS
# HWCShRYWFoNxBx3ZVrm9sw2HfrWLC24NB99aXp1SSjOF2O5NAlnZh1qiBefA0UiN
# eFx0FQ4dVvwA9p17Pal1PPekHwQFnnFt+TinZUfowipJDsp/wsAjFQJIrfunouNy
# kHgFvkDw6yzEVT5l+gQBGx9LpXOk5IHXA36Pn6GjLBYNQMjBBWf3xrFFX5CWSXsg
# jQDo0GaWGZoGTV+1gCxRVqIgkF+ha9xUg5WFL/N9e6mLTQjRtJQ4Tn/XqZv7B+lt
# ge8VYVAiMIIFTzCCBDegAwIBAgIKExH7sAAAAAa5jjANBgkqhkiG9w0BAQUFADCB
# wTELMAkGA1UEBhMCVVMxFzAVBgNVBAgTDk5vcnRoIENhcm9saW5hMRAwDgYDVQQH
# EwdSYWxlaWdoMSgwJgYDVQQKEx9Ob3J0aCBDYXJvbGluYSBTdGF0ZSBVbml2ZXJz
# aXR5MTYwNAYDVQQDEy1Ob3J0aCBDYXJvbGluYSBTdGF0ZSBVbml2ZXJzaXR5IEVu
# dGVycHJpc2UgQ0ExJTAjBgkqhkiG9w0BCQEWFnNlY3VyaXR5QGhlbHAubmNzdS5l
# ZHUwHhcNMTUwMTE1MTg1NDA1WhcNMTYwMTE1MTg1NDA1WjAXMRUwEwYDVQQDEwxh
# cHNlbm4uYWRtaW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCczfaa
# 4aBR0DQIUZKuCj1J0gDDyd6Gxpq/h8NSOQRBjTOzFYGptJAMFriZmDwgwA3APGsw
# KZ/AxDgWybqVu6Pl+zbmehz6HoXVbmJ7YOLeJL4lTCYr1b7Wh8DNP2X1JfTsmN1R
# 0wWq1EqDP7DtsksUMlLlpuB9EzW5q1q1TTWsIe+rf6GC4RT43psMyOEZCRKxWOUl
# BCAKIcPpl5/XNm2iJzXmhqKBYsReVaxvVmNijNpWK5wExPufkSi45SegY5SKBhop
# ai+TSxqg6/8KIYKH3wpIWVmwbB687Ey6tztZ+Hx0T/ZJoBmKklw5TH8v84u1sDje
# XiZop1VmD60Dc1EvAgMBAAGjggHwMIIB7DA9BgkrBgEEAYI3FQcEMDAuBiYrBgEE
# AYI3FQiC9N4YhP/3JO2HFoTbplyH4oNlgUmHrOFWgdPAKwIBZAIBAzATBgNVHSUE
# DDAKBggrBgEFBQcDAzAOBgNVHQ8BAf8EBAMCB4AwGwYJKwYBBAGCNxUKBA4wDDAK
# BggrBgEFBQcDAzAdBgNVHQ4EFgQUu1QjNcZLhX7nDxq3dIbubJ9hZygwHwYDVR0j
# BBgwFoAUoZcmJ8KSHVn+NR8EFkrMBMgMcYowVQYDVR0fBE4wTDBKoEigRoZEaHR0
# cDovL3d3dy5uY3N1LmVkdS9jcmwvTm9ydGhDYXJvbGluYVN0YXRlVW5pdmVyc2l0
# eUVudGVycHJpc2VDQS5jcmwwgZMGCCsGAQUFBwEBBIGGMIGDMFAGCCsGAQUFBzAC
# hkRodHRwOi8vd3d3Lm5jc3UuZWR1L2NybC9Ob3J0aENhcm9saW5hU3RhdGVVbml2
# ZXJzaXR5RW50ZXJwcmlzZUNBLmNydDAvBggrBgEFBQcwAYYjaHR0cDovL3d0LW9j
# c3AtMDAub2l0Lm5jc3UuZWR1L29jc3AwPAYDVR0RBDUwM6AxBgorBgEEAYI3FAID
# oCMMIWFwc2Vubi5hZG1pbkB3b2xmdGVjaC5hZC5uY3N1LmVkdTANBgkqhkiG9w0B
# AQUFAAOCAQEABRXshBq8OQS9f5YSWL4TnWXxtQZhXUhl6q6pSU0DoiJngsLhKwyP
# GzYJ9NaNKoZOBimMQ0E8oi1bUml19x0VD3phV3T0a1NIfhE9njrnSjMU7ZXMPZGt
# Szn58/GOmtBOJwRCwJokImb99iWENqQZVvfFpBjTV2sNbLRjvvjURGkHxBbQNsbv
# ykv3a2WqhxsuLjW3+60HZgXCVoQrIN8ZROQpOGCudDGHgzVqTbT69dVun+f87LR9
# wgWanA98r70RrCicgrweW3eUJx576v46w2gOOYnViIwBcVXvESmawvWqBneGOiPs
# TierZcObN6t6mEfabXt4VdV1pilZIblVxzGCBIEwggR9AgEBMIHQMIHBMQswCQYD
# VQQGEwJVUzEXMBUGA1UECBMOTm9ydGggQ2Fyb2xpbmExEDAOBgNVBAcTB1JhbGVp
# Z2gxKDAmBgNVBAoTH05vcnRoIENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkxNjA0
# BgNVBAMTLU5vcnRoIENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkgRW50ZXJwcmlz
# ZSBDQTElMCMGCSqGSIb3DQEJARYWc2VjdXJpdHlAaGVscC5uY3N1LmVkdQIKExH7
# sAAAAAa5jjAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZ
# BgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYB
# BAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUs0K49du1LINtV0UsEwPj4nl2+50wDQYJ
# KoZIhvcNAQEBBQAEggEAM6c4VIpZOxd6Zhs2plc7+mpIa7KQEGFPQxFuMgV6gMjp
# J0FW/6f+s3uGpmKsK7idiQn4sk4n2/uEXSl0sejpVWXDYwt7pAusdmqMtj3IG7vy
# eFgOGaKulb5nKCUi7GMdDlUpA2xLpmAqYvjKQSZRBSWZuLDhxDkkWG/4PGao7+Xm
# jSzPGytZPGqcfnj+BpJcdw0lXBaop6Ifgf8nqrfuzZa9yMbYNwIPVYRP9wCuIiJM
# EJ3zqHoDeB91/6ekbFoK7+g+ExGZGl6tB2IpADOguHnUDKVqc5ctSkRqoysEq9O4
# RUnpolk/krqN4ruEXOoxe4mzcfOpFfSAv7526qhHqqGCAgswggIHBgkqhkiG9w0B
# CQYxggH4MIIB9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRl
# YyBDb3Jwb3JhdGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBT
# ZXJ2aWNlcyBDQSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAY
# BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAxMjky
# MDE3MDBaMCMGCSqGSIb3DQEJBDEWBBQBGEltSsltPrpUT2u8rUqEE+pZwDANBgkq
# hkiG9w0BAQEFAASCAQAy+k7nhyHveOp8NHM7DbDTNFLxroQ8rO+WMY6rGZRvzh41
# ERlR0lcc3M3FOUTNYZHV5pFovsAqVbvUbNy4DWVL5Wo/MPSzpdjIeqRl3YCiR021
# 17vebO6vZQxKJ72EsYP3rZ0R6x5NO6e9VLS59Oo/KNtxjiTZlKjfAw06Ezm2ENgD
# sSeIRdgEO4SyK+gasztz/Hiuj9pXYklxMTQQPxJX11qRmFZubeggbH04uGHI1KKU
# zIJfvqvO0aydrY9Gxea3cW2kvvJR2nICON6vFiUj1Mc+5CHoMLlCBeiNvt8B8CZ7
# jeUIF3Cj6ARRV3mD+DjgsIXSmckr/FrjGby0fS9O
# SIG # End signature block
