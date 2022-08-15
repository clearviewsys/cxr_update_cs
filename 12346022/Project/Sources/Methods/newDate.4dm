//%attributes = {}
// newDate (day: longint ; month: longint ; year: longint) : Date 
// constructor for creating a date by @tiran
// it's important to use a constructor when creating a date as you may not know !02/01/2000! is Feb 1st 2020 or 2nd of January 2020 

C_DATE:C307($date; $0)
C_LONGINT:C283($day; $month; $year; $1; $2; $3)

Case of 
	: (Count parameters:C259=0)  // default constructor
		$day:=Day of:C23(Current date:C33)
		$month:=Month of:C24(Current date:C33)
		$year:=Year of:C25(Current date:C33)
		
	: (Count parameters:C259=1)
		$day:=$1
		$month:=Month of:C24(Current date:C33)
		$year:=Year of:C25(Current date:C33)
		
	: (Count parameters:C259=2)
		$day:=$1
		$month:=$2
		$year:=Year of:C25(Current date:C33)
		
	: (Count parameters:C259=3)
		$day:=$1
		$month:=$2
		$year:=$3
		
	Else 
		$day:=Day of:C23(Current date:C33)
		$month:=Month of:C24(Current date:C33)
		$year:=Year of:C25(Current date:C33)
End case 


$date:=!00-00-00!
$date:=Add to date:C393($date; $year; $month; $day)
$0:=$date
