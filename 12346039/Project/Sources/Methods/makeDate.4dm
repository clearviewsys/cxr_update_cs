//%attributes = {}
// makeDate (day; month; year) -> returns a date
// see: this is duplicate for newDate
// this is a constructor for making a date out of three numbers

C_LONGINT:C283($day; $month; $year; $1; $2; $3)
C_DATE:C307($date; $0; $boy)

Case of 
	: (Count parameters:C259=3)
		$day:=$1
		$month:=$2
		$year:=$3
	Else 
		$day:=20
		$month:=10
		$year:=2011
End case 



$boy:=Date:C102("1/1/"+String:C10($year))
$date:=Add to date:C393($boy; 0; $month-1; $day-1)

$0:=$date

