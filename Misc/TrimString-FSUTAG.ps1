$Tag1 = "91253D"
$Tag2 = "91256I"
$Tag3 = "91290X"
$newtag1 = $Tag1.Substring($Tag1.Length -1)
$newtag2 = $Tag2.Substring($Tag1.Length -1)
$newtag3 = $Tag3.Substring($Tag1.Length -1)
$FSUTag1 = $Tag1.Substring(0,5)
$FSUTag2 = $Tag2.Substring(0,5)
$FSUTag3 = $Tag3.Substring(0,5)
Write-Host "FSU Tag = " $FSUTag1 " Purchase Code =" $newtag1
Write-Host "FSU Tag = " $FSUTag2 " Purchase Code =" $newtag2
Write-Host "FSU Tag = " $FSUTag3l " Purchase Code =" $newtag3
