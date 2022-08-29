//%attributes = {}
// FJ_HandleRenerateReportButton
ARRAY TEXT:C222(arrALLRegisterID; 0)
ARRAY TEXT:C222(arrALLEFT; 0)
CLEAR VARIABLE:C89(xmlFile)


checkInit
AUS_ValidateInfo
confirmProductionReportAUS

If (isValidationConfirmed)
	
	AUS_GenerateAusReport
	AUS_UpdateAusReportInfo
	FORM GOTO PAGE:C247(5)
	
End if 

