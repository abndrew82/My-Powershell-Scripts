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
    $textbox4 = New-Object 'System.Windows.Forms.TextBox'
    $buttonGetinfo = New-Object 'System.Windows.Forms.Button'
    
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
   
	
	}
	#region Control Helper Functions
		$buttonGetinfo_Click={
		#TODO: Place custom script here
		$textbox4.text = "Fuck"
	}
	
	# --End User Generated Script--
	
	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($labelResults)
	$MainForm.Controls.Add($buttonGetinfo)
    $MainForm.Controls.Add($textbox4)
    $MainForm.ClientSize = '400, 200'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = "FSU Share Reporter"
	$MainForm.add_Load($OnLoadFormEvent)
	#
	# labelResults
	#
	$labelResults.Location = '100, 10'
    $LabelResultsFont = New-Object System.Drawing.Font("Times New Roman",18,[System.Drawing.FontStyle]::Bold)
	$labelResults.Name = "labelResults"
    $labelResults.Font = $LabelResultsFont
	$labelResults.Size = '300, 30'
	$labelResults.TabIndex = 10
	$labelResults.Text = "Label"
	#	
	# textbox4
	#
	$textbox4.Location = '225, 140'
    $Textbox4Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
    $Textbox4.Multiline = $True
    $textbox4.Font = $Textbox1Font
	$textbox4.Name = "textbox1"
	$textbox4.Size = '150, 25'
	$textbox4.TabIndex = 0
	$MainForm.ResumeLayout()
	#	
	# Button Get Info
	#
	$buttonGetinfo.Location = '50, 170'
	$buttonGetinfo.Name = "buttonGetInfo"
	$buttonGetinfo.Size = '160, 23'
	$buttonGetinfo.TabIndex = 9
	$buttonGetinfo.Text = "Get Information"
	$buttonGetinfo.UseVisualStyleBackColor = $True
	$buttonGetinfo.add_Click($buttonGetinfo_Click)
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