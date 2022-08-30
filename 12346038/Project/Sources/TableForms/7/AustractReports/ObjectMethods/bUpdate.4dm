
// Valdiate and Save new FINTRAC information for the Company

checkInit
AUS_ValidateInfo

If (isValidationConfirmed)
	AUS_UpdateAusReportInfo
End if 
