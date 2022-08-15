//%attributes = {}

ARRAY TEXT:C222(arrALLRegisterID; 0)
ARRAY TEXT:C222(arrALLEFT; 0)



checkInit
GAML_ValidateInfo
confirmProductionReport
If (isValidationConfirmed)
	GAMLGenerateReport
	GAML_UpdateGoAMLInfo  // Update the last information used
	FORM GOTO PAGE:C247(4)
	
End if 

