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
	$labelShareName = New-Object 'System.Windows.Forms.Label'
	$labelDays = New-Object 'System.Windows.Forms.Label'
    $labelChosenDate = New-Object 'System.Windows.Forms.Label'
	$labelDestination = New-Object 'System.Windows.Forms.Label'
    $textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$textbox2 = New-Object 'System.Windows.Forms.TextBox'
	$textbox3 = New-Object 'System.Windows.Forms.TextBox'
    $buttonCreatereport = New-Object 'System.Windows.Forms.Button'
    $Calendar = New-Object System.Windows.Forms.MonthCalendar
    $buttonBrowse = New-Object 'System.Windows.Forms.Button'
    $buttonMoveFiles = New-Object 'System.Windows.Forms.Button'
    $OKButton = New-Object 'System.Windows.Forms.Button'
    
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
# Show an Open Folder Dialog and return the directory selected by the user.
function Read-FolderBrowserDialog([string]$Message, [string]$InitialDirectory, [switch]$NoNewFolderButton)
{
    $browseForFolderOptions = 0
    if ($NoNewFolderButton) { $browseForFolderOptions += 512 }
 
    $app = New-Object -ComObject Shell.Application
    $folder = $app.BrowseForFolder(0, $Message, $browseForFolderOptions, $InitialDirectory)
    if ($folder) { $selectedDirectory = $folder.Self.Path } else { $selectedDirectory = '' }
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($app) > $null
    return $selectedDirectory
}

	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
   
	
	}
	#region Control Helper Functions

#Button Create Report Click#
	$buttonCreateReport_Click=
    {
	#TODO: Place custom script here
	$share = $Textbox1.Text
    #Write-Host $Share
	$Days = $Textbox2.Text
    #Write-Host $Days
    $Destination = $textbox3.Text
	$ReturnData = @()
	$ReportName = $Share -creplace '(?s)^.*\\', ''
	$Files = Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt $days}
    $Files.lastaccesstime 
	ForEach ($File in $Files)
	{
	 If ($ReportName -eq "$null")
	   {
	    $ReportName = "UNCFSUShareDefault"
	   }
	 If ($file.Length -ge "1024")
	   {
	    $filesize = $file.Length/1MB
	   }
	$fileandsize = $file.FullName + "|" + $file.LastAccessTime + "|" + $filesize
    Out-File $Destination\$ReportName.txt -InputObject $fileandsize -Append
	$ReturnData += New-Object PSObject -Property @{File=$File; LastAccessTime=$File.LastAccessTime; FileSize=$filesize; FullPath=$file.FullName}
	}
    $ReturnData | Select File, LastAccessTime, FileSize, FullPath| Sort-Object FileSize -Descending | Out-GridView
	}

#Button Browse Click#
	$buttonBrowse_Click=
    {
	#TODO: Place custom script here
    $directoryPath = Read-FolderBrowserDialog -Message "Please select a directory" -NoNewFolderButton
    if (![string]::IsNullOrEmpty($directoryPath)) {  }
    else { "You did not select a directory." }
    $textbox3.Text = $directoryPath
    }
	
#Button Move Files Click#
	$buttonMoveFiles_Click=
    {
	#TODO: Place custom script here
    $share = $Textbox1.Text
    $Days = $Textbox2.Text
    $Destination = $textbox3.Text
    Get-ChildItem -Path $Share -Recurse | Where-Object {$_.LastAccessTime -lt (Get-Date).AddDays(-$Days)} | Move-Item -Destination $Destination
	}
    #
#OK Button Click
    $OKButton_Click=
    {
	#TODO: Place custom script here
    #$date = $calendar.SelectionStart
    $textbox2.Text = $calendar.SelectionStart
    #$textbox2.Text = $($date.ToShortDateString())
	}
