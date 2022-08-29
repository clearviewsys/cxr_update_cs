//%attributes = {}
// getFirstWeekDayNumberOf (month, year) -> weekDay Number

C_LONGINT:C283($month; $year; $weekDay; $1; $2; $0)
$month:=$1
$year:=$2

$0:=Day number:C114(cal_getBOM_MY($month; $year))