﻿<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.3.131
     Generated on:       12/14/2016 7:51 AM
     Generated by:       asenn
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2016
#>


#region Source: Startup.pss
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
2gMAAB+LCAAAAAAABAC9k0tLAzEQgO+C/yH0vGR33a5rIbsglV4EFVfUazadLcE8yiRpyb+3rVJF
QaGHMJd5MPMxL/YIwm4A4w33nOwUJ61pJxe0nHTnZ4Swe5QrabhaSAV3XEPXe44+rOnaOZb/ih5y
rp0DPSgJ7mB/eWKnnbCo5JCR50/WlBZ7ycg8KB8QWgPBI1cZeQi7GuIW4pN9A9MOTcNrUV+Ws2oK
xdWM5ceqPyl9dB50CgZ9kWZpt44uLGqXhLjfVBoQ8q00q1NYRTXWYzOW5bIueMX/Z71qlaSnuUVI
MzyJILzF2ANupICTbuPvMR7Nj0dj+fdf7t4BtbYVHtoDAAA=#>
#endregion
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
[void][Reflection.Assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][Reflection.Assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
		
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)
		
	#--------------------------------------------------------------------------
	#TODO: Add initialization script here (Load modules and check requirements)
	
	
	#--------------------------------------------------------------------------
	
	if((Show-MainForm_psf) -eq 'OK')
	{
		
	}
	
	$script:ExitCode = 0 #Set the exit code for the Packager
}







#endregion Source: Startup.pss

#region Source: Globals.ps1
	#--------------------------------------------
	# Declare Global Variables and Functions here
	#--------------------------------------------
	
	
	#Sample function that provides the location of the script
	function Get-ScriptDirectory
	{
	<#
		.SYNOPSIS
			Get-ScriptDirectory returns the proper location of the script.
	
		.OUTPUTS
			System.String
		
		.NOTES
			Returns the correct path within a packaged executable.
	#>
		[OutputType([string])]
		param ()
		#if ($null -ne $hostinvocation)
		#{
		#	Split-Path $hostinvocation.MyCommand.path
		#}
		#else
		#{
		#	Split-Path $script:MyInvocation.MyCommand.Path
		#}
	}
	
	#Sample variable that provides the location of the script
	[string]$ScriptDirectory = Get-ScriptDirectory
	
	
	
#endregion Source: Globals.ps1

