//%attributes = {}
// selectRegistersForQuarter (quarter; {year})
// this method selects the registers in the month of m (passed as an int between 1-12)


C_LONGINT:C283($quarter; $1; $year; $2)

C_DATE:C307($fromDate; $toDate)


Case of 
	: (Count parameters:C259=1)
		$quarter:=$1
		$year:=Year of:C25(Current date:C33)
	: (Count parameters:C259=2)
		$quarter:=$1
		$year:=$2
	Else 
		$quarter:=4
		$year:=2015
End case 

Case of 
		
	: ($quarter=1)
		
		$fromDate:=makeDate(1; 1; $year)
		$toDate:=Add to date:C393(makeDate(1; 4; $year); 0; 0; -1)  // deduct 1 day from the day
		
	: ($quarter=2)
		
		$fromDate:=makeDate(1; 4; $year)
		$toDate:=Add to date:C393(makeDate(1; 7; $year); 0; 0; -1)  // deduct 1 day from the day
		
	: ($quarter=3)
		
		$fromDate:=makeDate(1; 7; $year)
		$toDate:=Add to date:C393(makeDate(1; 10; $year); 0; 0; -1)  // deduct 1 day from the day
		
	: ($quarter=4)
		
		$fromDate:=makeDate(1; 10; $year)
		$toDate:=Add to date:C393(makeDate(1; 1; $year+1); 0; 0; -1)  // deduct 1 day from the day
		
End case 


selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; $fromDate; $toDate)
