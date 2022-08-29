//%attributes = {}
// gotoMonth (1 to 12)

C_LONGINT:C283($pickedMonth; $1)
C_DATE:C307($date)

$pickedMonth:=$1
$date:=cal_getPickedDate
$date:=Add to date:C393($date; 0; $pickedMonth-Month of:C24($date); 0)
$date:=cal_setPickedDate($date)
cal_setCalendarDate($date)