#
	# --End User Generated Script--
	
	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($labelShareName)
	$MainForm.Controls.Add($labelDays)
    $MainForm.Controls.Add($labelChosenDate)
	$MainForm.Controls.Add($labelDestination)
	$MainForm.Controls.Add($buttonCreatereport)
    $MainForm.Controls.Add($buttonBrowse)
    $MainForm.Controls.Add($buttonMoveFiles)
    $MainForm.Controls.Add($Calendar)
    $MainForm.Controls.Add($textbox1)
	$MainForm.Controls.Add($textbox2)
	$MainForm.Controls.Add($textbox3)
    $MainForm.Controls.Add($OKButton)
    $MainForm.ClientSize = '600, 350'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
    $MainForm.Text = "FSU Share Reporter"
	$MainForm.add_Load($OnLoadFormEvent)
	#
	# labelShareName
	#
	$labelShareName.Location = '20, 10'
    $labelShareNameFont = New-Object System.Drawing.Font("Times New Roman",18,[System.Drawing.FontStyle]::Bold)
	$labelShareName.Name = "labelShareName"
    $labelShareName.Font = $labelShareNameFont
	$labelShareName.Size = '150, 30'
	$labelShareName.TabIndex = 10
	$labelShareName.Text = "Share Name"
	#	
	# labelDays
	#
	$labelDays.Location = '20, 50'
    $labelDaysFont = New-Object System.Drawing.Font("Times New Roman",18,[System.Drawing.FontStyle]::Bold)
	$labelDays.Name = "labelDays"
    $labelDays.Font = $labelDaysFont
	$labelDays.Size = '60, 30'
	$labelDays.TabIndex = 10
	$labelDays.Text = "Date"
	#
	# labelDestination
	#
	$labelDestination.Location = '20, 220'
    $labelDestinationFont = New-Object System.Drawing.Font("Times New Roman",18,[System.Drawing.FontStyle]::Bold)
	$labelDestination.Name = "labelDestination"
    $labelDestination.Font = $labelDestinationFont
	$labelDestination.Size = '150, 30'
	$labelDestination.TabIndex = 10
	$labelDestination.Text = "Destination"
	#	
	# textbox1
	#
	$textbox1.Location = '180, 10'
    $Textbox1Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
    $Textbox1.Multiline = $True
    $textbox1.Font = $Textbox1Font
	$textbox1.Name = "textbox1"
	$textbox1.Size = '350, 25'
	$textbox1.TabIndex = 0
	$MainForm.ResumeLayout()
	#	
	# textbox2
	#
	$textbox2.Location = '440, 150'
    $Textbox2Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
    $Textbox2.Multiline = $True
    $textbox2.Font = $Textbox2Font
	$textbox2.Name = "textbox2"
	$textbox2.Size = '150, 25'
    $textbox2.ReadOnly = $True
	$textbox2.TabIndex = 0
	$MainForm.ResumeLayout()
	#	
	# textbox3
	#
	$textbox3.Location = '180, 220'
    $Textbox3Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
    $Textbox3.Multiline = $True
    $textbox3.Font = $Textbox3Font
	$textbox3.Name = "textbox3"
	$textbox3.Size = '250, 25'
	$textbox3.TabIndex = 0
    $textbox3.ReadOnly = $true
	$MainForm.ResumeLayout()
	#		
	# Button Generate Report
	#
	$buttonCreatereport.Location = '50, 270'
	$buttonCreatereport.Name = "buttonGetInfo"
    $buttoncreatereportFont = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Bold)
	$buttonCreatereport.Size = '200, 35'
	$buttonCreatereport.TabIndex = 9
    $buttonCreatereport.Font = $buttoncreatereportFont
	$buttonCreatereport.Text = "Generate Report"
	$buttonCreatereport.UseVisualStyleBackColor = $True
	$buttonCreatereport.add_Click($buttonCreateReport_Click)
	#	
	# Button Browse
	#
	$buttonBrowse.Location = '440, 220'
	$buttonBrowse.Name = "buttonBrowse"
    $buttonBrowseFont = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Bold)
	$buttonBrowse.Size = '135, 25'
	$buttonBrowse.TabIndex = 9
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonBrowseFont
	$buttonBrowse.UseVisualStyleBackColor = $True
	$buttonBrowse.add_Click($buttonBrowse_Click)
	#	
	# Button Move Files
	#
	$buttonMoveFiles.Location = '325, 270'
	$buttonMoveFiles.Name = "buttonMoveFiles"
    $buttonMoveFilesFont = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Bold)
	$buttonMoveFiles.Size = '200, 35'
	$buttonMoveFiles.TabIndex = 9
    $buttonMoveFiles.Font = $buttonMoveFilesFont
    $buttonMoveFiles.Text = "Move Files"
	$buttonMoveFiles.UseVisualStyleBackColor = $True
	$buttonMoveFiles.add_Click($buttonMoveFiles_Click)
	#	
    # Calendar
    #
    $Calendar.Location = '180, 50'
    $Calendar.ShowTodayCircle = $false
    $Calendar.MaxSelectionCount = 1
    #
    #OK Button
    #
    $OKButton.Location = '440, 180'
    $OKButtonFont = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Bold)
    $OKButton.Size = '135, 25'
    $OKButton.Font = $OKButtonFont
    $OKButton.Text = "Select Date"
    $OKButton.add_Click($OKButton_Click)
    #
    #
    #Label Chosen Date
    #
    $labelChosenDate.Location = '440, 50'
    $labelChosenDateFont = New-Object System.Drawing.Font("Times New Roman",20,[System.Drawing.FontStyle]::Bold)
    $labelChosenDate.Size = '150, 90'
    #$labelChosenDate.BackColor = 'Blue'
    $labelChosenDate.Font = $labelChosenDateFont
    $labelChosenDate.Text = " You Chose" + "`n" + "     Date:"
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