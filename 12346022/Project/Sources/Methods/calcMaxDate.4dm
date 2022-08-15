//%attributes = {}
// Calc MaxDate (date1;date2) -> date
// returns the max of two date
//Unit test written @Marko

C_DATE:C307($1; $2; $0)

If ($1>$2)
	
	$0:=$1
	
Else 
	
	$0:=$2
	
End if 
