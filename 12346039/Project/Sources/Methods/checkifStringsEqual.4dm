//%attributes = {}
// checkifStringsEqual (->field;"fieldTitle";string;{warning})


C_POINTER:C301($1)
C_TEXT:C284($2; $3; $4)

Case of 
	: (Count parameters:C259=3)
		If ($1->#$3)
			checkAddError($2+" must be "+$3)
		End if 
		
	: (Count parameters:C259=4)
		If ($1->#$3)
			checkAddWarning($2+" is not "+$3)
		End if 
		
End case 


