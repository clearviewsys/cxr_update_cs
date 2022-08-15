//%attributes = {}
//Calc BOYear ( Date ) -> Date
// returns the begining of the year as a date
// Unit Test @Zoya

C_DATE:C307($1; $0; $date; $BOY_date)
Case of 
	: (Count parameters:C259=0)
		$date:=Current date:C33
	: (Count parameters:C259=1)
		$date:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$BOY_date:=newDate(1; 1; Year of:C25($date))

$0:=$BOY_date
