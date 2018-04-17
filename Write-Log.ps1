Function Write-Log {
    [CmdletBinding()]
    param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$GUID,
    
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ComputerName,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Application,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$User,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$RequestState,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Comments,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$LastModifiedBy,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$LastModifiedDate,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('Information','Warning','Error')]
    [string]$Severity = 'Information'
    )

    [pscustomobject]@{
        Time = (Get-Date -f g)
        GUID = $GUID
        Computer = $ComputerName
        Application = $Application
        User = $User
        Status = $RequestState
        Comments = $Comments
        ModifiedBy = $LastModifiedBy
        ModifiedDate = $LastModifiedDate
        Severity = $Severity
    } | Export-Csv -Path "c:\Windows\Temp\AppRequest.csv" -Append -NoTypeInformation
}