$Array = @() #Makes an array, or a collection to hold all the object of the same fields

$serverlistpath = read-host ‘Please provide the full path of the serverlist file, like c:\server.txt’ #Input the server list

$ServerList = get-content -Path $serverlistpath #get the server list

foreach ($ServerName in $ServerList)

{

       $Path = “\\$serverName\Software“ #Folder path to scan

       $FolderSize = Get-ChildItem $path -recurse | Measure-Object -Sum length  #Get folder size

       $FolderSizebytes = “{0:N}” -f $FolderSize.sum #Format size

       $FolderSizeMB = $FolderSize.sum/1MB #convert size to MB

       $FolderSizeMB = “{0:N2}” -f $FolderSizeMB #Format MB size to 2 digital after point

       $FinalResult = New-Object PSObject #Prepare csv object

       Add-Member -inputObject $FinalResult -memberType NoteProperty -name “ServerName” -value $ServerName #Insert ServerName to csv

       Add-Member -inputObject $FinalResult -memberType NoteProperty -name “FolderSize(bytes)” -value $FolderSizebytes #Insert FolderSize(bytes) to csv

       Add-Member -inputObject $FinalResult -memberType NoteProperty -name “FolderSize(MB)” -value $FolderSizeMB #Insert FolderSize(MB) to csv

       $Array += $FinalResult #Add result to array

       $FinalResult

}

$OutPut = $Array

$OutPut | Export-Csv -noTypeInformation -path C:\Result.csv