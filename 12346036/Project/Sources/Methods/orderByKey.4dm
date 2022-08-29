//%attributes = {}
// orderByKey(->[table]; {fieldNum1 {;fieldNum2}} )

// orders the table by its first field

C_POINTER:C301($1)
C_LONGINT:C283($2; $3)

Case of 
	: (Count parameters:C259=1)
		ORDER BY:C49($1->; Field:C253(Table:C252($1); 1)->)
	: (Count parameters:C259=2)
		ORDER BY:C49($1->; Field:C253(Table:C252($1); $2)->; >)
End case 
