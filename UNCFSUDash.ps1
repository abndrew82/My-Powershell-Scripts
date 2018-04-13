param($i = $Global:i)
if ($i -eq $null){$i = 8080}
$i++

$Colors = @{
    BackgroundColor = "#FF252525"
    FontColor = "#FFFFFFFF"
}

$NavBarLinks = @((New-UDLink -Text "<i class='material-icons' style='display:inline;padding-right:5px'>favorite_border</i> PowerShell Pro Tools" -Url "https://poshtools.com/buy-powershell-pro-tools/"),
                 (New-UDLink -Text "<i class='material-icons' style='display:inline;padding-right:5px'>description</i> Documentation" -Url "https://adamdriscoll.gitbooks.io/powershell-tools-documentation/content/powershell-pro-tools-documentation/universal-dashboard.html"))

Start-UDDashboard -port $i -Content { 
    New-UDDashboard -NavbarLinks $NavBarLinks -Title "UNCFSU SCCM Stats" -NavBarColor '#FF1c1c1c' -NavBarFontColor "#FF55b3ff" -BackgroundColor "#FF333333" -FontColor "#FFFFFFF" -Content { 
        New-UDRow {

           
            New-UDColumn -Size 4 {
                New-UDCounter -Title "Total FSU Computers" -AutoRefresh -RefreshInterval 3 @Colors -Endpoint {
                    Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
                    Set-Location FS1:
                    $Comps = Get-CMDevice
                    $Comps.Count
                } 
            }

            New-UDColumn -Size 4 {
                New-UDCounter -Title "Total Applications" @colors -Endpoint {
                    Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
                    Set-Location FS1:                    
                    $Apps = Get-CMApplication | Select LocalizedDisplayName
                    $Apps.Count
                } 
            }
            
        }
        New-UDRow {
            
            
            New-UDColumn -Size 4 {
                New-UDChart -Title "Computers by OS" -Type Bar -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    $features = @();
                    Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
                    Set-Location FS1:                      
                    $Win10 = Get-CMDevice -CollectionName "Workstations | Windows 10"
                    $Win7 = Get-CMDevice -CollectionName "Workstations | Windows 7"
                    $Server2012 = Get-CMDevice -CollectionName "Servers | Windows 2012 and 2012 R2"
                    $Server2016 = Get-CMDevice -CollectionName "Servers | Windows 2016"
                    $AllComps = Get-CMDevice
                    
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 10"; "Total Win 10" = ($Win10.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 7"; "Total Win 7" = ($Win7.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Server 2016"; "All Server 2016" = ($Server2016.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Server 2012"; "All Server 2012" = ($Server2012.Count)}
                                       
                    $features| Out-UDChartData -LabelProperty "OperatingSystem" -Dataset @(
                    New-UDChartDataset -DataProperty "Total Win 10" -Label "Windows 10" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "Total Win 7" -Label "Windows 7" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                    New-UDChartDataset -DataProperty "All Server 2016" -Label "Server 2016" -BackgroundColor "#803AE8CE" -HoverBackgroundColor "#803AE8CE"
                    New-UDChartDataset -DataProperty "All Server 2012" -Label "Server 2012" -BackgroundColor "#803AE8CE" -HoverBackgroundColor "#803AE8CE"
                    
                    )
}
}
            New-UDColumn -Size 4 {
                New-UDChart -Title "Windows 10 Versions" -Type Bar -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    $features = @();
                    Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
                    Set-Location FS1:                      
                    $1507 = Get-CMDevice -CollectionName "Workstations | Windows 10 v1507"
                    $1511 = Get-CMDevice -CollectionName "Workstations | Windows 10 v1511"
                    $1607 = Get-CMDevice -CollectionName "Workstations | Windows 10 v1607"
                    $1703 = Get-CMDevice -CollectionName "Workstations | Windows 10 v1703"
                    $1709 = Get-CMDevice -CollectionName "Workstations | Windows 10 v1709"
                                        
                    $features += [PSCustomObject]@{ "OperatingSystem" = "1507"; "1507" = ($1507.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "1511"; "1511" = ($1511.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "1607"; "1607" = ($1607.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "1703"; "1703" = ($1703.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "1709"; "1709" = ($1709.Count)}
                                       
                    $features| Out-UDChartData -LabelProperty "OperatingSystem" -Dataset @(
                    New-UDChartDataset -DataProperty "1507" -Label "1507" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "1511" -Label "1511" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                    New-UDChartDataset -DataProperty "1607" -Label "1607" -BackgroundColor "#803AE8CE" -HoverBackgroundColor "#803AE8CE"
                    New-UDChartDataset -DataProperty "1703" -Label "1703" -BackgroundColor "#00125D" -HoverBackgroundColor "#00125D"
                    New-UDChartDataset -DataProperty "1709" -Label "1709" -BackgroundColor "#803AE8CE" -HoverBackgroundColor "#803AE8CE"
                    
                    )
}

            }


        }
            New-UDRow {
                        New-UDColumn -Size 4 {
                New-UDChart -Title "Computers by Manufacturer" -Type Bar -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    $features = @();
                    Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
                    Set-Location FS1:                      
                    $Dell = Get-CMDevice -CollectionName "All Dells"
                    $HP = Get-CMDevice -CollectionName "All HPs"
                    $Lenovo = Get-CMDevice -CollectionName "All Lenovos"
                    $Microsoft = Get-CMDevice -CollectionName "All Microsoft Corporation"
                                                           
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Dell"; "Dell" = ($Dell.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "HP"; "HP" = ($HP.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Lenovo"; "Lenovo" = ($Lenovo.Count)}
                    $features += [PSCustomObject]@{ "OperatingSystem" = "Microsoft"; "Microsoft" = ($Microsoft.Count)}
                    
                                       
                    $features| Out-UDChartData -LabelProperty "OperatingSystem" -Dataset @(
                    New-UDChartDataset -DataProperty "Dell" -Label "Dell" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "HP" -Label "HP" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                    New-UDChartDataset -DataProperty "Lenovo" -Label "Lenovo" -BackgroundColor "#803AE8CE" -HoverBackgroundColor "#803AE8CE"
                    New-UDChartDataset -DataProperty "Microsoft" -Label "Microsoft" -BackgroundColor "#00125D" -HoverBackgroundColor "#00125D"
                                        
                    )
}

            }
                        New-UDColumn -Size 4 {
New-UDGrid -Title "New Computers <24h" @Colors -Headers @("Name") -Properties @("Name") -AutoRefresh -RefreshInterval 20 -Endpoint {
                    Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
                    Set-Location FS1:
Get-CMDevice -CollectionName "Systems | Created Since 24h" | select Name| Out-UDGridData
}

}
}
            }        
    }
    
    
    


Start-Process http://localhost:$i