<#
.SYNOPSIS
    Creates the mandatory and self-service collections for an NCSU Software Package
.DESCRIPTION
    For a given software group name this script will create the mandatory and self-service collections.
    The collections will have the following properties/settings:

    - Limited by collection of the same name as the department prefix (included in software group name)
    - Queries an Active Directory group of the same name (-SS appended for self-service) to populate members
    - Scheduled refresh every two hours
    
    Script relies on the SCCM PowerShell module that comes with the SCCM 2012 Console and it must be run
    from an x86 PowerShell environment.
.PARAMETER softwareGroupName
    A group name that follows the <UNIT>-<EX/SW/FW>-<Vendor>-<Title>-<Version> naming convention
.PARAMETER licenseRequired
    A Yes/No parameter - for an EX package, if Yes is specified the script will append a group of the 
    same name as the softwareGroupName with 'SW' in place of 'EX' to account for the eventual promotion
    of the package to production.  Likewise, if No is specified the script will append a group of the
    same name as the softwareGroupName with 'SW' in place of 'EX' to account for the eventual promotion
    of the package to production.
.EXAMPLE
    create_sccm_software_package_collections.ps1 -softwareGroupName 'TEX-EX-Google-Google Drive-1.8.4' -licenseRequired No
.LINK
    How I found the 'Software Package Collections' folder container ID:
    http://social.technet.microsoft.com/Forums/en-US/configmgrsdk/thread/787a84c9-79e0-41a3-8f85-2b2a0fa3b337/
    
    Fix needed to allow a 'RefreshSchedule' to be added to the collection:
    http://support.microsoft.com/kb/2817245

    Move-CMObject Code:
    http://cm12sdk.net/?p=1006
.NOTES
    Author: Ryan Leap - srleap@ncsu.edu
    Requires: SCCM 2012 Console PowerShell Module
    
    SCCM SP1 Cumulative Update 1 required for this script to work properly (apply Refresh Schedule to
    a Collection).  To apply this to an admin machine with the SCCM Console extract the contents of
    the CU1 package and run:
    msiexec /p configmgr2012adminui-sp1-kb2817245-i386.msp

    WMI SMS Provider:
    Get-WmiObject -Namespace "root/SMS" -List -ComputerName OIT200SCCM-SS
    Get-WmiObject -Namespace "ROOT\SMS\SITE_WUF" -Query "select name, containernodeid from SMS_ObjectContainerNode" -ComputerName OIT200SCCM-SS

    Enhancements/Bug Fixes - 06/17/2013
    1.  Tests if SCCM PS module (file) is on system, issues error message if missing.
    2.  Support for 32 bit and 64 bit paths to SCCM PS Module
    3.  Tests if SCCM PS module is already loaded before attempting to import
    4.  Saves Current working directory and restores session to that location after script completes
    5.  Includes 'EX' in collection query even with SW or FW is supplied for the softwareGroupName

#>


# Set-StrictMode -Version latest

Param (
       [parameter(Mandatory=$True,HelpMessage='Enter a software group name as follows: <UNIT>-<EX/SW/FW>-<Vendor>-<Title>-<Version>')]
       [string]$softwareGroupName = '',
       [parameter(Mandatory=$True,HelpMessage='Does this software require a license (Yes/No)?')]
       [string]$licenseRequired = 'No'
       )

#CONSTANTS
$limitingCollection = 'COEDEAN'
$limitingCollectionID = 'WUF0005C'

