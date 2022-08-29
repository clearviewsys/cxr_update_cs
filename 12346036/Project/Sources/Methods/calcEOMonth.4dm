//%attributes = {}
//Calc EOMonth ( Date ) -> Date
// returns the end of the month for the date

C_DATE:C307($1; $0)
C_DATE:C307($date; $bom; $eom)
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
	$bom:=makeDate(1; Month of:C24($date); Year of:C25($date))  // the begining of the month
	// now we need to add the number of months to that date
	$0:=Add to date:C393($bom; 0; 1; -1)
End if 
