 param (
    [string]$Oldname = ''
)
 Add-Type -AssemblyName System.Windows.Forms 
 Add-Type -AssemblyName System.Drawing 
 $MyForm = New-Object System.Windows.Forms.Form 
 $MyForm.Text="RenameComputer" 
 $MyForm.Size = New-Object System.Drawing.Size(400,200) 
  
        $mLabel1 = New-Object System.Windows.Forms.Label 
                $mLabel1.Text="New Computer name" 
                $mLabel1.Top="31" 
                $mLabel1.Left="8" 
                $mLabel1.Anchor="Left,Top" 
        $mLabel1.Size = New-Object System.Drawing.Size(125,23) 
        $MyForm.Controls.Add($mLabel1) 
         
        $mLabel2 = New-Object System.Windows.Forms.Label 
                $mLabel2.Text="User Name" 
                $mLabel2.Top="65" 
                $mLabel2.Left="8" 
                $mLabel2.Anchor="Left,Top" 
        $mLabel2.Size = New-Object System.Drawing.Size(125,23) 
        $MyForm.Controls.Add($mLabel2) 

        $mLabel3 = New-Object System.Windows.Forms.Label 
                $mLabel3.Text="Password" 
                $mLabel3.Top="95" 
                $mLabel3.Left="8" 
                $mLabel3.Anchor="Left,Top" 
        $mLabel3.Size = New-Object System.Drawing.Size(125,23) 
        $MyForm.Controls.Add($mLabel3) 
 
        $mTextBox1 = New-Object System.Windows.Forms.TextBox 
                $mTextBox1.Text="" 
                $mTextBox1.Top="29" 
                $mTextBox1.Left="139" 
                $mTextBox1.Anchor="Left,Top" 
        $mTextBox1.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mTextBox1) 


        $mTextBox2 = New-Object System.Windows.Forms.TextBox 
                $mTextBox2.Text="" 
                $mTextBox2.Top="63" 
                $mTextBox2.Left="139" 
                $mTextBox2.Anchor="Left,Top" 
        $mTextBox2.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mTextBox2) 

        $mTextBox3 = New-Object System.Windows.Forms.TextBox 
                $mTextBox3.Text="" 
                $mTextBox3.Top="97" 
                $mTextBox3.Left="139" 
                $mTextBox3.Anchor="Left,Top" 
                $mTextBox3.PasswordChar="*"
        $mTextBox3.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mTextBox3) 

        $mButton1 = New-Object System.Windows.Forms.Button 
                $mButton1.Text="Rename" 
                $mButton1.Top="125" 
                $mButton1.Left="85" 
                $mButton1.Anchor="Left,Top" 
        $mButton1.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mButton1) 

    #Add Button event 
    $mButton1.Add_Click(
        {    
		Try {
            $PWord = ConvertTo-SecureString -String $mTextBox3.Text -AsPlainText -Force
            $User = $mTextBox2.Text
            $Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord	
            Rename-Computer -ComputerName $Oldname -NewName $mTextBox1.Text -DomainCredential $Credential -PassThru -Restart -Force
            [System.Windows.Forms.MessageBox]::Show("Computer should be renamed and rebooted." , "Success")
            $Myform.Close()
            }
        Catch
            {
            [System.Windows.Forms.MessageBox]::Show("Rename Failed for some Reason." , "Fail")
            $Myform.Close()
            }
        }
    )


        $MyForm.ShowDialog()