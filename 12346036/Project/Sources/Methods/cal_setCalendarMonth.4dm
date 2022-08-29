//%attributes = {}
// cal_setCalendarmonth (int)

C_LONGINT:C283($month; $1)
ARRAY TEXT:C222(cal_popupMonths; 12)

$month:=$1

If (($month>=1) & ($month<=12))
	cal_vMonth:=$month
	cal_popUpMonths:=$month
	
End if 

