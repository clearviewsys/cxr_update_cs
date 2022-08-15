//%attributes = {}
// selectRegistersForMonthOf (month; {year})
// this method selects the registers in the month of m (passed as an int between 1-12)


C_LONGINT:C283($month; $1; $year; $2)

C_DATE:C307($fromDate; $toDate)


Case of 
	: (Count parameters:C259=1)
		$month:=$1
		$year:=Year of:C25(Current date:C33)
	: (Count parameters:C259=2)
		$month:=$1
		$year:=$2
	Else 
		
End case 



$fromDate:=Add to date:C393(Date:C102("1/1/"+String:C10($year)); 0; $month-1; 0)  // add number of months-1 to jan 1st, of the same year
$toDate:=Add to date:C393($fromDate; 0; 1; -1)  // add a month minus 1 day

selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; $fromDate; $toDate)
