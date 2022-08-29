//%attributes = {}
// checkGreaterThan (->field;titleOfField;lowerBound)

C_POINTER:C301($1)
C_TEXT:C284($2; $4)
C_LONGINT:C283($3)

Case of 
	: (Count parameters:C259=3)
		If ($1-><=$3)
			checkAddError($2+" must be greater than "+String:C10($3))
		End if 
		
	: (Count parameters:C259=4)
		If ($1-><=$3)
			checkAddWarning($2+" is less than or equal to "+String:C10($3))
		End if 
End case 