#------------------------------------------------------------------------------------------
#
# Code to move an SCCM object swiped from here:
#
#   http://cm12sdk.net/?p=1006
#
#------------------------------------------------------------------------------------------
Function Move-CMObject
{
    [CmdLetBinding()]
    Param(
    [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")]
              $SiteCode,
    [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name")]
              $SiteServer,
    [Parameter(Mandatory=$True,HelpMessage="Please Enter Object ID")]
              [ARRAY]$ObjectID,
    [Parameter(Mandatory=$True,HelpMessage="Please Enter current folder ID")]
              [uint32]$CurrentFolderID,
    [Parameter(Mandatory=$True,HelpMessage="Please Enter target folder ID")]
              [uint32]$TargetFolderID,
    [Parameter(Mandatory=$True,HelpMessage="Please Enter object type ID")]
              [uint32]$ObjectTypeID              
        )
    
    Try{
        Invoke-WmiMethod -Namespace "Root\SMS\Site_$SiteCode" -Class SMS_objectContainerItem -Name MoveMembers -ArgumentList $CurrentFolderID,$ObjectID,$ObjectTypeID,$TargetFolderID -ComputerName $SiteServer -ErrorAction STOP
    }
    Catch{
        $_.Exception.Message
    }  
                                                          
}

#-----------------------------------------------------------------------------------------
#
# Main Script
#
#-----------------------------------------------------------------------------------------

# Perform some string validation against the group name and the license required parameter
$licenseRequired = $licenseRequired.ToLower()
$softwareGroupName = $softwareGroupName.Trim('''')
$akaSoftwareGroupName = $softwareGroupName
$parsedSoftwareGroupName = $softwareGroupName.Split('-')

If ($parsedSoftwareGroupName.Length -ne 5) {
  Write-Host('')
  Write-Host 'Software group name must adhere to the following naming convention:' -ForegroundColor Red
  Write-Host '<UNIT>-<EX/SW/FW>-<Vendor>-<Title>-<Version> where UNIT is a three-letter departmental prefix.'
}
ElseIf ( ($parsedSoftwareGroupName[0].Length -lt 2) -or 
         (!($parsedSoftwareGroupName[0] -match "^[a-z\s]+$")) ) {
  Write-Host('')
  Write-Host "Unit (department) name malformed: " $parsedSoftwareGroupName[0] -ForegroundColor Red
}
ElseIf ( ($parsedSoftwareGroupName[1].CompareTo('EX') -ne 0) -and
         ($parsedSoftwareGroupName[1].CompareTo('FW') -ne 0) -and
         ($parsedSoftwareGroupName[1].CompareTo('SW') -ne 0) ) {
  Write-Host('')
  Write-Host "Software status not equal to EX, FW, or SW: " $parsedSoftwareGroupName[1] -ForegroundColor Red
}
Else {
  # Code relies on the SCCM PowerShell module distributed with the SCCM Console  
  [string] $ccmModuleName = 'ConfigurationManager'
  [string] $ccmModulePath = "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\$ccmModuleName.psd1"
  [boolean] $ccmModuleAvailable = Test-Path -Path $ccmModulePath -PathType Leaf
  If ($ccmModuleAvailable -eq $false) {
    $ccmModulePath = "C:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\$ccmModuleName.psd1"
    $ccmModuleAvailable = Test-Path -Path $ccmModulePath -PathType Leaf
  }
  If ($ccmModuleAvailable -eq $false) {
    Write-Host('')
    Write-Host 'SCCM PowerShell module not available for import!' -ForegroundColor Red
  }
  Else {
    # Load the SCCM PowerShell module as needed
    If (-not (Get-Module -Name $ccmModuleName)) {
      Import-Module $ccmModulePath
    }

    # Save the current working directory and change to the SCCM Drive
    Push-Location -Path WUF:

    # This should be the departmental root like 'OIT' or 'COE' or 'TEX'
    # Altered for COEDEAN use
    If ($limitingCollection -ne "COEDEAN") {
        Write-Error "This script is intended for COEDEAN and is special purposed.  If you see this error please retrieve the correct provisioning script."
    }

    # Refresh schedule for software collections should be every two hours
    $startDate = Get-Date -Format g
    $collectionSchedule = New-CMSchedule -Start $startDate -RecurCount 2 -RecurInterval Hours
    [string] $collectionComment = 'Collection created via PowerShell Script. -sRL'

    # The software package collections belong in the 'Software Package Collections' folder
    [int] $collectionContainerId = 16777253
    [string] $siteServer = "OIT200SCCM-SS"
  
    # Build promoted name (EX -> FW or EX -> SW) into collection query
    If ($parsedSoftwareGroupName[1].CompareTo('EX') -eq 0) {
      If ( ($licenseRequired.CompareTo('yes') -eq 0) -or ($licenseRequired.CompareTo('y') -eq 0) ) {
        $akaSoftwareGroupName = $akaSoftwareGroupName.Replace('-EX-', '-SW-')
      }
      Else {
        $akaSoftwareGroupName = $akaSoftwareGroupName.Replace('-EX-', '-FW-')
      }
    }
    # They supplied FW or SW for the collection name, so go ahead and query an EX group too just in case
    Else {
        $akaSoftwareGroupName = $akaSoftwareGroupName.Replace('-SW-', '-EX-')
        $akaSoftwareGroupName = $akaSoftwareGroupName.Replace('-FW-', '-EX-')
    }
  
    # Create the Mandatory Collection
    [string] $queryName = 'Mandatory'
    [string] $queryADGroup = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemGroupName = ""WOLFTECH\\$softwareGroupName"" or SMS_R_System.SystemGroupName = ""WOLFTECH\\$akaSoftwareGroupName"""
    $deviceCollection = New-CMDeviceCollection -Comment $collectionComment -RefreshSchedule $collectionSchedule -RefreshType Periodic -LimitingCollectionId $limitingCollectionID -Name $softwareGroupName
    Add-CMDeviceCollectionQueryMembershipRule -CollectionId $deviceCollection.CollectionID -RuleName $queryName -QueryExpression $queryADGroup
    Move-CMObject -SiteCode WUF -SiteServer $siteServer -ObjectID $deviceCollection.CollectionID -CurrentFolderID 0 -TargetFolderID $collectionContainerId -ObjectTypeID 5000
    Write-Host('')
    Write-Host "Mandatory collection created: $softwareGroupName"
    Write-Host('')
    # Create the Self-Service Collection
    $queryName = 'Self-Service'
    $queryADGroup = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemGroupName = ""WOLFTECH\\$softwareGroupName-SS"" or SMS_R_System.SystemGroupName = ""WOLFTECH\\$akaSoftwareGroupName-SS"""
    $deviceCollection = New-CMDeviceCollection -Comment $collectionComment -RefreshSchedule $collectionSchedule -RefreshType Periodic -LimitingCollectionId $limitingCollectionID -Name "$softwareGroupName-SS"
    Add-CMDeviceCollectionQueryMembershipRule -CollectionId $deviceCollection.CollectionID -RuleName $queryName -QueryExpression $queryADGroup
    Move-CMObject -SiteCode WUF -SiteServer $siteServer -ObjectID $deviceCollection.CollectionID -CurrentFolderID 0 -TargetFolderID $collectionContainerId -ObjectTypeID 5000
    Write-Host('')
    Write-Host "Self-Service collection created: $softwareGroupName-SS"

    # Return the script caller to the orignal working drive/location
    Pop-Location
  }
}

# SIG # Begin signature block
# MIIYGgYJKoZIhvcNAQcCoIIYCzCCGAcCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUP2OtvGvoeMQs1t0iK4Tii5sj
# rmGgghMDMIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
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
# ge8VYVAiMIIFTzCCBDegAwIBAgIKH6hNhQAAAAHDmjANBgkqhkiG9w0BAQUFADCB
# wTELMAkGA1UEBhMCVVMxFzAVBgNVBAgTDk5vcnRoIENhcm9saW5hMRAwDgYDVQQH
# EwdSYWxlaWdoMSgwJgYDVQQKEx9Ob3J0aCBDYXJvbGluYSBTdGF0ZSBVbml2ZXJz
# aXR5MTYwNAYDVQQDEy1Ob3J0aCBDYXJvbGluYSBTdGF0ZSBVbml2ZXJzaXR5IEVu
# dGVycHJpc2UgQ0ExJTAjBgkqhkiG9w0BCQEWFnNlY3VyaXR5QGhlbHAubmNzdS5l
# ZHUwHhcNMTMwMjEyMjI0NDE3WhcNMTQwMjEyMjI0NDE3WjAXMRUwEwYDVQQDEwxz
# cmxlYXAuYWRtaW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCNu+8U
# R1PWZ+Mw8YWDLT2tHHYQ2YaSVJK6Th9ES6s4RInIKTINcQE1+yVsZav5Z8CmLGiV
# rqANVye8jFJ7//pXqHE8b/KTWTVNUO0kS/jvI7W7xZmc8YvMk7w+AbNodlTLhvDh
# lDIuBY+wg4dY03Qb67xU2+PqlG4zj3UZ/py3OCRffWF2CXv/0Pf3OOBeak79sy8t
# eO2o9HhhvOFS/EsUYwltVjUnoHoNzlIwEBZZYB0yiJTUlQXGEQSexVFVQFjCREjw
# qZyAPbg4pCxvK6vXfk8w36lgL3pmqtHA1Ca9cGp/r8xPi4Oijo2+zBEMRSWHlfPq
# anRnM+uELFbUs8UpAgMBAAGjggHwMIIB7DA9BgkrBgEEAYI3FQcEMDAuBiYrBgEE
# AYI3FQiC9N4YhP/3JO2HFoTbplyH4oNlgUmHrOFWgdPAKwIBZAIBAzATBgNVHSUE
# DDAKBggrBgEFBQcDAzAOBgNVHQ8BAf8EBAMCB4AwGwYJKwYBBAGCNxUKBA4wDDAK
# BggrBgEFBQcDAzAdBgNVHQ4EFgQUrtLNpEQxj25uiBI94K3T7t+my48wHwYDVR0j
# BBgwFoAUoZcmJ8KSHVn+NR8EFkrMBMgMcYowVQYDVR0fBE4wTDBKoEigRoZEaHR0
# cDovL3d3dy5uY3N1LmVkdS9jcmwvTm9ydGhDYXJvbGluYVN0YXRlVW5pdmVyc2l0
# eUVudGVycHJpc2VDQS5jcmwwgZMGCCsGAQUFBwEBBIGGMIGDMFAGCCsGAQUFBzAC
# hkRodHRwOi8vd3d3Lm5jc3UuZWR1L2NybC9Ob3J0aENhcm9saW5hU3RhdGVVbml2
# ZXJzaXR5RW50ZXJwcmlzZUNBLmNydDAvBggrBgEFBQcwAYYjaHR0cDovL3d0LW9j
# c3AtMDAub2l0Lm5jc3UuZWR1L29jc3AwPAYDVR0RBDUwM6AxBgorBgEEAYI3FAID
# oCMMIXNybGVhcC5hZG1pbkB3b2xmdGVjaC5hZC5uY3N1LmVkdTANBgkqhkiG9w0B
# AQUFAAOCAQEAPvQTTNtYckyceYBMeauFMFbbnnSFS9O8+wIhSaTvjbcZJ24c6pw3
# 6YE88lrOgSPWM9LeBlnUC1wA/X9Iuvriho4HEWN/mTCbqKcGWps17FIyyiiyjLO9
# JdrtqLFeZ/97G6EvN5ROtzp0KGb3r1tBb6nldnL4lO49p+fEUfcog1vlmLkzs7nv
# imG3RoGiEU+GbyJpxePL4GcMYUQnWXlsJ78gVGGJmzy+Zs5Fo2z5tQzRk0XNJc4L
# J6M7W7m+Eb58w7BXqsO1FZ5mbpuQYHpBTWVXsxNQfXSOYTDNhIVZppe0yIo3weRR
# WD+l2+we6rOqNdF9iVEkxJ3eH+OlTqIkmTGCBIEwggR9AgEBMIHQMIHBMQswCQYD
# VQQGEwJVUzEXMBUGA1UECBMOTm9ydGggQ2Fyb2xpbmExEDAOBgNVBAcTB1JhbGVp
# Z2gxKDAmBgNVBAoTH05vcnRoIENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkxNjA0
# BgNVBAMTLU5vcnRoIENhcm9saW5hIFN0YXRlIFVuaXZlcnNpdHkgRW50ZXJwcmlz
# ZSBDQTElMCMGCSqGSIb3DQEJARYWc2VjdXJpdHlAaGVscC5uY3N1LmVkdQIKH6hN
# hQAAAAHDmjAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZ
# BgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYB
# BAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUO6IepanlI4IYLkPSTRnlE2X7Xo0wDQYJ
# KoZIhvcNAQEBBQAEggEAJorqAqkNnE5OypMrCJE2pxVRcQIlRamJwY/5Qf/bUVsy
# zCd9yY59rLIf0qtoAcVbgP2B0Y98IteIriqDlMLlnu4YpoCLewXh1a4l9ATNfDnN
# 79T0DmOL7pi/D4KQ/I3OnKwTTZ0kCLHq7TUv1NP/VATvV3RmU3QIFPuvBQis/dBa
# GkUU5o7zInCcPNAoXIF6lMn9K2R1BntAf7E6ZY+ftWRfEgSZoNUsv3vCXckKzkJt
# g7TxJbIfAxVN6pP4A/m4xV+2F+d8Okq0v6KSi9eJibHt0aTf7MTW6SKEM4mG3EKF
# PK8yCIKER+TE2rLmfc2BzGb6RRnUQZFFFL6ut/mDWaGCAgswggIHBgkqhkiG9w0B
# CQYxggH4MIIB9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRl
# YyBDb3Jwb3JhdGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBT
# ZXJ2aWNlcyBDQSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAY
# BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMzA2MjAx
# MzAyMTdaMCMGCSqGSIb3DQEJBDEWBBTctpOJ+3Cfj6EJ2KN4mndftlOTuzANBgkq
# hkiG9w0BAQEFAASCAQCau+vLlZnuo5hXKS6P7Fet0sztdaDLrl/eyC+49RiP2Eiz
# h+tzK7rpJSCL0ZPdDYrWcQyqEps5CuSoaqieza1RW6RdECNSj7S2s414cSjkI33+
# 6/URN66bSl9pjASFzmf0/9Rpb+Ar/3Xlw/bJhkLL575iHhLLz+dhNr1ifa1gQnTZ
# dIL4FwC58nbD1HWibqExiedyxRZDHYY1z7pAyF5T79+NMomIELHh1uZOaXyWaQR3
# Ux6Trobyx64Uto7SQfFiU6TKm9mzy8s8s6DqdjK+Sq8rEO4P2Y+VNZzAhdjGIegO
# f5Z31yhqBLwZAFqnbNz+SeFGTsa80BzBNnLpV+7D
# SIG # End signature block
