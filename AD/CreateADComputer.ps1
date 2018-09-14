# V3.0
# Changes: 
#    No longer relies on Quest AD Snap in
#    No longer uses the kludgey Test-XADObject to validate the existence of computers in AD

import-module activedirectory

import-csv "list.csv" | foreach-object{ #imports CSV containing Name and MAC headings

    $name = $_.Name
    $MAC = $_.Mac   
    
    $CheckExists = get-adobject -Filter {(ObjectClass -eq "computer") -and (Name -eq $name)}  #Will be $NULL if this is a new computer
    
        
    if ($CheckExists -eq $NULL){
        [guid]$nbGUID = "00000000-0000-0000-0000-$MAC"  #casts 0s + MAC into a GUID, which is required for the netbootGUID property
        new-adcomputer -Name $name -SamAccountName $name -OtherAttributes @{'netbootGUID'=$nbGUID} -Path 'OU=Temp-415,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu'  
        write-host $name " - " $nbGUID
      }
      else {
        write-host "$name already exists."
        }
        
}