//%attributes = {}
// cal_Date (day, month, year)
// constructor to make a date

// use this method to make date objects instead of concatenating strings of '01/01'
// this is better to use since it is irrelevant of what date system the user is using

C_LONGINT:C283($1; $2; $3; $day; $month; $year)
C_DATE:C307($0; $date)

$day:=$1
$month:=$2
$year:=$3

$date:=Add to date:C393(!00-00-00!; $year; $month; $day)

$0:=$date