//%attributes = {}
// FJ_HandleRenerateReportButton
ARRAY TEXT:C222(arrALLRegisterID; 0)
ARRAY TEXT:C222(arrALLEFT; 0)



checkInit
FJ_ValidateInfo
confirmProductionReport
If (isValidationConfirmed)
	FJ_GenerateFijiReport
	FJ_UpdateFijiReportInfo
End if 

