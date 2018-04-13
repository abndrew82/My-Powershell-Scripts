
    # bring up an error prompt with OK button
    function dumbPrompt {
        param ($PromptText = $(throw “You must pass a text string.”))
        $a = new-object -comobject wscript.shell
        $b = $a.popup($PromptText,0,“Error”,0)
    }
    # authenticates PSCredentials to a domain.
    function auth-AdCreds {
        param ($cred)
        # make sure a PSCredential was passed.
        if ($cred -isnot [System.Management.Automation.PSCredential]) {
            write-host -f Red ‘ERROR: You must pass a PSCredential (i.e. Get-Credential).’
            return $False
        }
        # if the username is entered with no domain sufficx\prefix a leading \ is put in the username that needs to be cleared
        $username = $cred.username.trimstart(‘\’)
        $password = $cred.GetNetworkCredential().password
        # Get current domain using logged-on user’s credentials
        # Two options here. Specify the path to a specific domain controller. Handy if you system is not a member of the domain authenticating to.,
        #$CurrentDomain = ‘LDAP:///DC=domain,DC=corp’
        # Second option, use the domain of the local computer
        $CurrentDomain = ‘LDAP://’+([ADSI]“”).distinguishedName
        $dom = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain,$UserName,$Password)
        $res =  $dom.name
        if ($res -eq $null) {
            return $False
        }   else {
            return $True
        }
    }
    ## Get credentials and validate them ##
    # $count used to count the number of failed authentication attempts (3 max)
    $count = 0
    do {
        # $clear used to validate success or failure
        $clear = $true
        # prompt for the password of the current user
        $creds = get-credential -credential “$ENV:username” -EA SilentlyContinue
        # bypasses the checks if cancel/escape is pressed
        if ($creds) {
            write-host -f Green “Validating credentials…”
            # [optional] some programs authenticate without domain suffix/prefix. You cannot modify the credential username so you can prompt and resubmit if they are provided.
            # Another other option would be to ignore this, copy the username to a string var, then modify the string if you don’t have to pass a PSCredential.
            if ($creds.username.toUpper().startswith(‘DOMAIN\‘) -or $creds.username.toLower().endswith(‘@domain.corp‘)) {
                $clear = $false
                dumbPrompt ‘You cannot use “DOMAIN\” or “@domain.corp” in the username. Please use your s- account with no domain specified.‘
                Remove-Variable creds
            }
            # perform the actual authentication check if $clear is true
            if ($clear) {
                $clear = auth-AdCreds $creds
                # retry is authentication fails
                if (!$clear) {
                    dumbPrompt ‘Failed to authenticate the credentials to the UNCFSU.EDU domain. Please try again.‘
                    Remove-Variable creds
                    $count++
                }
            }
        }
    } until ($clear -or $count -ge 3)
    # exit if user selected cancel/escape
    if (!$creds) {
        dumbPrompt ‘Valid credentials must be supplied to continue. Exiting the program.‘
        sleep 5
        #exit
    }
    # exit if the three try limit was met
    if ($count -ge 3) {
        dumbPrompt ‘You have reached the three failure limit. Please make sure you are entering the correct password and that your account is not locked.’
        sleep 5
        #exit
    }
