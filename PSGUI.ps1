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
$CompName = $args[0]
#$CompName = "asenn-dellt5600"
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
    $labelData = New-Object 'System.Windows.Forms.Label'
    $textbox1 = New-Object 'System.Windows.Forms.TextBox'
    $buttonPing = New-Object 'System.Windows.Forms.Button'
	#$labelComputerUserName = New-Object 'System.Windows.Forms.Label'

	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
   
	
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
	

		$buttonPing_Click={
		#TODO: Place custom script here
        $InstallDate = Invoke-command -computer $CompName {Get-ItemProperty "HKLM:\Software\UNCFSU" | Select -ExpandProperty "Install Date"} -ErrorAction SilentlyContinue
        $FSUTag = Invoke-command -computer $CompName {Get-ItemProperty "HKLM:\Software\UNCFSU" | Select -ExpandProperty "FSU Tag"} -ErrorAction SilentlyContinue
        $InstalledBy = Invoke-command -computer $CompName {Get-ItemProperty "HKLM:\Software\UNCFSU" | Select -ExpandProperty "Installed By"} -ErrorAction SilentlyContinue
        $InstallReason = Invoke-command -computer $CompName {Get-ItemProperty "HKLM:\Software\UNCFSU" | Select -ExpandProperty "Install Reason"} -ErrorAction SilentlyContinue
        $Info = "Installed By: " + $InstalledBy + "`r`n" + "Install Date: " + $InstallDate + "`r`n" + "Install Reason: " + $InstallReason+ "`r`n" + "FSU Tag: " + $FSUTag 
        $textbox1.Text = $Info
		
				
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
    #$MainForm.Controls.Add($labelData)
    $MainForm.Controls.Add($buttonPing)
    $MainForm.Controls.Add($textbox1)
	$MainForm.ClientSize = '400, 200'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = "FSU Install Information"
	$MainForm.add_Load($OnLoadFormEvent)
	#

	#
	# buttonGetUserGroups
	#
	# labelResults
	#
	$labelResults.Location = '100, 10'
    $LabelResultsFont = New-Object System.Drawing.Font("Times New Roman",18,[System.Drawing.FontStyle]::Bold)
	$labelResults.Name = "labelResults"
    $labelResults.Font = $LabelResultsFont
	$labelResults.Size = '300, 23'
	$labelResults.TabIndex = 10
	$labelResults.Text = $CompName
	#
	# labelData
	#
	$labelData.Location = '150, 50'
	$labelData.Name = "labelResults"
	$labelData.Size = '170, 65'
	$labelData.TabIndex = 10
	$labelData.Text = "Blah"
	#
	# textbox1
	#
	$textbox1.Location = '75, 40'
    $Textbox1Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
    $Textbox1.Multiline = $True
    $textbox1.Font = $Textbox1Font
	$textbox1.Name = "textbox1"
	$textbox1.Size = '300, 100'
	$textbox1.TabIndex = 0
	$MainForm.ResumeLayout()
	#
	$buttonPing.Location = '115, 160'
	$buttonPing.Name = "buttonGetUserGroups"
	$buttonPing.Size = '175, 23'
	$buttonPing.TabIndex = 9
	$buttonPing.Text = "Get Information"
	$buttonPing.UseVisualStyleBackColor = $True
	$buttonPing.add_Click($buttonPing_Click)
	#

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

#Start the application
Main ($CommandLine)