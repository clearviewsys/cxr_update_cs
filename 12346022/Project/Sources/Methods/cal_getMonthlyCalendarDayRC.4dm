//%attributes = {}
// method (weekRow, weekDayColumn, month, year )
// return the day of the monthly calendar of the specified row and column

C_LONGINT:C283($firstWeekDay; $weekRow; $weekDayColumn; $month; $year; $day; $1; $2; $3; $4; $0)

$weekRow:=$1  // range: 1 to 6
$weekDayColumn:=$2  // range: 1 to 7
$month:=$3  // range: 1 to 12
$year:=$4  // range: 1900 to 2100

$firstWeekDay:=cal_getFirstWeekDayNumberOf($month; $year)-1
$day:=($weekDayColumn+(($weekRow-1)*7))-$firstWeekDay

If (($day>cal_getNumberOfDaysInMonth($month; $year)) | ($day<1))
	$day:=0
End if 

$0:=$day