#region Source: MainForm.psf
function Show-MainForm_psf
{
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
GxQAAB+LCAAAAAAABADdWGtv2jAU/T5p/yHK54h3eEgQqdBWmtquqLBu3yaTXKhXx0aO08J+/W5I
aMvyMoiyaiJCCfHxuY/DuVH6d+CKJ5Drc6KIgScBFXxgNip10/n8yTD6t5IuKCfskjL4Snxwbgjl
l0L6lWUw71dTt2PQ7Be4ylDrJQzMyTpQ4Fe+U+6J56ASYeNvy8i6ZRn3SRStSi36WMYoZCqUMOAQ
KkmYZYzDGaPuFayn4hH4YNbpENu12/VeswW1bs80OIYyMOe4X9003AfKPInrzJHgSgoWxLlhoGMp
liDVOgGchUpMXMLgnPrAoyBwadsy6s1+dbu0DHojPDCdS2QqxYwYBa4m9DcCeh1MtNkrJ4qqbDqb
1ErXTmGlolikn1568YTcybprQbxkz5/Reb+6ubtdWt7OYaiU4O/e0NmG5mJFVVFXM5rD3QchTWco
EI+6u6OLh3R70rhzSphY3EGA8ZrO7ZUG5Fq4RGGyptPtdLGjdlcDFPf0NTsNSKyajm0ZjbRmMpRA
Zl+4ByvTSasmTzeakXwL4J4GIWETtWYwJO7jSLCo2lMZQlp31VhN+trC0JMOv7u+FJm5MVWhbeQL
bCqWlrFV2TXMlb7WXoXTbliG3dCWzZugdXQDDOsNXqKGmrbUunaktVZvL7Flbq/V8jFZwCn6vUSe
kmYX9aqFNclqVUGzNoxakDHxPMoXptNEI4kPLVzSsFYnCk4PUtyyPIfYK5v9fOIjDh4kE/yWY61K
FXP4DDpwDhXLtNFDKWRNorJp9CZlTXTyONPOGUzF4sv+K+XJbxOcgcce4R2gwt2JlfXDh3O0xskd
TQ/yTxxNz552HE0vm//J0UoV8yEcDasASY1HQvI5E88ghyyn2kUyr7e7OU9Z+VJP1ewUlqiNSFmi
bnjHt8Sdy90LDasUgk3p8v2tEnkUXeIor8ahnQUB+AiFYJtG8sva8QNXSEZnR6DvV192/ZslTvgU
HEcvajlj9ILpNESSPOOMOYSr1pzb8868XvfsGmmScq4fPjtJTmh2cHyil8tY8v3q25eBzh96gRh4
GxQAAA==#>
#endregion
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$form1 = New-Object 'System.Windows.Forms.Form'
	$buttonExit = New-Object 'System.Windows.Forms.Button'
	$tabcontrol1 = New-Object 'System.Windows.Forms.TabControl'
	$tabpage1 = New-Object 'System.Windows.Forms.TabPage'
	$buttonButonOnTab1 = New-Object 'System.Windows.Forms.Button'
	$tabpage2 = New-Object 'System.Windows.Forms.TabPage'
	$buttonButonOnTab2 = New-Object 'System.Windows.Forms.Button'
	$tooltip1 = New-Object 'System.Windows.Forms.ToolTip'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$form1_Load={
		UpdateNavButtons
	}
	
	function UpdateNavButtons
	{

	}
	

		# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$form1.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$form1.remove_Load($form1_Load)
			$form1.remove_Load($Form_StateCorrection_Load)
			$form1.remove_Closing($Form_StoreValues_Closing)
			$form1.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$form1.SuspendLayout()
	$tabcontrol1.SuspendLayout()
	$tabpage1.SuspendLayout()
	$tabpage2.SuspendLayout()
	#
	# form1
	#
	$form1.Controls.Add($buttonExit)
	$form1.Controls.Add($tabcontrol1)
	$form1.AutoScaleDimensions = '6, 13'
	$form1.AutoScaleMode = 'Font'
	$form1.ClientSize = '970, 393'
	$form1.Name = 'form1'
	$form1.Text = 'Form'
	$form1.add_Load($form1_Load)
	#
	# buttonExit
	#
	$buttonExit.Anchor = 'Bottom, Right'
	$buttonExit.DialogResult = 'OK'
	$buttonExit.Location = '878, 358'
	$buttonExit.Name = 'buttonExit'
	$buttonExit.Size = '75, 23'
	$buttonExit.TabIndex = 1
	$buttonExit.Text = 'Exit'
	$buttonExit.UseVisualStyleBackColor = $True
	#
	# tabcontrol1
	#
	$tabcontrol1.Controls.Add($tabpage1)
	$tabcontrol1.Controls.Add($tabpage2)
	$tabcontrol1.Anchor = 'Top, Bottom, Left, Right'
	$tabcontrol1.Location = '62, 52'
	$tabcontrol1.Name = 'tabcontrol1'
	$tabcontrol1.SelectedIndex = 0
	$tabcontrol1.Size = '855, 249'
	$tabcontrol1.TabIndex = 0
	#
	# tabpage1
	#
	$tabpage1.Controls.Add($buttonButonOnTab1)
	$tabpage1.Location = '4, 22'
	$tabpage1.Name = 'tabpage1'
	$tabpage1.Padding = '3, 3, 3, 3'
	$tabpage1.Size = '847, 223'
	$tabpage1.TabIndex = 0
	$tabpage1.Text = 'tabpage1'
	$tabpage1.UseVisualStyleBackColor = $True
	#
	# buttonButonOnTab1
	#
	$buttonButonOnTab1.Anchor = 'Bottom, Right'
	$buttonButonOnTab1.DialogResult = 'OK'
	$buttonButonOnTab1.Location = '29, 28'
	$buttonButonOnTab1.Name = 'buttonButonOnTab1'
	$buttonButonOnTab1.Size = '96, 23'
	$buttonButonOnTab1.TabIndex = 2
	$buttonButonOnTab1.Text = 'Buton on Tab1'
	$buttonButonOnTab1.UseVisualStyleBackColor = $True
	#
	# tabpage2
	#
	$tabpage2.Controls.Add($buttonButonOnTab2)
	$tabpage2.Location = '4, 22'
	$tabpage2.Name = 'tabpage2'
	$tabpage2.Padding = '3, 3, 3, 3'
	$tabpage2.Size = '847, 223'
	$tabpage2.TabIndex = 1
	$tabpage2.Text = 'tabpage2'
	$tabpage2.UseVisualStyleBackColor = $True
	#
	# buttonButonOnTab2
	#
	$buttonButonOnTab2.Anchor = 'Bottom, Right'
	$buttonButonOnTab2.DialogResult = 'OK'
	$buttonButonOnTab2.ForeColor = 'CornflowerBlue'
	$buttonButonOnTab2.Location = '168, 52'
	$buttonButonOnTab2.Name = 'buttonButonOnTab2'
	$buttonButonOnTab2.Size = '96, 23'
	$buttonButonOnTab2.TabIndex = 3
	$buttonButonOnTab2.Text = 'Buton on Tab2'
	$buttonButonOnTab2.UseVisualStyleBackColor = $True
	#
	# tooltip1
	#
	$tabpage2.ResumeLayout()
	$tabpage1.ResumeLayout()
	$tabcontrol1.ResumeLayout()
	$form1.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $form1.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$form1.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$form1.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$form1.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $form1.ShowDialog()

}
#endregion Source: MainForm.psf

#Start the application
Main ($CommandLine)
