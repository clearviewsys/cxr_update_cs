//%attributes = {}
// getWeekDayName (weekday) -> weekDay name

C_LONGINT:C283($1; $weekDay)
C_TEXT:C284($0; $weekDayStr)

Case of 
	: ($weekDay=1)
		$weekDayStr:="Sunday"
		
	: ($weekDay=2)
		$weekDayStr:="Monday"
	: ($weekDay=3)
		$weekDayStr:="Tuesday"
	: ($weekDay=4)
		$weekDayStr:="Wednesday"
	: ($weekDay=5)
		$weekDayStr:="Thursday"
	: ($weekDay=6)
		$weekDayStr:="Friday"
	: ($weekDay=7)
		$weekDayStr:="Saturday"
	Else 
		$weekDayStr:=""
		
End case 

$0:=$weekDayStr