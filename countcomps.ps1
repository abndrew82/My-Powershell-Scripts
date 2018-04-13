$Comps = Get-ADComputer -Filter * -SearchBase "DC=uncfsu,DC=edu" -Properties CN | Select -ExpandProperty CN

try{
    ForEach ($comp in $Comps){
    $computer = Get-ADComputer -Identity $Comp -erroraction stop
    $properties = @{Computer = $comp
                    CompStatus = $computer.enabled
                    CurrentOU = $computer.distinguishedname}
    }}
catch {
    $properties = @{Computer = $comp
                    CompStatus = $null
                    CurrentOU = $null}
}
finally{
    $obj = New-Object -TypeName psobject -Property $properties
    Write-Output $obj
}


$obj.Count