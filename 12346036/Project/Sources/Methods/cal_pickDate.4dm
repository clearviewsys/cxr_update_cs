//%attributes = {}
// cal_pickDate (dateObject)
C_POINTER:C301($1; $datePtr)

$datePtr:=$1
If ($datePtr->=nullDate)
	cal_setCalendarDate(Current date:C33)
Else 
	cal_setCalendarDate($datePtr->)
End if 

launchCalendar_M
$datePtr->:=cal_getPickedDate
