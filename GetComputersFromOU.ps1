get-adcomputer -Filter {ObjectClass -Like "Computer"} -SearchBase 'OU=Desktops,OU=ranji,OU=Grad Students,OU=CCEE,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu' | Select Name | Export-Csv C:\Users\apsenn.admin\Desktop\ranjiidesktops.csv


get-adcomputer -Filter {ObjectClass -Like "Computer"} -SearchBase 'OU=Laptops,OU=Solar Center,OU=Staff,OU=COEDEAN,OU=COE,OU=NCSU,DC=wolftech,DC=ad,DC=ncsu,DC=edu'