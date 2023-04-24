//%attributes = {}
// cal_setCalendarDate ({date})
// cal_selCalendarDate () 

C_DATE:C307($1; $0; $date; cal_pickedDate)

Case of 
	: (Count parameters:C259=1)
		$date:=$1
	Else 
		$date:=Current date:C33
End case 

cal_setPickedDate($date)
$0:=$date
