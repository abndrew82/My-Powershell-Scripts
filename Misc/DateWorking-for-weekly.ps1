$DayofWeek = (Get-Date).Day
$31DayMonths = @('1',
'3',
'5',
'7',
'10',
'12'
)
$PreviousMonth = (Get-Date).Month
$PreviousMonth = $PreviousMonth - 1
#$DayofWeek = "14"
$Minus = $DayofWeek -7
Write-Host $DayofWeek
Write-Host $PreviousMonth
If ($PreviousMonth -notin $31DayMonths)
{
$DayofWeek = "30"
}
Elseif ($PreviousMonth -eq "2")
{
$DayofWeek = "28"
}
Else
{
$DayofWeek = "31"
}
Write-Host $DayofWeek
