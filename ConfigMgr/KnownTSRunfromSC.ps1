# Log function - change path of logfile to suit your environment
function Write-Log {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [Alias("LogContent")]
        [string]$Message,
        
        # EDIT with your location for the local log file
        [Parameter(Mandatory=$false)]
        [Alias('LogPath')]
        [string]$Path='C:\ProgramData\UNCFSUOSUpgrade\Execute-OSUpgrade.log',
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("Error","Warn","Info")]
        [string]$Level="Info",
        
        [Parameter(Mandatory=$false)]
        [switch]$NoClobber
    )

    Begin
    {
        # Set VerbosePreference to Continue so that verbose messages are displayed.
        $VerbosePreference = 'Continue'
    }
    Process
    {
        
        # If the file already exists and NoClobber was specified, do not write to the log.
        if ((Test-Path $Path) -AND $NoClobber) {
            Write-Error "Log file $Path already exists, and you specified NoClobber. Either delete the file or specify a different name."
            Return
            }

        # If attempting to write to a log file in a folder/path that doesn't exist create the file including the path.
        elseif (!(Test-Path $Path)) {
            Write-Verbose "Creating $Path."
            $NewLogFile = New-Item $Path -Force -ItemType File
            }

        else {
            # Nothing to see here yet.
            }

        # Format Date for our Log File
        $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        # Write message to error, warning, or verbose pipeline and specify $LevelText
        switch ($Level) {
            'Error' {
                Write-Error $Message
                $LevelText = 'ERROR:'
                }
            'Warn' {
                Write-Warning $Message
                $LevelText = 'WARNING:'
                }
            'Info' {
                Write-Verbose $Message
                $LevelText = 'INFO:'
                }
            }
        
        # Write log entry to $Path
        "$FormattedDate $LevelText $Message" | Out-File -FilePath $Path -Append
    }
    End
    {
    }
}

# Name of the task sequence. Modify to suit your environment
$TaskSequenceName = "Windows 10 - Known Computer"

## Get the Software Center
try {
    $softwareCenter = New-Object -ComObject "UIResource.UIResourceMgr"
    Write-Log -Message "Successfully connected to the Software Center"
}
catch {
    Write-Log -Message "Cannot connect to the Software Center."
    exit 1
}

$TSReferencePackageIDs = @()
# Get the Task Sequence object
$taskSequence = $softwareCenter.GetAvailableApplications() | Where-Object { $_.PackageName -eq "$TaskSequenceName" }
        
if ($taskSequence) {
    $taskSequenceProgramID = $taskSequence.ID
    $taskSequencePackageID = $taskSequence.PackageID

    foreach ($i in $taskSequence.GetMemberPrograms()) {
         $TSReferencePackageIDs += $i.PackageID
    }
}
else {
    Write-Log -Message "Failed to retrieve the Windows 10 Known TS from the Software Center."
    exit 1    
}

# Execute the task sequence
$softwareCenter.ExecuteProgram($taskSequenceProgramID,$taskSequencePackageID,$true) | Out-Null

# Get current date
$Today = (Get-Date).ToString("dd/MM/yyyy")

# Write to registry if task sequence was successfully executed
if ($TaskSequence) {
    Write-Log -Level Info -Message "Task Sequence was successfully executed"
    $RegistryPath = "HKCU:\Software\UNCFSUOSD"
        if (-not(Test-Path -Path $RegistryPath)) {
            New-Item -Path $RegistryPath –Force
            }
        New-ItemProperty -Path $RegistryPath -Name "KnownHasRun" -Value 1 -PropertyType "String" -Force
        New-ItemProperty -Path $RegistryPath -Name "KnownRunDate" -Value $Today -PropertyType "String" -Force
    }
    
# Write to registry if task sequence failed to execute
else {
    Write-Log -Message "Task Sequence was not executed properly"
    $RegistryPath = "HKCU:\Software\UNCFSUOSD"
    if (-not(Test-Path -Path $RegistryPath)) {
        New-Item -Path $RegistryPath –Force  
        }
    New-ItemProperty -Path $RegistryPath -Name "KnownHasFailed" -Value 1 -PropertyType "String" -Force
    New-ItemProperty -Path $RegistryPath -Name "KnownFailedDate" -Value $Today -PropertyType "String" -Force
    exit 1
}