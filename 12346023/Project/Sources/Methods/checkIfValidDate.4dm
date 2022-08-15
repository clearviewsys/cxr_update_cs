//%attributes = {}
// checkIfValidDateRange (->field;titleOfField)


C_POINTER:C301($1)
C_TEXT:C284($2; $3)

If ($1-><=!2000-01-01!)
	checkAddErrorOnTrue((Count parameters:C259=2); $2+" is not a valid date. ")
End if 
