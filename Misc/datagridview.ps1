$form = New-Object System.Windows.Forms.Form 
$form.Size = New-Object System.Drawing.Size(900,600) 
$dataGridView = New-Object System.Windows.Forms.DataGridView 
$dataGridView.Size=New-Object System.Drawing.Size(800,400) 
$form.Controls.Add($dataGridView) 
#Create an unbound DataGridView by declaring a column count. 
$dataGridView.ColumnCount = 4 
$dataGridView.ColumnHeadersVisible = $true 
#Set the column header names. 
$dataGridView1.Columns[0].Name = "Recipe" 
$dataGridView1.Columns[1].Name = "Category" 
$dataGridView1.Columns[2].Name = "Third COlumn" 
$dataGridView1.Columns[3].Name = "Rating" 
#Populate the rows. 
$row1 = @("Meatloaf","Main Dish", "boringMeatloaf", "boringMeatloafRanking") 
$row2 = @("Key Lime Pie","Dessert", "lime juice evaporated milk", "****") 
$row3 = @("Orange-Salsa Pork Chops","Main Dish", "pork chops, salsa, orange juice", "****") 
$row4 = @("Black Bean and Rice Salad","Salad", "black beans, brown rice", "****") 
$row5 = @("Chocolate Cheesecake","Dessert", "cream cheese", "***") 
$row6 = @("Black Bean Dip", "Appetizer","black beans, sour cream", "***") 
$rows = @( $row1, $row2, $row3, $row4, $row5, $row6 ) 
foreach ($row in $rows){     $dataGridView.Rows.Add($row) } $form.ShowDialog() 