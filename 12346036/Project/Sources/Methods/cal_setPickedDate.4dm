//%attributes = {}
// setPickedDate (date)

C_DATE:C307($1; $date; $0)

Case of 
	: (Count parameters:C259=1)
		$date:=$1
		
		cal_pickedDate:=$date  // update private var
		cal_setCalendarDay(Day of:C23($date))
		cal_setCalendarMonth(Month of:C24($date))
		cal_setCalendarYear(Year of:C25($date))
End case 

$0:=$date