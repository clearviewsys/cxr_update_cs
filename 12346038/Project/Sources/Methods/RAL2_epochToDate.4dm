//%attributes = {}
//RAL2_epochToDate
//Method to convert the date strings returned form the RAL server to a date
//Parameters: RAL server date string (eg "/Date(1590023767457)/"
//Output: Date represented by input


C_TEXT:C284($0; $1; $dateString)
C_TEXT:C284($epochString)
C_LONGINT:C283($start; $end)
C_REAL:C285($epochInt)


Case of 
	: (Count parameters:C259=1)
		$dateString:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Position:C15("Date"; $dateString)#0)
	$start:=Position:C15("e("; $dateString)
	$end:=Position:C15(")/"; $dateString)
	$epochString:=Substring:C12($dateString; $start+2; $end-($start+2))
	$epochInt:=Num:C11($epochString)
	$0:=epochToDate($epochInt)
End if 