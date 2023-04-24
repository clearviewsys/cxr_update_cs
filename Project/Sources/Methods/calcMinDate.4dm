//%attributes = {}
// Calc MinDate (date1;date2) -> date
// return the smaller of two dates
//Unit test is written

C_DATE:C307($1; $2; $0)

If ($1<$2)
	
	$0:=$1
	
Else 
	
	$0:=$2
	
End if 
