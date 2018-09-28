    param (
    [parameter(Mandatory=$true)]
    [string]$CompName = ''
    )
    $Technician = Get-WmiObject -ComputerName $CompName -Namespace Root\ITLocal -Class OSD_Info | Select -ExpandProperty Tech
    $DateImaged = Get-WmiObject -ComputerName $CompName -Namespace Root\ITLocal -Class OSD_Info | Select -ExpandProperty InstallationDate
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="FSU Info" 
    $MyForm.Size = New-Object System.Drawing.Size(300,150) 
    $Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Italic)

 
        $mLabelImagedBy = New-Object System.Windows.Forms.Label 
                $mLabelImagedBy.Text="Imaged By:" 
                $mLabelImagedBy.Font = $Font
                $mLabelImagedBy.Top="10" 
                $mLabelImagedBy.Left="4" 
                $mLabelImagedBy.Anchor="Left,Top" 
        $mLabelImagedBy.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mLabelImagedBy) 
         
 
        $mLabelTech = New-Object System.Windows.Forms.Label 
                $mLabelTech.Text= $Technician 
                $mLabelTech.Font = $Font
                $mLabelTech.Top="10"
                $mLabelTech.Left="115" 
                $mLabelTech.Anchor="Left,Top" 
        $mLabelTech.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mLabelTech) 

        $mLabeldate = New-Object System.Windows.Forms.Label 
                $mLabeldate.Text= "Date Imaged:"
                $mLabeldate.Font = $Font
                $mLabeldate.Top="50"
                $mLabeldate.Left="4" 
                $mLabeldate.Anchor="Left,Top" 
        $mLabeldate.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mLabeldate) 

        $mLabeldate2 = New-Object System.Windows.Forms.Label 
                $mLabeldate2.Text= $DateImaged
                $mLabeldate2.Font = $Font
                $mLabeldate2.Top="50"
                $mLabeldate2.Left="115" 
                $mLabeldate2.Anchor="Left,Top" 
        $mLabeldate2.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mLabeldate2) 
                
        
        $MyForm.ShowDialog()
        
        
        