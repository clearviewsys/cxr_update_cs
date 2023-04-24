//%attributes = {}
//Calc BOMonth ( Date ) -> Date
// returns the begining of the month for the date
// see also: calcEOMonth (date)

// Unit Test is written by @Zoya 

C_DATE:C307($1; $0)
C_DATE:C307($date; $bom; $boy)
C_LONGINT:C283($month)

Case of 
	: (Count parameters:C259=1)
		$date:=$1
	Else 
		$date:=Current date:C33
End case 

If ($date=!00-00-00!)
	$0:=$date
Else 
	$boy:=makeDate(1; 1; Year of:C25($date))  // jan 1st, of same year
	// now we need to add the number of months to that date
	$month:=Month of:C24($date)
	$bom:=Add to date:C393($boy; 0; $month-1; 0)
	$0:=$bom
End if 