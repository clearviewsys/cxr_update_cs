//%attributes = {}
C_DATE:C307($date)
$date:=cal_getPickedDate
$date:=cal_setPickedDate(Add to date:C393($date; 0; 1; 0))
cal_setCalendarDate($date)