//%attributes = {}
// checkIfNullString (->field;titleOfField;{WARN})

C_POINTER:C301($1)
C_TEXT:C284($2; $3)
Case of 
	: (Count parameters:C259=1)
		If ($1->="")
			checkAddError(Field name:C257($1)+" cannot be left blank.")
		End if 
		colourizeField($1; ($1->=""))
		
	: (Count parameters:C259=2)
		
		If ($1->="")
			checkAddError($2+" cannot be left blank.")
		End if 
		colourizeField($1; ($1->=""))
		
	: (Count parameters:C259=3)
		
		If ($1->="")
			checkAddWarning($2+" is left blank.")
		End if 
End case 