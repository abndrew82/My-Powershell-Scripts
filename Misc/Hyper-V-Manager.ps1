#----------------------------------------------
#Hyper-V Snapshow Manager
#By APSENN
#----------------------------------------------

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
	$labelVMName = New-Object 'System.Windows.Forms.Label'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'	
	$textbox2 = New-Object 'System.Windows.Forms.TextBox'
	$listbox1 = New-Object 'System.Windows.Forms.ListBox'
	$buttonStartPSSession = New-Object 'System.Windows.Forms.Button'
	$buttonGetSnapshot = New-Object 'System.Windows.Forms.Button'
	$buttonStartVM = New-Object 'System.Windows.Forms.Button'
	$buttonStopVM = New-Object 'System.Windows.Forms.Button'
	$buttonGetVM = New-Object 'System.Windows.Forms.Button'
	$labelsnapshotname = New-Object 'System.Windows.Forms.Label'
	$buttonRestoreVMSnapshot = New-Object 'System.Windows.Forms.Button'
	
	#endregion Generated Form Objects
	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
	
	}
	$buttonGetSnapshot_Click={
		#TODO: Place custom script here
	$VMName=$textbox1.Text		
	$Snapshot = Get-VMSnapshot -VMName $VMName | Select Name
	Load-ListBox -ListBox $listbox1 -Items $Snapshot
	TextBox2.text = $Snapshot
	}
	
	$buttonStartPSSession_Click={
		#TODO: Place custom script here
	$PSSession = New-PSSession -ComputerName Timon
	Import-PSSession -Session $PSSession -Type Cmdlet -Name Get-VM, Get-VMSnapshot, Restore-VMSnapshot, Start-VM, Stop-VM
	}
	
	$buttonStartVM_Click={
		#TODO: Place custom script here
	$VMtoStart=$textbox1.Text
	Start-VM -Name $VMtoStart
	}

	$buttonStopVM_Click={
		#TODO: Place custom script here
	$VMtoStop=$textbox1.Text
	Stop-VM -Name $VMtoStop
	}
	
	$buttonGetVM_Click={
	#TODO: Place custom script here
	$VMtoGetInfoOf=$textbox1.Text
	$state = Get-VM -Name $VMtoGetInfoOf | Select State
	Load-ListBox -ListBox $listbox1 -Items $state
	}

	$buttonRestoreVMSnapshot_Click={
		#TODO: Place custom script here
	$SnapshotName=$textbox2.text
	$VMName=$textbox1.text
	Restore-VMSnapshot -Name $SnapshotName -VMName $VMName -Confirm:$False
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
	#region Form
	#----------------------------------------------
	$MainForm.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($labelVMName)
	$MainForm.Controls.Add($textbox1)
	$MainForm.Controls.Add($buttonStartPSSession)
	$MainForm.Controls.Add($buttonStartVM)
	$MainForm.Controls.Add($buttonStopVM)
	$MainForm.COntrols.Add($buttonGetVM)
	$MainForm.Controls.Add($buttonGetSnapshot)
	$MainForm.Controls.Add($buttonRestoreVMSnapshot)
	$MainForm.Controls.Add($labelsnapshotname)
	$MainForm.Controls.Add($listbox1)
	$MainForm.Controls.Add($textbox2)
	$MainForm.ClientSize = '410, 250'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = "Hyper-V Manager"
	$MainForm.add_Load($OnLoadFormEvent)
	
	# labelVMName
	#
	$labelVMName.Location = '12, 8'
	$LabelVMName.Name = "labelVMName"
	$LabelVMName.Size = '170, 23'
	$LabelVMName.TabIndex = 10
	$LabelVMName.Text = "Virtual Machine Name:"
	#
	# textbox1
	#
	$textbox1.Location = '200, 8'
	$textbox1.Name = "textbox1"
	$textbox1.Size = '190, 20'
	$textbox1.TabIndex = 0
	$MainForm.ResumeLayout()	
	#
	# buttonStartPSSession
	#
	$buttonStartPSSession.Location = '12, 30'
	$buttonStartPSSession.Name = "buttonStartPSSession"
	$buttonStartPSSession.Size = '175, 23'
	$buttonStartPSSession.TabIndex = 9
	$buttonStartPSSession.Text = "Start PS Session"
	$buttonStartPSSession.UseVisualStyleBackColor = $True
	$buttonStartPSSession.add_Click($buttonStartPSSession_Click)
	#	
	# buttonGetSnapshot
	#
	$buttonGetSnapshot.Location = '12, 60'
	$buttonGetSnapshot.Name = "buttonGetSnapshot"
	$buttonGetSnapshot.Size = '175, 23'
	$buttonGetSnapshot.TabIndex = 9
	$buttonGetSnapshot.Text = "Get VM Snapshot"
	$buttonGetSnapshot.UseVisualStyleBackColor = $True
	$buttonGetSnapshot.add_Click($buttonGetSnapshot_Click)
	#
	# buttonStartVM
	#
	$buttonStartVM.Location = '12, 90'
	$buttonStartVM.Name = "buttonStartVM"
	$buttonStartVM.Size = '175, 23'
	$buttonStartVM.TabIndex = 9
	$buttonStartVM.Text = "Start VM"
	$buttonStartVM.UseVisualStyleBackColor = $True
	$buttonStartVM.add_Click($buttonStartVM_Click)
	#
	# buttonStopVM
	#
	$buttonStopVM.Location = '12, 120'
	$buttonStopVM.Name = "buttonStopVM"
	$buttonStopVM.Size = '175, 23'
	$buttonStopVM.TabIndex = 9
	$buttonStopVM.Text = "Stop VM"
	$buttonStopVM.UseVisualStyleBackColor = $True
	$buttonStopVM.add_Click($buttonStopVM_Click)
	#
	# buttonGetVM
	#
	$buttonGetVM.Location = '12, 150'
	$buttonGetVM.Name = "buttonGetVM"
	$buttonGetVM.Size = '175, 23'
	$buttonGetVM.TabIndex = 9
	$buttonGetVM.Text = "Get VM"
	$buttonGetVM.UseVisualStyleBackColor = $True
	$buttonGetVM.add_Click($buttonGetVM_Click)
	#
	# labelsnapshotname
	#
	$labelsnapshotname.Location = '12, 180'
	$labelsnapshotname.Name = "labelsnapshotname"
	$labelsnapshotname.Size = '170, 23'
	$labelsnapshotname.TabIndex = 10
	$labelsnapshotname.Text = "Snapshot to Restore:"
	#	
	# buttonRestoreVMSnapshot
	#
	$buttonRestoreVMSnapshot.Location = '12, 210'
	$buttonRestoreVMSnapshot.Name = "buttonRestoreVMSnapshot"
	$buttonRestoreVMSnapshot.Size = '175, 23'
	$buttonRestoreVMSnapshot.TabIndex = 9
	$buttonRestoreVMSnapshot.Text = "Restore VM Snapshot"
	$buttonRestoreVMSnapshot.UseVisualStyleBackColor = $True
	$buttonRestoreVMSnapshot.add_Click($buttonRestoreVMSnapshot_Click)
	#	
	# listbox1
	#
	$listbox1.FormattingEnabled = $True
	$listbox1.Location = '200, 30'
	$listbox1.Name = "listbox1"
	$listbox1.Size = '200, 130'
	$listbox1.TabIndex = 3
	#
	# textbox2
	#
	$textbox2.Location = '200, 210'
	$textbox2.Name = "textbox2"
	$textbox2.Size = '190, 20'
	$textbox2.TabIndex = 0
	$MainForm.ResumeLayout()	
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

Main ($CommandLine)
# SIG # Begin signature block
# MIIYGgYJKoZIhvcNAQcCoIIYCzCCGAcCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUTCd6EWCtfl8EMao9JyjAj6T
# SpWgghMDMIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
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
# BAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUpcS8o3qul2GwYA0ic7nMwPs2dBYwDQYJ
# KoZIhvcNAQEBBQAEggEAVKumZG5B6hXB3kqUaLqZuKWFZDEiYoiAebgWv+w2BXnj
# qTOaQE0TBP2Foj0ADPAlzh2Y5I0AT06aqSnWlYGkqTNVuFL5P4IRYBhYceRTCP0C
# 9seKPVl7lDjYyp82y46NAc2LvKw/PEAJ3dH1gyZvQ1mMZXHQ3kVZ+eoT9CNcVCcs
# o4Edv9dQe/Z0Aicfm6pluo9Mc4W/+qErX/4rlq2Wv/y0PkqfU3rOeI6yaN0QZFEx
# 2zsNjKUtFA63CHJjy0i1NG6+QXRWtkcUUZcrxlJlgJh0zl8P4+XBc5FzXycKb9kn
# pwdsKSSEsmkU54ZPA3eMRQh/vgh51EfIOraubMLdhaGCAgswggIHBgkqhkiG9w0B
# CQYxggH4MIIB9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRl
# YyBDb3Jwb3JhdGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBT
# ZXJ2aWNlcyBDQSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAY
# BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTA1MTQx
# MjU4NDVaMCMGCSqGSIb3DQEJBDEWBBS6llb7+yhD+H14TOgrQmOfK+Hm9jANBgkq
# hkiG9w0BAQEFAASCAQAc9vwmmpP12fLDeFA5CVTwCvsB9WLf2GNoAJo4dPKYz6JU
# eYJnvFog2Y+v7RT9hlqBqi8xwtCreVRK0hhbSCDVCHxoqJz64dCQBEOkd+JKoDW3
# cIg2wcN/NQ6UVP01OPDkEUwjLDO4EB+VPOiff9mpufqTUm512k0nywNvPf6H9mrz
# 2/OPgji/rZiQWd+fnyZdZxmxmc9BK3ltS8JHnAqW1+7Hwr5+DMV8jUhizpkAdh2a
# +rNKdlYwAohz4reczRk8qzVwlIEgVr8g3pB7d0HxHNfOH7iCGGOZDStFsQIljhT3
# IACz/zH4DkRzNB84/Wy59nCRddDdi/LcL6V0OC1h
# SIG # End signature block
