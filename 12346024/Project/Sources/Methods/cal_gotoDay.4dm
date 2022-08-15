//%attributes = {}
// gotoday (dayNumber)

C_LONGINT:C283($pickedday; $1)
C_DATE:C307($date)

$pickedday:=$1
$date:=cal_getPickedDate
$date:=Add to date:C393($date; 0; 0; $pickedday-Day of:C23($date))
$date:=cal_setPickedDate($date)
cal_setCalendarDate($date)
